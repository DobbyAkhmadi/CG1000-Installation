--
--  Copyright (C) 2012      secunet Security Networks AG
--  Copyright (C) 2012-2014 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2012-2014 Adrian-Ken Rueegsegger <ken@codelabs.ch>
--
--  This program is free software; you can redistribute it and/or modify it
--  under the terms of the GNU General Public License as published by the
--  Free Software Foundation; either version 2 of the License, or (at your
--  option) any later version.  See <http://www.fsf.org/copyleft/gpl.txt>.
--
--  This program is distributed in the hope that it will be useful, but
--  WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY
--  or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
--  for more details.
--
--  As a special exception, if other files instantiate generics from this
--  unit,  or  you  link  this  unit  with  other  files  to  produce  an
--  executable   this  unit  does  not  by  itself  cause  the  resulting
--  executable to  be  covered by the  GNU General  Public License.  This
--  exception does  not  however  invalidate  any  other reasons why  the
--  executable file might be covered by the GNU Public License.
--

with Interfaces.C;

with Anet.Errno;
with Anet.Constants;
with Anet.Sockets.Inet;
with Anet.Sockets.Thin.Netdev.Requests;

package body Anet.Sockets.Net_Ifaces is

   use Anet.Sockets.Thin.Netdev;
   use Anet.Sockets.Thin.Netdev.Requests;

   package C renames Interfaces.C;

   function Ioctl_Get
     (Socket     : C.int;
      Request    : Netdev_Request_Name;
      Iface_Name : Types.Iface_Name_Type)
      return If_Req_Type;
   --  Execute netdevice ioctl get request on interface with given name. The
   --  specified socket must have been created beforehand. The procedure
   --  returns the resulting interface request record to the caller.

   function Query_Iface
     (Iface_Name : Types.Iface_Name_Type;
      Request    : Netdev_Request_Name)
      return If_Req_Type;
   --  Query interface with given request.

   -------------------------------------------------------------------------

   function Get_Iface_Index (Name : Types.Iface_Name_Type) return Positive
   is
      Req : constant If_Req_Type := Query_Iface
        (Iface_Name => Name,
         Request    => If_Index);
   begin
      return Positive (Req.Ifr_Ifindex);
   end Get_Iface_Index;

   -------------------------------------------------------------------------

   function Get_Iface_IP (Name : Types.Iface_Name_Type) return IPv4_Addr_Type
   is
      Req : constant If_Req_Type := Query_Iface
        (Iface_Name => Name,
         Request    => If_Addr);

      --  The actual IP address is at range 3 .. 6. The first two bytes of the
      --  result are the sin_port value.

      Offset : constant := 2;
   begin
      return Result : IPv4_Addr_Type do
         for B in Result'Range loop
            Result (B) := Character'Pos
              (C.To_Ada
                 (Req.Ifr_Addr.Sa_Data
                    (C.size_t (B + Offset))));
         end loop;
      end return;
   end Get_Iface_IP;

   -------------------------------------------------------------------------

   function Get_Iface_Mac
     (Name : Types.Iface_Name_Type)
      return Hardware_Addr_Type
   is
      Req : constant If_Req_Type := Query_Iface
        (Iface_Name => Name,
         Request    => If_Hwaddr);
   begin
      return Result : Hardware_Addr_Type (1 .. 6) do
         for B in Result'Range loop
            Result (B) := Character'Pos
              (C.To_Ada
                 (Req.Ifr_Hwaddr.Sa_Data
                    (C.size_t (B))));
         end loop;
      end return;
   end Get_Iface_Mac;

   -------------------------------------------------------------------------

   function Ioctl_Get
     (Socket     : C.int;
      Request    : Netdev_Request_Name;
      Iface_Name : Types.Iface_Name_Type)
      return If_Req_Type
   is
      C_Name : constant C.char_array := C.To_C (String (Iface_Name));
      If_Req : aliased If_Req_Type (Name => Request);
   begin
      If_Req.Ifr_Name (1 .. C_Name'Length) := C_Name;
      Errno.Check_Or_Raise
        (Result  => C_Ioctl
           (S   => Socket,
            Req => Get_Requests (Request),
            Arg => If_Req'Access),
         Message => "Ioctl (" & Request'Img &
           ") failed on interface '" & String (Iface_Name) & "'");

      return If_Req;
   end Ioctl_Get;

   -------------------------------------------------------------------------

   function Is_Iface_Up (Name : Types.Iface_Name_Type) return Boolean
   is
      use type Interfaces.C.short;

      Req : constant If_Req_Type := Query_Iface
        (Iface_Name => Name,
         Request    => If_Flags);
   begin
      return (Req.Ifr_Flags mod 2) = Constants.IFF_UP;
   end Is_Iface_Up;

   -------------------------------------------------------------------------

   function Query_Iface
     (Iface_Name : Types.Iface_Name_Type;
      Request    : Netdev_Request_Name)
      return If_Req_Type
   is
      Req  : If_Req_Type;
      Sock : Sockets.Inet.UDPv4_Socket_Type;
   begin
      Sock.Init;

      begin
         Req := Ioctl_Get (Socket     => Socket_Type (Sock).Sock_FD,
                           Request    => Request,
                           Iface_Name => Iface_Name);

      exception
         when Socket_Error =>
            Sock.Close;
            raise;
      end;
      Sock.Close;

      return Req;
   end Query_Iface;

   -------------------------------------------------------------------------

   procedure Set_Iface_State
     (Name  : Types.Iface_Name_Type;
      State : Boolean)
   is
      Sock : Inet.UDPv4_Socket_Type;
      Res  : C.int;
   begin
      Sock.Init;

      declare
         C_Name : constant C.char_array := C.To_C (String (Name));
         Req    : aliased If_Req_Type (Name => If_Flags);
      begin
         Req.Ifr_Name (1 .. C_Name'Length) := C_Name;

         if State then
            Req.Ifr_Flags := Constants.IFF_UP;
         else
            Req.Ifr_Flags := 0;
         end if;

         Res := C_Ioctl
           (S   => Socket_Type (Sock).Sock_FD,
            Req => Set_Requests (If_Flags),
            Arg => Req'Access);
         Errno.Check_Or_Raise
           (Result  => Res,
            Message => "Ioctl (" & If_Flags'Img & ") failed on interface '" &
              String (Name) & "'");

      exception
         when Socket_Error =>
            Sock.Close;
            raise;
      end;
      Sock.Close;
   end Set_Iface_State;

end Anet.Sockets.Net_Ifaces;

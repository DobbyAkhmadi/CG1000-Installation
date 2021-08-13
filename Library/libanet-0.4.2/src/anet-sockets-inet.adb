--
--  Copyright (C) 2012-2013 secunet Security Networks AG
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

with Anet.Errno;
with Anet.Constants;
with Anet.OS_Constants;
with Anet.Sockets.Thin.Inet;
with Anet.Sockets.Net_Ifaces;
with Anet.Sockets.Inet.Iface;
with Anet.Byte_Swapping;

package body Anet.Sockets.Inet is

   package C renames Interfaces.C;

   use type Interfaces.C.unsigned_long;

   procedure Receive
     (Socket :     C.int;
      Src    : out Thin.Inet.Sockaddr_In_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset);
   --  Receive data from given inet socket. This procedure blocks until data
   --  has been received. Last is the index value such that Item (Last) is the
   --  last character assigned. An exception is raised if a socket error
   --  occurs or if no address information could be retrieved from the
   --  underlying protocol.

   -------------------------------------------------------------------------

   procedure Accept_Connection
     (Socket     :     TCPv4_Socket_Type;
      New_Socket : out TCPv4_Socket_Type)
   is
      Unreferenced : IPv4_Sockaddr_Type;
   begin
      Accept_Connection (Socket     => Socket,
                         New_Socket => New_Socket,
                         Src        => Unreferenced);
   end Accept_Connection;

   -------------------------------------------------------------------------

   procedure Accept_Connection
     (Socket     :     TCPv4_Socket_Type;
      New_Socket : out TCPv4_Socket_Type;
      Src        : out IPv4_Sockaddr_Type)
   is
      Res  : C.int;
      Sock : Thin.Inet.Sockaddr_In_Type
        (Family => Socket_Families.Family_Inet);
      Len  : aliased C.int := Sock'Size / 8;
   begin
      New_Socket.Sock_FD := -1;
      Src := (Addr => Any_Addr,
              Port => Any_Port);

      Res := Thin.C_Accept (S       => Socket.Sock_FD,
                            Name    => Sock'Address,
                            Namelen => Len'Access);

      case Check_Accept (Result => Res)
      is
         when Accept_Op_Aborted => return;
         when Accept_Op_Error =>
            raise Socket_Error with "Unable to accept connection on TCPv4 "
              & "socket - " & Errno.Get_Errno_String;
         when Accept_Op_Ok =>
            New_Socket.Sock_FD := Res;
            Src := (Addr => Sock.Sin_Addr,
                    Port => Byte_Swapping.Network_To_Host
                      (Input => Port_Type (Sock.Sin_Port)));
      end case;
   end Accept_Connection;

   -------------------------------------------------------------------------

   procedure Accept_Connection
     (Socket     :     TCPv6_Socket_Type;
      New_Socket : out TCPv6_Socket_Type)
   is
      Unreferenced : IPv6_Sockaddr_Type;
   begin
      Accept_Connection (Socket     => Socket,
                         New_Socket => New_Socket,
                         Src        => Unreferenced);
   end Accept_Connection;

   -------------------------------------------------------------------------

   procedure Accept_Connection
     (Socket     :     TCPv6_Socket_Type;
      New_Socket : out TCPv6_Socket_Type;
      Src        : out IPv6_Sockaddr_Type)
   is
      Res  : C.int;
      Sock : Thin.Inet.Sockaddr_In_Type
        (Family => Socket_Families.Family_Inet6);
      Len  : aliased C.int := Sock'Size / 8;
   begin
      New_Socket.Sock_FD := -1;
      Src := (Addr => Any_Addr_V6,
              Port => Any_Port);

      Res := Thin.C_Accept (S       => Socket.Sock_FD,
                            Name    => Sock'Address,
                            Namelen => Len'Access);

      case Check_Accept (Result => Res)
      is
         when Accept_Op_Aborted => return;
         when Accept_Op_Error =>
            raise Socket_Error with "Unable to accept connection on TCPv6 "
              & "socket - " & Errno.Get_Errno_String;
         when Accept_Op_Ok =>
            New_Socket.Sock_FD := Res;
            Src := (Addr => Sock.Sin6_Addr,
                    Port => Byte_Swapping.Network_To_Host
                      (Input => Port_Type (Sock.Sin_Port)));
      end case;
   end Accept_Connection;

   -------------------------------------------------------------------------

   procedure Bind
     (Socket : in out Inet_Socket_Type;
      Iface  :        Types.Iface_Name_Type)
   is
   begin
      Inet.Iface.Bind (Socket => Socket,
                       Iface  => Iface);
   end Bind;

   -------------------------------------------------------------------------

   procedure Bind
     (Socket     : in out IPv4_Socket_Type;
      Address    :        IPv4_Addr_Type := Any_Addr;
      Port       :        Port_Type;
      Reuse_Addr :        Boolean        := True)
   is
      Sockaddr : constant Thin.Inet.Sockaddr_In_Type
        := Thin.Inet.Create_Inet4 (Address => Address,
                                   Port    => Port);
   begin
      if Reuse_Addr then
         Socket.Set_Socket_Option
           (Option => Reuse_Address,
            Value  => True);
      end if;

      Errno.Check_Or_Raise
        (Result  => Thin.C_Bind
           (S       => Socket.Sock_FD,
            Name    => Sockaddr'Address,
            Namelen => Sockaddr'Size / 8),
         Message => "Unable to bind IPv4 socket to " & To_String
           (Address => Address) & "," & Port'Img);
   end Bind;

   -------------------------------------------------------------------------

   procedure Bind
     (Socket     : in out IPv6_Socket_Type;
      Address    :        IPv6_Addr_Type := Any_Addr_V6;
      Port       :        Port_Type;
      Reuse_Addr :        Boolean        := True)
   is
      Sockaddr : constant Thin.Inet.Sockaddr_In_Type
        := Thin.Inet.Create_Inet6 (Address => Address,
                                   Port    => Port);
   begin
      if Reuse_Addr then
         Socket.Set_Socket_Option
           (Option => Reuse_Address,
            Value  => True);
      end if;

      Errno.Check_Or_Raise
        (Result  => Thin.C_Bind
           (S       => Socket.Sock_FD,
            Name    => Sockaddr'Address,
            Namelen => Sockaddr'Size / 8),
         Message => "Unable to bind IPv6 socket to " & To_String
           (Address => Address) & "," & Port'Img);
   end Bind;

   -------------------------------------------------------------------------

   procedure Connect
     (Socket  : in out TCPv4_Socket_Type;
      Address :        IPv4_Addr_Type;
      Port    :        Port_Type)
   is
      Dst : constant Thin.Inet.Sockaddr_In_Type := Thin.Inet.Create_Inet4
        (Address => Address,
         Port    => Port);
   begin
      Errno.Check_Or_Raise
        (Result  => Thin.C_Connect
           (S       => Socket.Sock_FD,
            Name    => Dst'Address,
            Namelen => Dst'Size / 8),
         Message => "Unable to connect socket to address " & To_String
           (Address => Address) & " (" & Port'Img & " )");
   end Connect;

   -------------------------------------------------------------------------

   procedure Connect
     (Socket  : in out TCPv6_Socket_Type;
      Address :        IPv6_Addr_Type;
      Port    :        Port_Type)
   is
      Dst : constant Thin.Inet.Sockaddr_In_Type := Thin.Inet.Create_Inet6
        (Address => Address,
         Port    => Port);
   begin
      Errno.Check_Or_Raise
        (Result  => Thin.C_Connect
           (S       => Socket.Sock_FD,
            Name    => Dst'Address,
            Namelen => Dst'Size / 8),
         Message => "Unable to connect socket to address " & To_String
           (Address => Address) & " (" & Port'Img & " )");
   end Connect;

   -------------------------------------------------------------------------

   procedure Init (Socket : in out UDPv4_Socket_Type)
   is
   begin
      Init (Socket => Socket,
            Family => Socket_Families.Family_Inet,
            Mode   => Datagram_Socket);
   end Init;

   -------------------------------------------------------------------------

   procedure Init (Socket : in out TCPv4_Socket_Type)
   is
   begin
      Init (Socket => Socket,
            Family => Socket_Families.Family_Inet,
            Mode   => Stream_Socket);
   end Init;

   -------------------------------------------------------------------------

   procedure Init (Socket : in out UDPv6_Socket_Type)
   is
   begin
      Init (Socket => Socket,
            Family => Socket_Families.Family_Inet6,
            Mode   => Datagram_Socket);
   end Init;

   -------------------------------------------------------------------------

   procedure Init (Socket : in out TCPv6_Socket_Type)
   is
   begin
      Init (Socket => Socket,
            Family => Socket_Families.Family_Inet6,
            Mode   => Stream_Socket);
   end Init;

   -------------------------------------------------------------------------

   procedure Join_Multicast_Group
     (Socket : UDPv4_Socket_Type;
      Group  : IPv4_Addr_Type;
      Iface  : Types.Iface_Name_Type := "")
   is
      Mreq       : Thin.IPv4_Mreq_Type;
      Iface_Addr : IPv4_Addr_Type := Any_Addr;
   begin
      if Iface'Length > 0 then
         Iface_Addr := Net_Ifaces.Get_Iface_IP (Name => Iface);
      end if;

      Mreq.Imr_Multiaddr := Group;
      Mreq.Imr_Interface := Iface_Addr;

      Errno.Check_Or_Raise
        (Result  => Thin.C_Setsockopt
           (S       => Socket.Sock_FD,
            Level   => Constants.Sys.IPPROTO_IP,
            Optname => Constants.Sys.IP_ADD_MEMBERSHIP,
            Optval  => Mreq'Address,
            Optlen  => Mreq'Size / 8),
         Message => "Unable to join multicast group " & To_String
           (Address => Group));
   end Join_Multicast_Group;

   -------------------------------------------------------------------------

   procedure Join_Multicast_Group
     (Socket : UDPv6_Socket_Type;
      Group  : IPv6_Addr_Type;
      Iface  : Types.Iface_Name_Type := "")
   is
      Mreq6     : Thin.IPv6_Mreq_Type;
      Iface_Idx : Natural := 0;
   begin
      if Iface'Length > 0 then
         Iface_Idx := Net_Ifaces.Get_Iface_Index (Name => Iface);
      end if;

      Mreq6.IPv6mr_Multiaddr := Group;
      Mreq6.IPv6mr_Interface := C.unsigned (Iface_Idx);

      Errno.Check_Or_Raise
        (Result  => Thin.C_Setsockopt
           (S       => Socket.Sock_FD,
            Level   => Constants.IPPROTO_IPV6,
            Optname => OS_Constants.IPV6_ADD_MEMBERSHIP,
            Optval  => Mreq6'Address,
            Optlen  => Mreq6'Size / 8),
         Message => "Unable to join multicast group " & To_String
           (Address => Group));
   end Join_Multicast_Group;

   -------------------------------------------------------------------------

   procedure Multicast_Set_Sending_Interface
     (Socket     : UDPv4_Socket_Type;
      Iface_Addr : IPv4_Addr_Type)
   is
   begin
      Errno.Check_Or_Raise
        (Result  => Thin.C_Setsockopt
           (S       => Socket.Sock_FD,
            Level   => Constants.Sys.IPPROTO_IP,
            Optname => Constants.Sys.IP_MULTICAST_IF,
            Optval  => Iface_Addr'Address,
            Optlen  => Iface_Addr'Length),
         Message => "Unable to set sending multicast interface " &
           "with address " & To_String (Iface_Addr) & "'");
   end Multicast_Set_Sending_Interface;

   -------------------------------------------------------------------------

   procedure Multicast_Set_Sending_Interface
     (Socket : UDPv6_Socket_Type;
      Iface  : Types.Iface_Name_Type)
   is
      Iface_Idx : constant Natural
        := Net_Ifaces.Get_Iface_Index (Name => Iface);
   begin
      Errno.Check_Or_Raise
        (Result  => Thin.C_Setsockopt
        (S       => Socket.Sock_FD,
         Level   => Constants.IPPROTO_IPV6,
         Optname => OS_Constants.IPV6_MULTICAST_IF,
         Optval  => Iface_Idx'Address,
         Optlen  => Iface_Idx'Size / 8),
         Message => "Unable set sending multicast interface to " &
           String (Iface));
   end Multicast_Set_Sending_Interface;

   -------------------------------------------------------------------------

   procedure Receive
     (Socket :     C.int;
      Src    : out Thin.Inet.Sockaddr_In_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset)
   is
      use type Ada.Streams.Stream_Element_Offset;
      use type Interfaces.C.long;

      Res : C.long;
      Len : aliased C.int := Src'Size / 8;
   begin
      Last := 0;

      Res := Thin.C_Recvfrom (S       => Socket,
                              Msg     => Item'Address,
                              Len     => Item'Length,
                              Flags   => 0,
                              From    => Src'Address,
                              Fromlen => Len'Access);

      case Check_Receive (Result => Res)
      is
         when Recv_Op_Orderly_Shutdown | Recv_Op_Aborted => return;
         when Recv_Op_Error =>
            raise Socket_Error with "Error receiving data from inet socket: "
              & Errno.Get_Errno_String;
         when Recv_Op_Ok =>
            if Len = 0 then
               raise Socket_Error with "No address information received";
            end if;

            Last := Item'First + Ada.Streams.Stream_Element_Offset (Res - 1);
      end case;
   end Receive;

   -------------------------------------------------------------------------

   procedure Receive
     (Socket :     UDPv4_Socket_Type;
      Src    : out IPv4_Sockaddr_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset)
   is
      Sockaddr : Thin.Inet.Sockaddr_In_Type
        (Family => Socket_Families.Family_Inet);
   begin
      Receive (Socket => Socket.Sock_FD,
               Src    => Sockaddr,
               Item   => Item,
               Last   => Last);

      Src.Addr := Sockaddr.Sin_Addr;
      Src.Port := Byte_Swapping.Network_To_Host
        (Input => Port_Type (Sockaddr.Sin_Port));
   end Receive;

   -------------------------------------------------------------------------

   procedure Receive
     (Socket :     UDPv6_Socket_Type;
      Src    : out IPv6_Sockaddr_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset)
   is
      Sockaddr : Thin.Inet.Sockaddr_In_Type
        (Family => Socket_Families.Family_Inet6);
   begin
      Receive (Socket => Socket.Sock_FD,
               Src    => Sockaddr,
               Item   => Item,
               Last   => Last);

      Src.Addr := Sockaddr.Sin6_Addr;
      Src.Port := Byte_Swapping.Network_To_Host
        (Input => Port_Type (Sockaddr.Sin_Port));
   end Receive;

   -------------------------------------------------------------------------

   procedure Send
     (Socket   : IPv4_Socket_Type;
      Item     : Ada.Streams.Stream_Element_Array;
      Dst_Addr : IPv4_Addr_Type;
      Dst_Port : Port_Type)
   is
      Res : C.long;
      Dst : constant Thin.Inet.Sockaddr_In_Type := Thin.Inet.Create_Inet4
        (Address => Dst_Addr,
         Port    => Dst_Port);
   begin
      Res := Thin.C_Sendto
        (S     => Socket.Sock_FD,
         Buf   => Item'Address,
         Len   => Item'Length,
         Flags => Constants.Sys.MSG_NOSIGNAL,
         To    => Dst'Address,
         Tolen => Dst'Size / 8);

      Errno.Check_Or_Raise
        (Result  => C.int (Res),
         Message => "Error sending data to " &
           To_String (Address => Dst_Addr) & "," & Dst_Port'Img);
      Check_Complete_Send
        (Item      => Item,
         Result    => Res,
         Error_Msg => "Incomplete send operation to " &
           To_String (Address => Dst_Addr) & "," & Dst_Port'Img);
   end Send;

   -------------------------------------------------------------------------

   procedure Send
     (Socket   : IPv6_Socket_Type;
      Item     : Ada.Streams.Stream_Element_Array;
      Dst_Addr : IPv6_Addr_Type;
      Dst_Port : Port_Type)
   is
      Res : C.long;
      Dst : constant Thin.Inet.Sockaddr_In_Type := Thin.Inet.Create_Inet6
        (Address => Dst_Addr,
         Port    => Dst_Port);
   begin
      Res := Thin.C_Sendto
        (S     => Socket.Sock_FD,
         Buf   => Item'Address,
         Len   => Item'Length,
         Flags => Constants.Sys.MSG_NOSIGNAL,
         To    => Dst'Address,
         Tolen => Dst'Size / 8);

      Errno.Check_Or_Raise
        (Result  => C.int (Res),
         Message => "Error sending data to " &
           To_String (Address => Dst_Addr) & "," & Dst_Port'Img);
      Check_Complete_Send
        (Item      => Item,
         Result    => Res,
         Error_Msg => "Incomplete send operation to " &
           To_String (Address => Dst_Addr) & "," & Dst_Port'Img);
   end Send;

end Anet.Sockets.Inet;

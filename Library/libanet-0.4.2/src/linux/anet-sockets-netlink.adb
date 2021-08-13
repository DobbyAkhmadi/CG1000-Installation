--
--  Copyright (C) 2012-2013 secunet Security Networks AG
--  Copyright (C) 2012-2013 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2012-2013 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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
with Anet.OS_Constants;
with Anet.Sockets.Thin.Netlink;

package body Anet.Sockets.Netlink is

   package C renames Interfaces.C;

   Protocols : constant array (Protocol_Type) of Double_Byte
     := (Proto_Netlink_Route     => OS_Constants.NETLINK_ROUTE,
         Proto_Netlink_Firewall  => OS_Constants.NETLINK_FIREWALL,
         Proto_Netlink_Inet_Diag => OS_Constants.NETLINK_INET_DIAG,
         Proto_Netlink_Nflog     => OS_Constants.NETLINK_NFLOG,
         Proto_Netlink_Xfrm      => OS_Constants.NETLINK_XFRM,
         Proto_Netlink_Selinux   => OS_Constants.NETLINK_SELINUX,
         Proto_Netlink_Audit     => OS_Constants.NETLINK_AUDIT,
         Proto_Netlink_Netfilter => OS_Constants.NETLINK_NETFILTER,
         Proto_Netlink_Crypto    => OS_Constants.NETLINK_CRYPTO);
   --  Netlink protocol mapping.

   -------------------------------------------------------------------------

   procedure Bind
     (Socket  : in out Netlink_Socket_Type;
      Address :        Netlink_Addr_Type;
      Groups  :        Group_Array := No_Groups)
   is
      use type Interfaces.Unsigned_32;
      use type Interfaces.C.unsigned_long;

      Value : Thin.Netlink.Sockaddr_Nl_Type
        := (Nl_Pid => Interfaces.Unsigned_32 (Address),
            others => <>);
   begin
      if Groups /= No_Groups then
         for G in Groups'Range loop
            Value.Nl_Groups := Value.Nl_Groups
              or Interfaces.Shift_Left
                (Value  => 1,
                 Amount => Natural (Group_Type'Pos (Groups (G)) - 1));
         end loop;
      end if;

      Errno.Check_Or_Raise
        (Result  => Thin.C_Bind
           (S       => Socket.Sock_FD,
            Name    => Value'Address,
            Namelen => Value'Size / 8),
         Message => "Unable to bind Netlink socket");
   end Bind;

   -------------------------------------------------------------------------

   procedure Init
     (Socket   : in out Raw_Socket_Type;
      Protocol :        Protocol_Type)
   is
   begin
      Init (Socket   => Socket,
            Family   => Socket_Families.Family_Netlink,
            Mode     => Raw_Socket,
            Protocol => Protocols (Protocol));
   end Init;

   -------------------------------------------------------------------------

   procedure Receive
     (Socket :     Netlink_Socket_Type;
      Src    : out Netlink_Addr_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset)
   is
      use type Ada.Streams.Stream_Element_Offset;
      use type Interfaces.C.long;

      Res   : C.long;
      Saddr : Thin.Netlink.Sockaddr_Nl_Type;
      Len   : aliased C.int := Saddr'Size / 8;
   begin
      Src  := 0;
      Last := 0;

      Res := Thin.C_Recvfrom (S       => Socket.Sock_FD,
                              Msg     => Item'Address,
                              Len     => Item'Length,
                              Flags   => 0,
                              From    => Saddr'Address,
                              Fromlen => Len'Access);

      case Check_Receive (Result => Res)
      is
         when Recv_Op_Orderly_Shutdown | Recv_Op_Aborted => return;
         when Recv_Op_Error =>
            raise Socket_Error with "Error receiving data from Netlink"
              & " socket: " & Errno.Get_Errno_String;
         when Recv_Op_Ok =>
            Src  := Netlink_Addr_Type (Saddr.Nl_Pid);
            Last := Item'First + Ada.Streams.Stream_Element_Offset (Res - 1);
      end case;
   end Receive;

   -------------------------------------------------------------------------

   procedure Send
     (Socket : Netlink_Socket_Type;
      Item   : Ada.Streams.Stream_Element_Array;
      To     : Netlink_Addr_Type)
   is
      use type Interfaces.C.unsigned_long;

      Res : C.long;
      Dst : Thin.Netlink.Sockaddr_Nl_Type
        := (Nl_Pid => Interfaces.Unsigned_32 (To),
            others => <>);
   begin
      Res := Thin.C_Sendto
        (S     => Socket.Sock_FD,
         Buf   => Item'Address,
         Len   => Item'Length,
         Flags => 0,
         To    => Dst'Address,
         Tolen => Dst'Size / 8);

      Errno.Check_Or_Raise
        (Result  => C.int (Res),
         Message => "Unable to send data on Netlink socket");
      Check_Complete_Send
        (Item      => Item,
         Result    => Res,
         Error_Msg => "Incomplete Netlink send operation");
   end Send;

end Anet.Sockets.Netlink;

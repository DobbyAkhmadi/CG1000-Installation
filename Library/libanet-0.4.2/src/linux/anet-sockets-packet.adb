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
with Anet.Sockets.Net_Ifaces;
with Anet.Sockets.Thin.Packet;
with Anet.Constants;
with Anet.Byte_Swapping;

package body Anet.Sockets.Packet is

   package C renames Interfaces.C;

   Protocols : constant array (Protocol_Type) of Double_Byte
     := (Proto_Packet_Arp => Constants.ETH_P_ARP,
         Proto_Packet_Ip  => Constants.ETH_P_IP,
         Proto_Packet_All => Constants.ETH_P_ALL);
   --  Packet protocol mapping.

   -------------------------------------------------------------------------

   procedure Bind
     (Socket : in out Packet_Socket_Type;
      Iface  :        Types.Iface_Name_Type)
   is
      use type Interfaces.C.unsigned_long;

      Value : Thin.Packet.Sockaddr_Ll_Type;
   begin
      Value.Sa_Protocol := C.unsigned_short (Socket.Protocol);
      Value.Sa_Ifindex  := C.int (Net_Ifaces.Get_Iface_Index (Name => Iface));

      Errno.Check_Or_Raise
        (Result  => Thin.C_Bind
           (S       => Socket.Sock_FD,
            Name    => Value'Address,
            Namelen => Value'Size / 8),
         Message => "Unable to bind packet socket to interface " &
           String (Iface));
   end Bind;

   -------------------------------------------------------------------------

   procedure Init
     (Socket   : in out UDP_Socket_Type;
      Protocol :        Protocol_Type := Proto_Packet_Ip)
   is
   begin
      Init (Socket   => Socket,
            Family   => Socket_Families.Family_Packet,
            Mode     => Datagram_Socket,
            Protocol => Byte_Swapping.Host_To_Network
              (Input => Protocols (Protocol)));
   end Init;

   -------------------------------------------------------------------------

   procedure Init
     (Socket   : in out Raw_Socket_Type;
      Protocol :        Protocol_Type := Proto_Packet_All)
   is
   begin
      Init (Socket   => Socket,
            Family   => Socket_Families.Family_Packet,
            Mode     => Raw_Socket,
            Protocol => Byte_Swapping.Host_To_Network
              (Input => Protocols (Protocol)));
   end Init;

   -------------------------------------------------------------------------

   procedure Receive
     (Socket :     Packet_Socket_Type;
      Src    : out Hardware_Addr_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset)
   is
      use type Ada.Streams.Stream_Element_Offset;
      use type Interfaces.C.long;

      Res   : C.long;
      Saddr : Thin.Packet.Sockaddr_Ll_Type;
      Len   : aliased C.int := Saddr'Size / 8;
   begin
      Src  := (others => 0);
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
            raise Socket_Error with "Error receiving packet data: "
              & Errno.Get_Errno_String;
         when Recv_Op_Ok =>
            Src  := Saddr.Sa_Addr (Saddr.Sa_Addr'First .. Src'Length);
            Last := Item'First + Ada.Streams.Stream_Element_Offset (Res - 1);
      end case;
   end Receive;

   -------------------------------------------------------------------------

   procedure Send
     (Socket : Packet_Socket_Type;
      Item   : Ada.Streams.Stream_Element_Array;
      To     : Hardware_Addr_Type;
      Iface  : Types.Iface_Name_Type)
   is
      use type Interfaces.C.unsigned_long;

      Res     : C.long;
      Ll_Dest : Thin.Packet.Sockaddr_Ll_Type;
   begin
      Ll_Dest.Sa_Ifindex  := C.int (Net_Ifaces.Get_Iface_Index
                                    (Name => Iface));
      Ll_Dest.Sa_Halen    := To'Length;
      Ll_Dest.Sa_Protocol := C.unsigned_short (Socket.Protocol);

      Ll_Dest.Sa_Addr (1 .. To'Length) := To;

      Res := Thin.C_Sendto
        (S     => Socket.Sock_FD,
         Buf   => Item'Address,
         Len   => Item'Length,
         Flags => 0,
         To    => Ll_Dest'Address,
         Tolen => Ll_Dest'Size / 8);

      Errno.Check_Or_Raise
        (Result  => C.int (Res),
         Message => "Unable to send packet data on interface " &
           String (Iface) & " to " & To_String (Address => To));
      Check_Complete_Send
        (Item      => Item,
         Result    => Res,
         Error_Msg => "Incomplete packet send operation to " &
           To_String (Address => To));
   end Send;

end Anet.Sockets.Packet;

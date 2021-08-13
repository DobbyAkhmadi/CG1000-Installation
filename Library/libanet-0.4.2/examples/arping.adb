--
--  Copyright (C) 2018 secunet Security Networks AG
--  Copyright (C) 2018 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2018 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Ada.Streams;
with Ada.Text_IO;
with Ada.Command_Line;

with Anet.ARP;
with Anet.Types;
with Anet.Sockets.Packet;
with Anet.Sockets.Net_Ifaces;
with Anet.Receivers.Datagram;

--  Usage: ./arping <iface> <IP>
procedure Arping
is
   package Arp_Receiver is new Anet.Receivers.Datagram
     (Socket_Type  => Anet.Sockets.Packet.UDP_Socket_Type,
      Address_Type => Anet.Ether_Addr_Type,
      Receive      => Anet.Sockets.Packet.Receive);

   Iface : constant Anet.Types.Iface_Name_Type
     := Anet.Types.Iface_Name_Type (Ada.Command_Line.Argument (Number => 1));
   --  Interface to bind to.

   Dst_IP : constant Anet.IPv4_Addr_Type
     := Anet.To_IPv4_Addr (Str => Ada.Command_Line.Argument (Number => 2));
   --  Address to ping.

   My_Ether_Addr : constant Anet.Ether_Addr_Type
     := Anet.Sockets.Net_Ifaces.Get_Iface_Mac (Name => Iface);
   --  My hardware address.

   procedure Handle_Reply
     (Buffer : Ada.Streams.Stream_Element_Array;
      Src    : Anet.Ether_Addr_Type);
   --  Handle ARP reply packet.

   -------------------------------------------------------------------------

   procedure Handle_Reply
     (Buffer : Ada.Streams.Stream_Element_Array;
      Src    : Anet.Ether_Addr_Type)
   is
      use type Ada.Streams.Stream_Element_Offset;
      use type Anet.IPv4_Addr_Type;
      use type Anet.Hardware_Addr_Type;
      use type Anet.ARP.Operation_Type;

      Hdr : constant Anet.ARP.Header_Type
        := Anet.ARP.To_Header
          (Buffer => Buffer
             (Buffer'First .. Buffer'First + Anet.ARP.ARP_Header_Length - 1));
   begin
      if Hdr.Operation = Anet.ARP.ARP_Reply
        and then Hdr.Src_IP = Dst_IP
        and then Hdr.Dst_Ether = My_Ether_Addr
      then
         Ada.Text_IO.Put_Line ("Reply from " & Anet.To_String
                               (Address => Hdr.Src_IP)
                               & " [" & Anet.To_String
                                 (Address => Src) & "]");
      end if;
   end Handle_Reply;

   Socket   : aliased Anet.Sockets.Packet.UDP_Socket_Type;
   Receiver : Arp_Receiver.Receiver_Type (S => Socket'Access);
   My_IP    : constant Anet.IPv4_Addr_Type
     := Anet.Sockets.Net_Ifaces.Get_Iface_IP (Name => Iface);
begin
   Socket.Init (Protocol => Anet.Sockets.Packet.Proto_Packet_Arp);
   Socket.Bind (Iface => Iface);
   Receiver.Listen (Callback => Handle_Reply'Access);

   Ada.Text_IO.Put_Line (Item => "ARPING "
                         & Anet.To_String (Address => Dst_IP) & " from "
                         & Anet.To_String (Address => My_IP) & " "
                         & String (Iface));
   loop
      Socket.Send (Item  => Anet.ARP.To_Stream
                   (Header =>
                      (Operation => Anet.ARP.ARP_Request,
                       Src_Ether => My_Ether_Addr,
                       Src_IP    => My_IP,
                       Dst_Ether => (others => 0),
                       Dst_IP    => Dst_IP)),
                   To    => Anet.Bcast_HW_Addr,
                   Iface => Iface);
      delay 1.0;
   end loop;
end Arping;

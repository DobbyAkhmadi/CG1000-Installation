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

with Anet.Types;

package Anet.Sockets.Packet is

   type Protocol_Type is
     (Proto_Packet_Arp,
      Proto_Packet_Ip,
      Proto_Packet_All);
   --  Packet protocols.

   type Packet_Socket_Type is abstract new Socket_Type with private;
   --  Packet socket.

   procedure Bind
     (Socket : in out Packet_Socket_Type;
      Iface  :        Types.Iface_Name_Type);
   --  Bind given packet socket to specified interface.

   procedure Send
     (Socket : Packet_Socket_Type;
      Item   : Ada.Streams.Stream_Element_Array;
      To     : Hardware_Addr_Type;
      Iface  : Types.Iface_Name_Type);
   --  Send data on packet socket to given hardware address over interface
   --  specified by name.

   procedure Receive
     (Socket :     Packet_Socket_Type;
      Src    : out Hardware_Addr_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset);
   --  Receive data from given packet socket. Last is the index value which
   --  designates the last stream element in data. The source hardware address
   --  specifies the MAC of the packet sender.

   type UDP_Socket_Type is new Packet_Socket_Type
     and Dgram_Socket_Type with private;
   --  Packet socket in datagram mode.

   procedure Init
     (Socket   : in out UDP_Socket_Type;
      Protocol :        Protocol_Type := Proto_Packet_Ip);
   --  Initialize given Packet/UDP socket.

   type Raw_Socket_Type is new Packet_Socket_Type
     and Dgram_Socket_Type with private;
   --  Packet socket in raw mode (link level headers not stripped). Behaves
   --  like a datagram socket from an interface perspective.

   procedure Init
     (Socket   : in out Raw_Socket_Type;
      Protocol :        Protocol_Type := Proto_Packet_All);
   --  Initialize given Packet/Raw socket.

private

   type Packet_Socket_Type is abstract new Socket_Type with null record;

   type UDP_Socket_Type is new Packet_Socket_Type
     and Dgram_Socket_Type with null record;

   type Raw_Socket_Type is new Packet_Socket_Type
     and Dgram_Socket_Type with null record;

end Anet.Sockets.Packet;

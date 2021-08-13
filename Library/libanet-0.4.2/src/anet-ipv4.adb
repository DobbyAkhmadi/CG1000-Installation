--
--  Copyright (C) 2011, 2012 secunet Security Networks AG
--  Copyright (C) 2011, 2012 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2011, 2012 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with System;

with Anet.Byte_Swapping;
with Anet.Constants;
with Anet.Util;
with Anet.UDP;

package body Anet.IPv4 is

   type Four_Bit_Type is range 0 .. 15;
   for Four_Bit_Type'Size use 4;

   type Raw_IP_Hdr_Type is record
      Version  : Four_Bit_Type;
      IHL      : Four_Bit_Type;
      TOS      : Byte;
      TL       : Double_Byte;
      ID       : Double_Byte;
      Frag_Off : Double_Byte;
      TTL      : Byte;
      Protocol : Byte;
      Checksum : Double_Byte;
      Saddr    : IPv4_Addr_Type;
      Daddr    : IPv4_Addr_Type;
   end record;
   --  Raw IP header.

   --  The following bit-order magic is taken from [1] to achieve endian
   --  independent record representation.
   --
   --  [1] - Randal P. Andress, "Wholesale Byte Reversal of the Outermost Ada
   --        Record Object to Achieve Endian Independence for Communicated Data
   --        Types", Northrop Grumman Corporation, September 2005.

   use type System.Bit_Order;

   Rightward_One_Bit : constant := 1 - 2 * Boolean'Pos
     (System.Default_Bit_Order = System.Low_Order_First);

   F1 : constant := (Rightward_One_Bit + 1) / 2;
   F2 : constant := (Rightward_One_Bit - 1) / 2;

   MSB8 : constant := Boolean'Pos
     (System.Default_Bit_Order = System.Low_Order_First) * 7;

   for Raw_IP_Hdr_Type use record
      Version  at  0 range MSB8 + 0 * F1 + 3 * F2 .. MSB8 + 3 * F1 + 0 * F2;
      IHL      at  0 range MSB8 + 4 * F1 + 7 * F2 .. MSB8 + 7 * F1 + 4 * F2;
      TOS      at  1 range 0 .. 7;
      TL       at  2 range 0 .. 15;
      ID       at  4 range 0 .. 15;
      Frag_Off at  6 range 0 .. 15;
      TTL      at  8 range 0 .. 7;
      Protocol at  9 range 0 .. 7;
      Checksum at 10 range 0 .. 15;
      Saddr    at 12 range 0 .. 31;
      Daddr    at 16 range 0 .. 31;
   end record;

   for Raw_IP_Hdr_Type'Size use 160;
   for Raw_IP_Hdr_Type'Alignment use 1;

   use type Ada.Streams.Stream_Element_Offset;

   subtype Raw_IP_Hdr_Buffer_Type is
     Ada.Streams.Stream_Element_Array (1 .. IP_Header_Length);

   -------------------------------------------------------------------------

   function Create_Header
     (Payload : Ada.Streams.Stream_Element_Array;
      Src_IP  : IPv4_Addr_Type;
      Dst_IP  : IPv4_Addr_Type)
      return Ada.Streams.Stream_Element_Array
   is
      Hdr_Buffer : Raw_IP_Hdr_Buffer_Type;
      IP_Header  : Raw_IP_Hdr_Type;
      for IP_Header'Address use Hdr_Buffer'Address;
   begin
      IP_Header.Version  := 4;
      IP_Header.IHL      := 5;
      IP_Header.TOS      := 0;
      IP_Header.TL       := Byte_Swapping.Host_To_Network
        (Input => Payload'Length + Hdr_Buffer'Length);
      IP_Header.ID       := 0;
      IP_Header.Frag_Off := 0;
      IP_Header.TTL      := 64;
      IP_Header.Protocol := Constants.Sys.IPPROTO_UDP;
      IP_Header.Checksum := 0;
      IP_Header.Saddr    := Src_IP;
      IP_Header.Daddr    := Dst_IP;

      IP_Header.Checksum := Byte_Swapping.Host_To_Network
        (Input => Util.Calculate_One_Complement (Data => Hdr_Buffer));

      return Hdr_Buffer;
   end Create_Header;

   -------------------------------------------------------------------------

   function Create_Packet
     (Payload  : Ada.Streams.Stream_Element_Array;
      Src_IP   : IPv4_Addr_Type;
      Src_Port : Port_Type;
      Dst_IP   : IPv4_Addr_Type;
      Dst_Port : Port_Type)
      return Ada.Streams.Stream_Element_Array
   is
      use Ada.Streams;

      subtype IP_Hdr_Offset  is Stream_Element_Offset range  1 .. 20;
      subtype UDP_Hdr_Offset is Stream_Element_Offset range 21 .. 28;

      IP_Packet : Stream_Element_Array
        (1 .. UDP_Hdr_Offset'Last + Payload'Length);
   begin

      --  Copy payload to end of packet.

      IP_Packet (UDP_Hdr_Offset'Last + 1 .. IP_Packet'Last) := Payload;

      --  Copy UDP header in front of payload.

      IP_Packet (UDP_Hdr_Offset'Range)
        := UDP.Create_Header
          (Payload  => Payload,
           Src_IP   => Src_IP,
           Dst_IP   => Dst_IP,
           Src_Port => Src_Port,
           Dst_Port => Dst_Port);

      --  Copy IP header to beginning of packet.

      IP_Packet (IP_Hdr_Offset'Range)
        := IPv4.Create_Header
          (Payload => IP_Packet (UDP_Hdr_Offset'First .. IP_Packet'Last),
           Src_IP  => Src_IP,
           Dst_IP  => Dst_IP);

      return IP_Packet;
   end Create_Packet;

   -------------------------------------------------------------------------

   function Validate_And_Strip
     (Packet : Ada.Streams.Stream_Element_Array)
      return Ada.Streams.Stream_Element_Array
   is
      Hdr_Buffer : Raw_IP_Hdr_Buffer_Type;
      Total_Len  : Double_Byte;
      IP_Header  : Raw_IP_Hdr_Type;
      for IP_Header'Address use Hdr_Buffer'Address;
   begin
      if Packet'Length < 264 then
         raise Invalid_IP_Packet with "Invalid packet size:"
           & Natural'Image (Packet'Length);
      end if;

      Hdr_Buffer := Packet
        (Packet'First .. Packet'First + IP_Header_Length - 1);

      if IP_Header.IHL < 5 then
         raise Invalid_IP_Packet with "Invalid IHL:" & IP_Header.IHL'Img;
      end if;

      if IP_Header.Version /= 4 then
         raise Invalid_IP_Packet with "Invalid IP version:"
           & IP_Header.Version'Img;
      end if;

      Total_Len := Byte_Swapping.Network_To_Host (Input => IP_Header.TL);
      if Total_Len > Packet'Length then
         raise Invalid_IP_Packet with "Invalid total length:"
           & Total_Len'Img & " (packet is" & Natural'Image (Packet'Length)
           & " bytes)";
      end if;

      if IP_Header.Protocol /= Constants.Sys.IPPROTO_UDP then
         raise Invalid_IP_Packet with "Protocol is not UDP";
      end if;

      Calculate_Checksum :
      declare
         Chk_Pkt  : constant Double_Byte
           := Byte_Swapping.Network_To_Host (Input => IP_Header.Checksum);
         Chk_Calc : Double_Byte;
      begin

         --  Reset IP header checksum prior to verification.

         IP_Header.Checksum := 0;

         Chk_Calc := Util.Calculate_One_Complement (Data => Hdr_Buffer);
         if Chk_Pkt /= Chk_Calc then
            raise Invalid_IP_Packet with "IP header checksum" & Chk_Pkt'Img
              & " invalid, should be" & Chk_Calc'Img;
         end if;
      end Calculate_Checksum;

      declare
         use Ada.Streams;

         UDP_Pkt : constant Stream_Element_Array
           := Packet (Stream_Element_Offset (4 * IP_Header.IHL + 1) ..
                        Stream_Element_Offset (Total_Len));
      begin
         UDP.Validate_Checksum (Packet => UDP_Pkt,
                                Src_IP => IP_Header.Saddr,
                                Dst_IP => IP_Header.Daddr);
         return UDP_Pkt
           (UDP_Pkt'First + UDP.UDP_Header_Length .. UDP_Pkt'Last);
      end;
   end Validate_And_Strip;

end Anet.IPv4;

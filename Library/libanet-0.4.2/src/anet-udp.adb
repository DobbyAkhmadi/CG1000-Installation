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

with Anet.Byte_Swapping;
with Anet.Constants;
with Anet.Util;

package body Anet.UDP is

   use Ada.Streams;

   type Raw_UDP_Hdr_Type is record
      Source : Double_Byte;
      Dest   : Double_Byte;
      Len    : Double_Byte;
      Check  : Double_Byte;
   end record;
   --  Raw UDP header.

   for Raw_UDP_Hdr_Type use record
      Source at 0 range 0 .. 15;
      Dest   at 2 range 0 .. 15;
      Len    at 4 range 0 .. 15;
      Check  at 6 range 0 .. 15;
   end record;

   for Raw_UDP_Hdr_Type'Size use 64;

   subtype Raw_UDP_Hdr_Buffer_Type is
     Stream_Element_Array (1 .. UDP_Header_Length);

   type Pseudo_Hdr_Type is record
      Source_Address : IPv4_Addr_Type;
      Dest_Address   : IPv4_Addr_Type;
      Reserved       : Byte;
      Protocol       : Byte;
      Length         : Double_Byte;
   end record;
   --  Pseudo header used for checksum calculation/verification.

   for Pseudo_Hdr_Type use record
      Source_Address at  0 range 0 .. 31;
      Dest_Address   at  4 range 0 .. 31;
      Reserved       at  8 range 0 .. 7;
      Protocol       at  9 range 0 .. 7;
      Length         at 10 range 0 .. 15;
   end record;

   for Pseudo_Hdr_Type'Size use 96;
   for Pseudo_Hdr_Type'Alignment use 1;

   subtype Pseudo_Buffer_Type is Stream_Element_Array
     (1 .. Pseudo_Hdr_Type'Object_Size / Stream_Element'Object_Size);

   function Compute_Checksum
     (Hdr_Buffer : Raw_UDP_Hdr_Buffer_Type;
      Payload    : Ada.Streams.Stream_Element_Array;
      Src_IP     : IPv4_Addr_Type;
      Dst_IP     : IPv4_Addr_Type)
      return Double_Byte;
   --  Calculate UDP checksum for given UDP header and payload.

   -------------------------------------------------------------------------

   function Compute_Checksum
     (Hdr_Buffer : Raw_UDP_Hdr_Buffer_Type;
      Payload    : Ada.Streams.Stream_Element_Array;
      Src_IP     : IPv4_Addr_Type;
      Dst_IP     : IPv4_Addr_Type)
      return Double_Byte
   is
      Pseudo_Buffer : Pseudo_Buffer_Type;
      Pseudo_Hdr    : Pseudo_Hdr_Type;
      for Pseudo_Hdr'Address use Pseudo_Buffer'Address;

      subtype Pseudo_Hdr_Idx is Stream_Element_Offset range
        1 .. Pseudo_Buffer'Length;

      subtype UDP_Hdr_Idx is Stream_Element_Offset range
        Pseudo_Hdr_Idx'Last + 1 .. Pseudo_Hdr_Idx'Last + Hdr_Buffer'Length;

      Chksum_Buffer : Stream_Element_Array
        (1 .. Pseudo_Buffer'Length + Hdr_Buffer'Length + Payload'Length);
   begin
      Pseudo_Hdr.Source_Address := Src_IP;
      Pseudo_Hdr.Dest_Address   := Dst_IP;
      Pseudo_Hdr.Reserved       := 0;
      Pseudo_Hdr.Protocol       := Constants.Sys.IPPROTO_UDP;
      Pseudo_Hdr.Length         := Byte_Swapping.Host_To_Network
        (Input => Payload'Length + Hdr_Buffer'Length);

      Chksum_Buffer (Pseudo_Hdr_Idx'Range) := Pseudo_Buffer;
      Chksum_Buffer (UDP_Hdr_Idx'Range)    := Hdr_Buffer;
      Chksum_Buffer (UDP_Hdr_Idx'Last + 1 .. Chksum_Buffer'Last) := Payload;

      return Util.Calculate_One_Complement (Data => Chksum_Buffer);
   end Compute_Checksum;

   -------------------------------------------------------------------------

   function Create_Header
     (Payload  : Ada.Streams.Stream_Element_Array;
      Src_IP   : IPv4_Addr_Type;
      Dst_IP   : IPv4_Addr_Type;
      Src_Port : Port_Type;
      Dst_Port : Port_Type)
      return Ada.Streams.Stream_Element_Array
   is
      Hdr_Buffer : Raw_UDP_Hdr_Buffer_Type;
      for Hdr_Buffer'Alignment use 16;

      UDP_Hdr : Raw_UDP_Hdr_Type;
      for UDP_Hdr'Address use Hdr_Buffer'Address;
   begin
      UDP_Hdr.Check  := 0;
      UDP_Hdr.Source := Byte_Swapping.Host_To_Network
        (Input => Double_Byte (Src_Port));
      UDP_Hdr.Dest   := Byte_Swapping.Host_To_Network
        (Input => Double_Byte (Dst_Port));
      UDP_Hdr.Len    := Byte_Swapping.Host_To_Network
        (Input => Payload'Length + Hdr_Buffer'Length);
      UDP_Hdr.Check  := Byte_Swapping.Host_To_Network
        (Input => Compute_Checksum
           (Hdr_Buffer => Hdr_Buffer,
            Payload    => Payload,
            Src_IP     => Src_IP,
            Dst_IP     => Dst_IP));

      return Hdr_Buffer;
   end Create_Header;

   -------------------------------------------------------------------------

   procedure Validate_Checksum
     (Packet : Ada.Streams.Stream_Element_Array;
      Src_IP : IPv4_Addr_Type;
      Dst_IP : IPv4_Addr_Type)
   is
      Hdr_Buffer : Raw_UDP_Hdr_Buffer_Type;
      for Hdr_Buffer'Alignment use 16;

      UDP_Hdr : Raw_UDP_Hdr_Type;
      for UDP_Hdr'Address use Hdr_Buffer'Address;

      Chk_Pkt, Chk_Calc : Double_Byte;
   begin
      Hdr_Buffer := Packet
        (Packet'First .. Packet'First + UDP_Header_Length - 1);

      if UDP_Hdr.Check = 0 then
         return;
      end if;

      Chk_Pkt := Byte_Swapping.Network_To_Host (Input => UDP_Hdr.Check);
      UDP_Hdr.Check := 0;

      Chk_Calc := Compute_Checksum
        (Hdr_Buffer => Hdr_Buffer,
         Payload    => Packet
           (Packet'First + UDP_Header_Length .. Packet'Last),
         Src_IP     => Src_IP,
         Dst_IP     => Dst_IP);

      if Chk_Calc /= Chk_Pkt then
         raise Invalid_UDP_Packet with "UDP header checksum" & Chk_Pkt'Img
           & " invalid, should be" & Chk_Calc'Img;
      end if;
   end Validate_Checksum;

end Anet.UDP;

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

with Anet.Byte_Swapping;

package body Anet.ARP is

   type Raw_Hdr_Type is record
      Hardware_Type  : Double_Byte;
      Protocol_Type  : Double_Byte;
      HW_Addr_Len    : Byte;
      Proto_Addr_Len : Byte;
      Opcode         : Double_Byte;
      Src_Ether      : Ether_Addr_Type;
      Src_IP         : IPv4_Addr_Type;
      Dst_Ether      : Ether_Addr_Type;
      Dst_IP         : IPv4_Addr_Type;
   end record;
   --  Raw ARP header.

   for Raw_Hdr_Type use record
      Hardware_Type  at  0 range 0 .. 15;
      Protocol_Type  at  2 range 0 .. 15;
      HW_Addr_Len    at  4 range 0 .. 7;
      Proto_Addr_Len at  5 range 0 .. 7;
      Opcode         at  6 range 0 .. 15;
      Src_Ether      at  8 range 0 .. 47;
      Src_IP         at 14 range 0 .. 31;
      Dst_Ether      at 18 range 0 .. 47;
      Dst_IP         at 24 range 0 .. 31;
   end record;

   for Raw_Hdr_Type'Size use ARP_Header_Length * 8;
   for Raw_Hdr_Type'Alignment use 1;

   Opcodes : constant array (Operation_Type) of Double_Byte
     := (ARP_Request => 1,
         ARP_Reply   => 2);

   -------------------------------------------------------------------------

   function To_Header
     (Buffer : Ada.Streams.Stream_Element_Array)
      return Header_Type
   is
      Opcode  : Double_Byte;
      Raw_Hdr : Raw_Hdr_Type;
      for Raw_Hdr'Address use Buffer'Address;
   begin
      if Buffer'Length /= ARP_Header_Length then
         raise Invalid_ARP_Packet with "Unexpected ARP packet size:"
           & Buffer'Length'Img;
      end if;

      Opcode := Byte_Swapping.Network_To_Host (Input => Raw_Hdr.Opcode);
      if Opcode > 2 then
         raise Invalid_ARP_Packet with "Unknown ARP operation code:"
           & Opcode'Img;
      end if;

      return (Operation => Operation_Type'Val (Opcode - 1),
              Src_Ether => Raw_Hdr.Src_Ether,
              Src_IP    => Raw_Hdr.Src_IP,
              Dst_Ether => Raw_Hdr.Dst_Ether,
              Dst_IP    => Raw_Hdr.Dst_IP);
   end To_Header;

   -------------------------------------------------------------------------

   function To_Stream
     (Header : Header_Type)
      return Ada.Streams.Stream_Element_Array
   is
      function Hton
        (Input : Double_Byte)
         return Double_Byte
         renames Byte_Swapping.Host_To_Network;

      Hdr_Buffer : Ada.Streams.Stream_Element_Array (1 .. ARP_Header_Length);
      ARP_Header : Raw_Hdr_Type;
      for ARP_Header'Address use Hdr_Buffer'Address;
   begin
      ARP_Header :=
        (Hardware_Type  => Hton (Input => 1),
         Protocol_Type  => Hton (Input => 16#800#),
         HW_Addr_Len    => 6,
         Proto_Addr_Len => 4,
         Opcode         => Hton (Input => Opcodes (Header.Operation)),
         Src_Ether      => Header.Src_Ether,
         Src_IP         => Header.Src_IP,
         Dst_Ether      => Header.Dst_Ether,
         Dst_IP         => Header.Dst_IP);
      return Hdr_Buffer;
   end To_Stream;

end Anet.ARP;

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

package Anet.ARP is

   ARP_Header_Length : constant := 28;
   --  ARP for IPv4 header size in bytes.

   type Operation_Type is
     (ARP_Request,
      ARP_Reply);

   type Header_Type is record
      Operation : Operation_Type;
      Src_Ether : Ether_Addr_Type;
      Src_IP    : IPv4_Addr_Type;
      Dst_Ether : Ether_Addr_Type;
      Dst_IP    : IPv4_Addr_Type;
   end record;
   --  ARP header data.

   function To_Stream
     (Header : Header_Type)
      return Ada.Streams.Stream_Element_Array;
   --  Convert given ARP header to stream element array.

   function To_Header
     (Buffer : Ada.Streams.Stream_Element_Array)
      return Header_Type;
   --  Convert stream element array to ARP header.

   Invalid_ARP_Packet : exception;

end Anet.ARP;

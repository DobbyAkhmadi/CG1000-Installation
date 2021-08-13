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

package Anet.IPv4 is

   IP_Header_Length : constant := 20;
   --  IP Header size in bytes.

   function Create_Header
     (Payload : Ada.Streams.Stream_Element_Array;
      Src_IP  : IPv4_Addr_Type;
      Dst_IP  : IPv4_Addr_Type)
      return Ada.Streams.Stream_Element_Array;
   --  Returns an IPv4 header for given source, destination IPv4 addresses and
   --  payload.

   function Create_Packet
     (Payload  : Ada.Streams.Stream_Element_Array;
      Src_IP   : IPv4_Addr_Type;
      Src_Port : Port_Type;
      Dst_IP   : IPv4_Addr_Type;
      Dst_Port : Port_Type)
      return Ada.Streams.Stream_Element_Array;
   --  Create an IPv4 packet including an UDP header with specified arguments.

   function Validate_And_Strip
     (Packet : Ada.Streams.Stream_Element_Array)
      return Ada.Streams.Stream_Element_Array;
   --  Validate IP packet given as stream element array. The function raises an
   --  Invalid_IP_Packet exception if the data is not considered valid.
   --
   --  The following checks are performed:
   --  * Data length must be at least 264 bytes
   --    (IP header + UDP header + min. 236 bytes DHCP payload)
   --  * IP header length (IHL) must be at least 5
   --  * IP version is 4
   --  * Total length must match received data length
   --  * Protocol is UDP
   --  * IP header checksum is correct
   --  * UDP header checksum is correct
   --
   --  If the packet is valid, the IP and UDP headers are stripped and the
   --  payload is returned.

   Invalid_IP_Packet : exception;

end Anet.IPv4;

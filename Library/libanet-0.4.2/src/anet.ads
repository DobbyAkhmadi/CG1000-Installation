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

pragma License (Modified_GPL);
pragma Detect_Blocking;

with Ada.Streams;

package Anet is

   type Byte is range 0 .. 255;

   subtype Hex_Byte_Str is String (1 .. 2);

   function To_Hex (B : Byte) return String;
   --  Convert byte to hexadecimal string representation.

   function To_Hex (Data : Ada.Streams.Stream_Element_Array) return String;
   --  Convert given stream element array to hex string.

   function To_Byte (Str : Hex_Byte_Str) return Byte;
   --  Convert hex byte string to byte.

   type Double_Byte is range 0 .. 2 ** 16 - 1;

   type Word32 is range 0 .. 2 ** 32 - 1;

   type Byte_Array is array (Positive range <>) of Byte;

   function To_String (Bytes : Byte_Array) return String;
   --  Convert given byte array to string.

   function To_Bytes (Str : String) return Byte_Array;
   --  Convert given string to byte array.

   subtype Port_Type is Double_Byte;
   --  Port number.

   Any_Port : constant Port_Type;

   type HW_Addr_Len_Type is range 1 .. 16;
   for HW_Addr_Len_Type'Size use 8;
   --  Allowed length for hardware addresses.

   type Hardware_Addr_Type is array (HW_Addr_Len_Type range <>) of Byte;
   --  Link-layer address.

   subtype Ether_Addr_Type is Hardware_Addr_Type (1 .. 6);
   --  Ethernet address.

   function To_String (Address : Hardware_Addr_Type) return String;
   --  Return string representation of a hardware address.

   Bcast_HW_Addr : constant Ether_Addr_Type;
   --  ff:ff:ff:ff:ff:ff

   type IPv4_Addr_Type is array (1 .. 4) of Byte;
   --  IPv4 address.

   function To_IPv4_Addr (Str : String) return IPv4_Addr_Type;
   --  Return IPv4 address for given string.

   function To_String (Address : IPv4_Addr_Type) return String;
   --  Return string representation of an IPv4 address.

   Any_Addr : constant IPv4_Addr_Type;
   --  0.0.0.0

   Loopback_Addr_V4 : constant IPv4_Addr_Type;
   --  127.0.0.1

   Bcast_Addr : constant IPv4_Addr_Type;
   --  255.255.255.255

   type IPv6_Addr_Type is array (1 .. 16) of Byte;
   --  IPv6 address.

   function To_IPv6_Addr (Str : String) return IPv6_Addr_Type;
   --  Return IPv6 address for given string.

   function To_String (Address : IPv6_Addr_Type) return String;
   --  Return string representation of an IPv6 address.

   Any_Addr_V6 : constant IPv6_Addr_Type;
   --  IPv6 in6addr_any (::).

   Loopback_Addr_V6 : constant IPv6_Addr_Type;
   --  IPv6 loopback address (::1).

   C_Failure : constant := -1;
   --  Used to test return codes of imported C functions.

   Socket_Error : exception;

private

   for Byte'Size use 8;
   for Double_Byte'Size use 16;
   for Word32'Size use 32;
   for IPv4_Addr_Type'Size use 32;
   for IPv6_Addr_Type'Size use 128;

   Bcast_HW_Addr : constant Ether_Addr_Type := (others => 255);

   Any_Addr         : constant IPv4_Addr_Type := (others => 0);
   Loopback_Addr_V4 : constant IPv4_Addr_Type := (127, 0, 0, 1);
   Any_Addr_V6      : constant IPv6_Addr_Type := (others => 0);
   Loopback_Addr_V6 : constant IPv6_Addr_Type := (16 => 1, others => 0);
   Bcast_Addr       : constant IPv4_Addr_Type := (others => 255);
   Any_Port         : constant Port_Type      := 0;

end Anet;

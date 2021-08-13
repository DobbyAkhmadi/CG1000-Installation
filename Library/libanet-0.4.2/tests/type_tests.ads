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

with Ahven.Framework;

package Type_Tests is

   type Testcase is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Testcase);
   --  Initialize testcase.

   procedure IPv4_Addr_To_String;
   --  Verify string conversion function for IPv4 address type.

   procedure HW_Addr_To_String;
   --  Verify string conversion function for Hardware address type.

   procedure IPv6_Addr_To_String;
   --  Verify string conversion function for IPv6 address type.

   procedure String_To_IPv4_Addr;
   --  Verify string to IPv4 address conversion.

   procedure String_To_Byte;
   --  Verify string to byte conversion.

   procedure String_To_IPv6_Addr;
   --  Verify string to IPv6 address conversion.

   procedure Byte_Array_To_String;
   --  Verify string conversion function for byte array type.

   procedure String_To_Byte_Array;
   --  Verify string to byte array conversion function.

   procedure Stream_To_Hex;
   --  Verify stream element array to hex string conversion function.

   procedure Valid_Iface_Names;
   --  Test interface name validation.

end Type_Tests;

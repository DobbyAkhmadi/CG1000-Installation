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

with GNAT.Byte_Swapping;

package body Anet.Byte_Swapping is

   use type System.Bit_Order;

   function Swapped is new
     GNAT.Byte_Swapping.Swapped2 (Item => Double_Byte);

   function Swapped is new
     GNAT.Byte_Swapping.Swapped4 (Item => Word32);

   function LE_Swap (Input : Word32) return Word32;
   --  Swap given 32bit word input if host bit order is little-endian.

   function LE_Swap (Input : Double_Byte) return Double_Byte;
   --  Swap given double byte input if host bit order is little-endian.

   --  Renames

   function Host_To_Network
     (Input : Double_Byte)
      return Double_Byte
      renames LE_Swap;

   function Network_To_Host
     (Input : Double_Byte)
      return Double_Byte
      renames LE_Swap;

   function Host_To_Network (Input : Word32) return Word32 renames LE_Swap;

   function Network_To_Host (Input : Word32) return Word32 renames LE_Swap;

   -------------------------------------------------------------------------

   function LE_Swap (Input : Double_Byte) return Double_Byte
   is
   begin
      if System.Default_Bit_Order = System.Low_Order_First then
         return Swapped (Input);
      else
         return Input;
      end if;
   end LE_Swap;

   -------------------------------------------------------------------------

   function LE_Swap (Input : Word32) return Word32
   is
   begin
      if System.Default_Bit_Order = System.Low_Order_First then
         return Swapped (Input);
      else
         return Input;
      end if;
   end LE_Swap;

end Anet.Byte_Swapping;

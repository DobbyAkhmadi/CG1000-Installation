--
--  Copyright (C) 2014 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2014 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Interfaces.C.Strings;

package Anet.Thin is

   function C_Getpid return Interfaces.C.int;
   pragma Import (C, C_Getpid, "getpid");

   function C_Inet_Pton
     (Af  : Interfaces.C.int;
      Src : Interfaces.C.Strings.chars_ptr;
      Dst : System.Address)
      return Interfaces.C.int;
   pragma Import (C, C_Inet_Pton, "inet_pton");

   function C_Inet_Ntop
     (Af   : Interfaces.C.int;
      Src  : System.Address;
      Dst  : Interfaces.C.Strings.chars_ptr;
      Size : Interfaces.C.unsigned)
      return Interfaces.C.Strings.chars_ptr;
   pragma Import (C, C_Inet_Ntop, "inet_ntop");

end Anet.Thin;

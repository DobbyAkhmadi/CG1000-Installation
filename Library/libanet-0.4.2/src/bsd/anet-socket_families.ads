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

with Interfaces.C;

with Anet.Constants;

package Anet.Socket_Families is

   type Family_Type is
     (Family_Inet,
      Family_Inet6,
      Family_Unix);
   --  Address families.

   Families : constant array (Family_Type) of Interfaces.C.int
     := (Family_Inet    => Constants.Sys.AF_INET,
         Family_Inet6   => Constants.Sys.AF_INET6,
         Family_Unix    => Constants.AF_UNIX);
   --  Address family mapping.

end Anet.Socket_Families;

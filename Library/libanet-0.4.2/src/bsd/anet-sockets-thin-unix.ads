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

package Anet.Sockets.Thin.Unix is

   UNIX_PATH_MAX : constant := 104;

   type Sockaddr_Un_Type is record
      Sun_Len    : Interfaces.C.unsigned_char := 106;
      --  Record length
      Sun_Family : Interfaces.C.unsigned_char := Constants.AF_UNIX;
      --  Address family
      Pathname   : Interfaces.C.char_array (1 .. UNIX_PATH_MAX)
        := (others => Interfaces.C.nul);
      --  Pathname
   end record;
   pragma Convention (C, Sockaddr_Un_Type);
   --  Low-level UNIX socket address type (struct sockaddr_un).

end Anet.Sockets.Thin.Unix;

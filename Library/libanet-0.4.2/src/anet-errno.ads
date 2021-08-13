--
--  Copyright (C) 2016 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2016 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with GNAT.OS_Lib;

package Anet.Errno
is

   function Get_Errno_String
     (Err     : Integer := GNAT.OS_Lib.Errno;
      Default : String  := "")
      return String
      renames GNAT.OS_Lib.Errno_Message;

   --  Raise Socket_Error exception with given message and appended errno
   --  string if specified result code indicates failure.
   procedure Check_Or_Raise
     (Result  : Interfaces.C.int;
      Message : String);

end Anet.Errno;

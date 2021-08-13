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

package Anet.Util is

   function Calculate_One_Complement
     (Data : Ada.Streams.Stream_Element_Array)
      return Double_Byte;
   --  Calculate one's complement sum of the 16 bit aligned data bytes.

   function Random_String (Len : Positive) return String;
   --  Return a random string of given length.

   procedure Wait_For_File
     (Path     : String;
      Timespan : Duration);
   --  This procedure waits max. the given timespan in seconds until the file
   --  specified by path is available. An exception is raised if the file is
   --  not present after the timespan has passed.

   Wait_Timeout : exception;

end Anet.Util;

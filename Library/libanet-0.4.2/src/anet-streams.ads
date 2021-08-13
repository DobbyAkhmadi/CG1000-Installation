--
--  Copyright (C) 2012 secunet Security Networks AG
--  Copyright (C) 2012 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2012 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

package Anet.Streams is

   type Memory_Stream_Type (Max_Elements : Ada.Streams.Stream_Element_Offset)
     is new Ada.Streams.Root_Stream_Type with private;
   --  In-memory stream type. Can be used to serialize/deserialize record types
   --  over a socket. The Max_Elements discriminant defines the maximal number
   --  of elements the stream is able to store.

   overriding
   procedure Read
     (Stream : in out Memory_Stream_Type;
      Item   :    out Ada.Streams.Stream_Element_Array;
      Last   :    out Ada.Streams.Stream_Element_Offset);
   --  Read elements from memory stream.

   overriding
   procedure Write
     (Stream : in out Memory_Stream_Type;
      Item   :        Ada.Streams.Stream_Element_Array);
   --  Write elements to memory stream.

   procedure Set_Buffer
     (Stream : in out Memory_Stream_Type;
      Buffer :        Ada.Streams.Stream_Element_Array);
   --  Set memory stream content to data provided by Buffer.

   function Get_Buffer
     (Stream : Memory_Stream_Type)
      return Ada.Streams.Stream_Element_Array;
   --  Return raw buffer of memory stream.

   procedure Clear (Stream : in out Memory_Stream_Type);
   --  Clear memory stream.

   Stream_Error : exception;

private

   use Ada.Streams;

   type Memory_Stream_Type (Max_Elements : Stream_Element_Offset) is new
     Root_Stream_Type with record
      Buffer    : Stream_Element_Array (1 .. Max_Elements) := (others => 0);
      Write_Idx : Stream_Element_Offset                    := 1;
      Read_Idx  : Stream_Element_Offset                    := 1;
   end record;

end Anet.Streams;

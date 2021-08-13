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

package body Anet.Streams is

   -------------------------------------------------------------------------

   procedure Clear (Stream : in out Memory_Stream_Type)
   is
   begin
      Stream.Buffer    := (others => 0);
      Stream.Write_Idx := Stream.Buffer'First;
      Stream.Read_Idx  := Stream.Buffer'First;
   end Clear;

   -------------------------------------------------------------------------

   function Get_Buffer
     (Stream : Memory_Stream_Type)
      return Ada.Streams.Stream_Element_Array
   is
   begin
      return Stream.Buffer (Stream.Buffer'First .. Stream.Write_Idx - 1);
   end Get_Buffer;

   -------------------------------------------------------------------------

   procedure Read
     (Stream : in out Memory_Stream_Type;
      Item   :    out Ada.Streams.Stream_Element_Array;
      Last   :    out Ada.Streams.Stream_Element_Offset)
   is
      End_Idx : constant Stream_Element_Offset
        := Stream.Read_Idx + (Item'Length - 1);
   begin
      Item            := Stream.Buffer (Stream.Read_Idx .. End_Idx);
      Last            := Item'Last;
      Stream.Read_Idx := End_Idx + 1;
   end Read;

   -------------------------------------------------------------------------

   procedure Set_Buffer
     (Stream : in out Memory_Stream_Type;
      Buffer :        Ada.Streams.Stream_Element_Array)
   is
   begin
      if Buffer'Length > Stream.Buffer'Last then
         raise Stream_Error with "Setting raw buffer failed (overflow), "
           & "increase size (offset" & Buffer'Length'Img & " requested, max is"
           & Stream.Buffer'Last'Img & ")";
      end if;

      Stream.Clear;
      Stream.Buffer (Stream.Buffer'First .. Buffer'Length) := Buffer;
   end Set_Buffer;

   -------------------------------------------------------------------------

   procedure Write
     (Stream : in out Memory_Stream_Type;
      Item   :        Ada.Streams.Stream_Element_Array)
   is
      End_Idx : constant Stream_Element_Offset
        := Stream.Write_Idx + (Item'Length - 1);
   begin
      if End_Idx > Stream.Buffer'Last then
         raise Stream_Error with "Stream buffer too small for object, "
           & "increase size (offset" & End_Idx'Img & " requested, max is"
           & Stream.Buffer'Last'Img & ")";
      end if;

      Stream.Buffer (Stream.Write_Idx .. End_Idx) := Item;
      Stream.Write_Idx                            := End_Idx + 1;
   end Write;

end Anet.Streams;

--
--  Copyright (C) 2011, 2012 secunet Security Networks AG
--  Copyright (C) 2011-2014  Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2011-2014  Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Ada.Directories;
with Ada.Numerics.Discrete_Random;

with Interfaces;

with Anet.Thin;

package body Anet.Util is

   use Ada.Streams;

   Chars : constant String := "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
     & "abcdefghijklmnopqrstuvwxyz" & "0123456789";
   subtype Chars_Range is Positive range Chars'First .. Chars'Last;

   package Random_Chars is new Ada.Numerics.Discrete_Random
     (Result_Subtype => Chars_Range);
   Generator : Random_Chars.Generator;

   -------------------------------------------------------------------------

   function Calculate_One_Complement
     (Data : Ada.Streams.Stream_Element_Array)
      return Double_Byte
   is
      function Make_Even
        (Data : Stream_Element_Array)
         return Stream_Element_Array;
      --  Pad data array with a nil element if it has an uneven number of
      --  elements.

      function Make_Even
        (Data : Stream_Element_Array)
         return Stream_Element_Array
      is
      begin
         if Data'Length mod 2 = 0 then
            return Data;
         end if;

         return D : Stream_Element_Array (Data'First .. Data'Last + 1) do
            D (Data'Range) := Data;
            D (D'Last)     := 0;
         end return;
      end Make_Even;

      use Interfaces;

      Sum  : Unsigned_32                   := 0;
      Even : constant Stream_Element_Array := Make_Even (Data => Data);
      Idx  : Stream_Element_Offset         := Even'First;
   begin
      loop
         Sum := Sum + Unsigned_32 (Shift_Left
           (Value  => Unsigned_16 (Even (Idx)),
            Amount => 8));
         Sum := Sum + Unsigned_32 (Even (Idx + 1));

         Idx := Idx + 2;
         exit when Idx > Even'Last;
      end loop;

      loop
         declare
            Carries : constant Unsigned_32
              := Shift_Right (Value  => Sum,
                              Amount => 16);
         begin
            exit when Carries < 1;

            Sum := (Sum and 16#ffff#) + Carries;
         end;
      end loop;

      Sum := (not Sum) mod 2 ** 16;

      return Double_Byte (Sum);
   end Calculate_One_Complement;

   -------------------------------------------------------------------------

   function Random_String (Len : Positive) return String
   is
      Result : String (1 .. Len);
   begin
      for I in Result'Range loop
         Result (I) := Chars (Random_Chars.Random (Gen => Generator));
      end loop;

      return Result;
   end Random_String;

   -------------------------------------------------------------------------

   procedure Wait_For_File
     (Path     : String;
      Timespan : Duration)
   is
   begin
      for L in 1 .. Positive (100 * Timespan) loop
         if Ada.Directories.Exists (Name => Path) then
            return;
         end if;
         delay Timespan / 100;
      end loop;

      raise Wait_Timeout with "File '" & Path & "' not available after"
        & Timespan'Img & " second(s)";
   end Wait_For_File;

   -------------------------------------------------------------------------

begin
   Random_Chars.Reset (Gen       => Generator,
                       Initiator => Integer (Thin.C_Getpid));
end Anet.Util;

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

with Ada.Streams;

with Anet.Util;

package body Util_Tests is

   use Ada.Streams;
   use Ahven;
   use Anet.Util;

   -------------------------------------------------------------------------

   procedure Calculate_One_Complement
   is
      use type Anet.Double_Byte;

      Data1  : constant Stream_Element_Array
        := (16#12#, 16#ff#, 16#ab#, 16#24#, 16#45#, 16#92#, 16#12#, 16#12#);
      Data2  : constant Stream_Element_Array (1 .. 6)  := (others => 0);
      Data3  : constant Stream_Element_Array (1 .. 12) := (others => 16#ff#);
      IP_Hdr : constant Stream_Element_Array
        := (16#45#, 16#00#, 16#01#, 16#4b#, 16#78#, 16#12#, 16#00#, 16#00#,
            16#40#, 16#11#, 16#00#, 16#00#, 16#c0#, 16#a8#, 16#ef#, 16#01#,
            16#c0#, 16#a8#, 16#ef#, 16#77#);
   begin
      Assert (Condition => Calculate_One_Complement (Data => Data1) = 59959,
              Message   => "One's complement mismatch1");
      Assert (Condition => Calculate_One_Complement (Data => Data2) = 65535,
              Message   => "One's complement mismatch2");
      Assert (Condition => Calculate_One_Complement (Data => Data3) = 0,
              Message   => "One's complement mismatch3");
      Assert (Condition => Calculate_One_Complement (Data => IP_Hdr) = 41413,
              Message   => "One's complement mismatch4");
   end Calculate_One_Complement;

   -------------------------------------------------------------------------

   procedure Calculate_One_Complement_Uneven
   is
      use type Anet.Double_Byte;

      Data : constant Stream_Element_Array
        := (16#12#, 16#ff#, 16#ab#, 16#45#, 16#92#, 16#12#, 16#fa#);
   begin
      Assert (Condition => Calculate_One_Complement (Data => Data) = 46503,
              Message   => "One's complement mismatch");
   end Calculate_One_Complement_Uneven;

   -------------------------------------------------------------------------

   procedure Get_Random_Strings
   is
   begin
      Assert (Condition => Random_String (Len => 4)'Length = 4,
              Message   => "Length incorrect");
      Assert (Condition => Random_String (Len => 4) /=
                Random_String (Len => 4),
              Message   => "Strings match");
   end Get_Random_Strings;

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Tests for Util package");
      T.Add_Test_Routine
        (Routine => Calculate_One_Complement'Access,
         Name    => "Calculate one's complement");
      T.Add_Test_Routine
        (Routine => Calculate_One_Complement_Uneven'Access,
         Name    => "Calculate one's complement (uneven)");
      T.Add_Test_Routine
        (Routine => Get_Random_Strings'Access,
         Name    => "Get random strings");
      T.Add_Test_Routine
        (Routine => Verify_Wait_For_File'Access,
         Name    => "Wait for file to appear");
   end Initialize;

   -------------------------------------------------------------------------

   procedure Verify_Wait_For_File
   is
   begin
      begin
         Wait_For_File (Path     => "/nonexistent/nonexistent",
                        Timespan => 0.1);
         Fail (Message => "Exception expected");

      exception
         when Wait_Timeout => null;
      end;
   end Verify_Wait_For_File;

end Util_Tests;

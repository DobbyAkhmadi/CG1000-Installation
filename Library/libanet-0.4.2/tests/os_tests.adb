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

with Ada.Text_IO;
with Ada.Directories;
with Ada.Streams;

with Anet.OS;
with Anet.Util;

package body OS_Tests is

   use Ahven;
   use Anet;

   -------------------------------------------------------------------------

   procedure Delete_Files
   is
      File     : Ada.Text_IO.File_Type;
      Testfile : constant String := "/tmp/delete-test-"
        & Util.Random_String (Len => 8);
   begin
      begin
         OS.Delete_File (Filename       => Testfile,
                         Ignore_Missing => False);
         Fail (Message => "Expected IO error");

      exception
         when OS.IO_Error => null;
      end;

      --  This should not raise an exception.

      OS.Delete_File (Filename       => Testfile,
                      Ignore_Missing => True);

      Ada.Text_IO.Create (File => File,
                          Mode => Ada.Text_IO.Out_File,
                          Name => Testfile);
      OS.Delete_File (Filename       => Testfile,
                      Ignore_Missing => False);
      Assert (Condition => not Ada.Directories.Exists (Name => Testfile),
              Message   => "File still there");
   end Delete_Files;

   -------------------------------------------------------------------------

   procedure Execute_Error
   is
   begin
      OS.Execute (Command => "nonexistent_command 2> /dev/null");

   exception
      when OS.Command_Failed => null;
   end Execute_Error;

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Tests for OS package");
      T.Add_Test_Routine
        (Routine => Delete_Files'Access,
         Name    => "Delete files");
      T.Add_Test_Routine
        (Routine => Read_File_Content'Access,
         Name    => "Read file content");
      T.Add_Test_Routine
        (Routine => Execute_Error'Access,
         Name    => "Execution error");
   end Initialize;

   -------------------------------------------------------------------------

   procedure Read_File_Content
   is
      use Ada.Streams;

      Testfile   : constant String := "data/chunk2.dat";
      Ref_Buffer : constant Stream_Element_Array
        := (16#7f#, 16#45#, 16#62#, 16#4e#, 16#0a#);
   begin
      begin
         declare
            Buffer : constant Stream_Element_Array
              := OS.Read_File (Filename => "nonexistent");
            pragma Unreferenced (Buffer);
         begin
            Fail (Message => "IO error expected");
         end;

      exception
         when OS.IO_Error => null;
      end;

      Assert (Condition => OS.Read_File (Filename => Testfile) = Ref_Buffer,
              Message   => "Content mismatch");
   end Read_File_Content;

end OS_Tests;

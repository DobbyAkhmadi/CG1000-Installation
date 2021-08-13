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

with Ada.Directories;
with Ada.Streams.Stream_IO;
with Ada.IO_Exceptions;

with Interfaces.C;
with Interfaces.C_Streams;

with GNAT.OS_Lib;

with Anet.Errno;
with Anet.Constants;

package body Anet.OS is

   -------------------------------------------------------------------------

   procedure Delete_File
     (Filename       : String;
      Ignore_Missing : Boolean := True)
   is
      use Interfaces;
      use type C.int;

      Res    : C.int;
      C_Path : constant C.char_array := C.To_C (Filename);
   begin
      Res := C.int (C_Streams.unlink (filename => C_Path'Address));
      if Res = C_Failure and then
        (GNAT.OS_Lib.Errno /= Constants.Sys.ENOENT or else not Ignore_Missing)
      then
         raise IO_Error with "Unable to delete file '" & Filename & "' - "
           & Errno.Get_Errno_String;
      end if;
   end Delete_File;

   -------------------------------------------------------------------------

   procedure Execute (Command : String)
   is
      Success : Boolean := False;
      Args    : GNAT.OS_Lib.Argument_List (1 .. 2);
   begin
      Args (1) := new String'("-c");
      Args (2) := new String'(Command);

      GNAT.OS_Lib.Spawn (Program_Name => "/bin/sh",
                         Args         => Args,
                         Success      => Success);

      for A in Args'Range loop
         GNAT.OS_Lib.Free (Args (A));
      end loop;

      if not Success then
         raise Command_Failed with
           "Execution of command '" & Command & "' failed";
      end if;
   end Execute;

   -------------------------------------------------------------------------

   function Read_File
     (Filename : String)
      return Ada.Streams.Stream_Element_Array
   is
      use Ada.Streams;

      Data_File : Stream_IO.File_Type;
   begin
      begin
         Stream_IO.Open (File => Data_File,
                         Mode => Stream_IO.In_File,
                         Name => Filename);
      exception
         when Ada.IO_Exceptions.Name_Error =>
            raise IO_Error with "Could not open '" & Filename
              & "', file does not exist";
      end;

      declare
         Len  : Stream_Element_Offset;
         Data : Stream_Element_Array
           (1 .. Stream_Element_Offset
              (Ada.Directories.Size (Name => Filename)));
      begin
         Stream_IO.Read (File => Data_File,
                         Item => Data,
                         Last => Len);
         Stream_IO.Close (File => Data_File);

         if Len /= Data'Length then
            raise IO_Error with "Incomplete read of file '" & Filename & "'";
         end if;

         return Data;

      exception
         when others =>
            Stream_IO.Close (File => Data_File);
            raise IO_Error with "Unable to read data from file '"
              & Filename & "'";
      end;
   end Read_File;

end Anet.OS;

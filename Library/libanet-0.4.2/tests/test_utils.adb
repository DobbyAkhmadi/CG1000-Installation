--
--  Copyright (C) 2011-2013 secunet Security Networks AG
--  Copyright (C) 2011-2014 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2011-2014 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Ada.Direct_IO;
with Ada.Environment_Variables;
with Ada.Numerics.Discrete_Random;

with Anet.Thin;

package body Test_Utils is

   package D_IO is new Ada.Direct_IO (Element_Type => Character);

   package Random_Ports is new Ada.Numerics.Discrete_Random
     (Result_Subtype => Test_Port_Type);
   Generator : Random_Ports.Generator;

   -------------------------------------------------------------------------

   procedure Dump
     (Data : Ada.Streams.Stream_Element_Array;
      Src  : Anet.Sockets.Inet.IPv4_Sockaddr_Type)
   is
   begin
      Buffer (Buffer'First .. Data'Length) := Data;
      Last                                 := Data'Length;
      Last_Addr_v4                         := Src;
   end Dump;

   -------------------------------------------------------------------------

   procedure Dump
     (Data : Ada.Streams.Stream_Element_Array;
      Src  : Anet.Sockets.Inet.IPv6_Sockaddr_Type)
   is
   begin
      Buffer (Buffer'First .. Data'Length) := Data;
      Last                                 := Data'Length;
      Last_Addr_v6                         := Src;
   end Dump;

   -------------------------------------------------------------------------

   procedure Dump
     (Data : Ada.Streams.Stream_Element_Array;
      Src  : Anet.Sockets.Unix.Full_Path_Type)
   is
   begin
      Buffer (Buffer'First .. Data'Length) := Data;
      Last                                 := Data'Length;
      Last_Addr_Unix                       := Src;
   end Dump;

   -------------------------------------------------------------------------

   procedure Echo
     (Src       :     Address_Type;
      Recv_Data :     Ada.Streams.Stream_Element_Array;
      Send_Data : out Ada.Streams.Stream_Element_Array;
      Send_Last : out Ada.Streams.Stream_Element_Offset)
   is
      pragma Unreferenced (Src);
   begin
      Send_Data (Send_Data'First .. Recv_Data'Length) := Recv_Data;
      Send_Last := Recv_Data'Length;
   end Echo;

   -------------------------------------------------------------------------

   function Equal_Files
     (Filename1 : String;
      Filename2 : String)
      return Boolean
   is
      use type D_IO.Count;

      procedure Open_File
        (Filename :     String;
         File     : out D_IO.File_Type);
      --  Open file specified by filename.

      procedure Open_File
        (Filename :     String;
         File     : out D_IO.File_Type)
      is
      begin
         D_IO.Open (File => File,
                    Mode => D_IO.In_File,
                    Name => Filename,
                    Form => "shared=no");

      exception
         when others =>
            raise Open_File_Error with
              "Unable to open file '" & Filename & "'";
      end Open_File;

      File1, File2 : D_IO.File_Type;
      Char1, Char2 : Character;
      Result       : Boolean := True;
   begin
      Open_File (Filename => Filename1,
                 File     => File1);
      Open_File (Filename => Filename2,
                 File     => File2);

      if D_IO.Size (File1) /= D_IO.Size (File2) then
         D_IO.Close (File => File1);
         D_IO.Close (File => File2);
         return False;
      end if;

      while not D_IO.End_Of_File (File => File1) loop

         --  Read one byte from both files.

         D_IO.Read (File => File1,
                    Item => Char1);
         D_IO.Read (File => File2,
                    Item => Char2);

         if Char1 /= Char2 then
            Result := False;
         end if;
      end loop;

      D_IO.Close (File => File1);
      D_IO.Close (File => File2);

      return Result;
   end Equal_Files;

   -------------------------------------------------------------------------

   function Get_Dump return Ada.Streams.Stream_Element_Array
   is
      Result : constant Ada.Streams.Stream_Element_Array := Buffer
        (Buffer'First .. Last);
   begin
      Buffer := (others => 0);
      Last   := Ada.Streams.Stream_Element_Offset'First;
      return Result;
   end Get_Dump;

   -------------------------------------------------------------------------

   function Get_Last_Address return Anet.Sockets.Inet.IPv4_Sockaddr_Type
   is
   begin
      return Last_Addr_v4;
   end Get_Last_Address;

   -------------------------------------------------------------------------

   function Get_Last_Address return Anet.Sockets.Inet.IPv6_Sockaddr_Type
   is
   begin
      return Last_Addr_v6;
   end Get_Last_Address;

   -------------------------------------------------------------------------

   function Get_Last_Address return Anet.Sockets.Unix.Full_Path_Type
   is
   begin
      return Last_Addr_Unix;
   end Get_Last_Address;

   -------------------------------------------------------------------------

   function Get_Random_Port return Test_Port_Type
   is
   begin
      return Random_Ports.Random (Gen => Generator);
   end Get_Random_Port;

   -------------------------------------------------------------------------

   procedure Raise_Error
     (Data : Ada.Streams.Stream_Element_Array;
      Src  : Anet.Sockets.Inet.IPv4_Sockaddr_Type)
   is
   begin
      raise Constraint_Error with "DO NOT PANIC: Explicit raise";
   end Raise_Error;

begin
   if Ada.Environment_Variables.Exists (Name => "OS") then
      OS := OS_Type'Value
        (Ada.Environment_Variables.Value
           (Name => "OS"));
   end if;

   Random_Ports.Reset (Gen       => Generator,
                       Initiator => Integer (Anet.Thin.C_Getpid));
end Test_Utils;

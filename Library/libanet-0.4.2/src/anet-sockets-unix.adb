--
--  Copyright (C) 2012-2013 secunet Security Networks AG
--  Copyright (C) 2012-2016 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2012-2016 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Ada.Strings.Fixed;

with Anet.OS;
with Anet.Errno;

package body Anet.Sockets.Unix is

   package C renames Interfaces.C;

   -------------------------------------------------------------------------

   procedure Accept_Connection
     (Socket     :     TCP_Socket_Type;
      New_Socket : out TCP_Socket_Type)
   is
      Unreferenced : Full_Path_Type;
   begin
      Accept_Connection (Socket     => Socket,
                         New_Socket => New_Socket,
                         Src        => Unreferenced);
   end Accept_Connection;

   -------------------------------------------------------------------------

   procedure Accept_Connection
     (Socket     :     TCP_Socket_Type;
      New_Socket : out TCP_Socket_Type;
      Src        : out Full_Path_Type)
   is
      Res  : C.int;
      Sock : Thin.Unix.Sockaddr_Un_Type;
      Len  : aliased C.int := Sock'Size / 8;
   begin
      New_Socket.Sock_FD := -1;
      Src                := (others => ASCII.NUL);

      Res := Thin.C_Accept (S       => Socket.Sock_FD,
                            Name    => Sock'Address,
                            Namelen => Len'Access);

      case Check_Accept (Result => Res)
      is
         when Accept_Op_Aborted => return;
         when Accept_Op_Error =>
            raise Socket_Error with "Unable to accept connection on UNIX/TCP "
              & "socket - " & Errno.Get_Errno_String;
         when Accept_Op_Ok =>
            New_Socket.Sock_FD         := Res;
            New_Socket.Path            := Socket.Path;
            New_Socket.Delete_On_Close := False;

            declare
               Path_Str : constant String
                 := Ada.Strings.Unbounded.To_String (Socket.Path);
            begin
               Src (Src'First .. Path_Str'Length) := Path_Type (Path_Str);
            end;
      end case;
   end Accept_Connection;

   -------------------------------------------------------------------------

   procedure Bind
     (Socket : in out Unix_Socket_Type;
      Path   :        Path_Type)
   is
      use type Interfaces.C.unsigned_long;

      C_Path : constant C.char_array := C.To_C (String (Path));
      Value  : Thin.Unix.Sockaddr_Un_Type;
   begin
      OS.Delete_File (Filename => String (Path));

      Value.Pathname (1 .. C_Path'Length) := C_Path;

      Errno.Check_Or_Raise
        (Result  => Thin.C_Bind
           (S       => Socket.Sock_FD,
            Name    => Value'Address,
            Namelen => Value'Size / 8),
         Message => "Unable to bind unix socket to path " & String (Path));

      Socket.Path := Ada.Strings.Unbounded.To_Unbounded_String
        (String (Path));
   end Bind;

   -------------------------------------------------------------------------

   procedure Close (Socket : in out Unix_Socket_Type)
   is
   begin
      if Socket.Sock_FD /= -1 and then Socket.Delete_On_Close then
         OS.Delete_File (Filename => Ada.Strings.Unbounded.To_String
                         (Socket.Path));
         Socket_Type (Socket).Close;
      end if;
   end Close;

   -------------------------------------------------------------------------

   procedure Connect
     (Socket : in out Unix_Socket_Type;
      Path   :        Path_Type)
   is
      use type Interfaces.C.unsigned_long;

      C_Path : constant C.char_array := C.To_C (String (Path));
      Value  : Thin.Unix.Sockaddr_Un_Type;
   begin
      Value.Pathname (1 .. C_Path'Length) := C_Path;

      Errno.Check_Or_Raise
        (Result  => Thin.C_Connect
           (S       => Socket.Sock_FD,
            Name    => Value'Address,
            Namelen => Value'Size / 8),
         Message => "Unable to connect unix socket to path " & String (Path));
   end Connect;

   -------------------------------------------------------------------------

   procedure Init (Socket : in out UDP_Socket_Type)
   is
   begin
      Init (Socket => Socket,
            Family => Socket_Families.Family_Unix,
            Mode   => Datagram_Socket);
   end Init;

   -------------------------------------------------------------------------

   procedure Init (Socket : in out TCP_Socket_Type)
   is
   begin
      Init (Socket => Socket,
            Family => Socket_Families.Family_Unix,
            Mode   => Stream_Socket);
   end Init;

   -------------------------------------------------------------------------

   function Is_Valid (Path : String) return Boolean
   is
   begin
      return Path'Length in Path_Range;
   end Is_Valid;

   -------------------------------------------------------------------------

   procedure Receive
     (Socket :     UDP_Socket_Type;
      Src    : out Full_Path_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset)
   is
      Path : constant String := Ada.Strings.Unbounded.To_String (Socket.Path);
   begin
      Src := (others => ' ');
      Socket_Type (Socket).Receive (Item => Item,
                                    Last => Last);
      Src (Src'First .. Path'Length) := Path_Type (Path);
   end Receive;

   -------------------------------------------------------------------------

   function To_String (Path : Full_Path_Type) return String
   is
   begin
      return Ada.Strings.Fixed.Trim
        (Source => String (Path),
         Side   => Ada.Strings.Right);
   end To_String;

end Anet.Sockets.Unix;

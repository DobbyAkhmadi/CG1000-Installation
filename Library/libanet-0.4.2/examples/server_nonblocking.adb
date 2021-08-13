--
--  Copyright (C) 2016 Stefan Berghofer <stefan.berghofer@secunet.com>
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

with GNAT.OS_Lib;

with Ada.Text_IO;
with Ada.Streams;
with Ada.Unchecked_Conversion;

with Anet.Sockets.Unix;
with Anet.Constants;

use type Ada.Streams.Stream_Element_Offset;

--  Non-blocking server example.
--  Client: socat UNIX:/tmp/anet.server.nonblocking -
procedure Server_Nonblocking
is
   subtype Stream_Type is Ada.Streams.Stream_Element_Array (1 .. 100);
   subtype String_Type is String (1 .. 100);

   function Stream_To_String is new Ada.Unchecked_Conversion
     (Source => Stream_Type,
      Target => String_Type);

   Socket, Client_Socket : Anet.Sockets.Unix.TCP_Socket_Type;
   Message               : Stream_Type;
   Last                  : Ada.Streams.Stream_Element_Offset;
   Accepted              : Boolean := False;
begin
   Socket.Init;
   Socket.Set_Nonblocking_Mode;
   Socket.Bind ("/tmp/anet.server.nonblocking");
   Socket.Listen;

   loop
      begin
         if Accepted then
            Client_Socket.Receive
              (Item => Message,
               Last => Last);

            if Last /= 0 then
               Ada.Text_IO.Put ("Received message: ");
               Ada.Text_IO.Put_Line (Stream_To_String (Message)
                                     (1 .. Natural (Last)));
            else
               Ada.Text_IO.Put_Line ("Closed connection");
               Client_Socket.Close;
               Accepted := False;
            end if;
         else
            Socket.Accept_Connection
              (New_Socket => Client_Socket);
            Client_Socket.Set_Nonblocking_Mode;
            Ada.Text_IO.Put_Line ("Connection established");
            Accepted := True;
         end if;

      exception
         when Anet.Socket_Error =>
            if GNAT.OS_Lib.Errno = Anet.Constants.Sys.EAGAIN then
               Ada.Text_IO.Put_Line ("Waiting");
               delay 1.0;
            else
               raise;
            end if;
      end;
   end loop;
end Server_Nonblocking;

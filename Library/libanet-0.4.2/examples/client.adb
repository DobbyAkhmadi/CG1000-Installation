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

with Ada.Text_IO;
with Ada.Streams;

with Anet.Streams;
with Anet.Sockets.Unix;

procedure Client is
   Number : Integer := 0;
   Socket : Anet.Sockets.Unix.TCP_Socket_Type;
   Stream : aliased Anet.Streams.Memory_Stream_Type (Max_Elements => 4);
begin
   Socket.Init;
   Socket.Connect (Path => "/tmp/anet.example");

   loop
      Ada.Text_IO.Put_Line ("PING" & Number'Img);
      Integer'Write (Stream'Access, Number);
      Socket.Send (Item => Stream.Get_Buffer);

      declare
         Buffer : Ada.Streams.Stream_Element_Array (1 .. 4);
         Last   : Ada.Streams.Stream_Element_Offset;
      begin
         Socket.Receive (Item => Buffer,
                         Last => Last);
         Stream.Set_Buffer (Buffer => Buffer (Buffer'First .. Last));
         Integer'Read (Stream'Access, Number);
         Ada.Text_IO.Put_Line ("PONG" & Number'Img);
      end;

      delay 1.0;
   end loop;
end Client;

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

with Ada.Streams;
with Ada.Text_IO;

with Anet.Streams;
with Anet.Sockets.Unix;
with Anet.Receivers.Stream;

procedure Server is

   package Unix_TCP_Receiver is new Anet.Receivers.Stream
     (Socket_Type       => Anet.Sockets.Unix.TCP_Socket_Type,
      Address_Type      => Anet.Sockets.Unix.Full_Path_Type,
      Accept_Connection => Anet.Sockets.Unix.Accept_Connection);

   procedure Handle_Request
     (Src       :     Anet.Sockets.Unix.Full_Path_Type;
      Recv_Data :     Ada.Streams.Stream_Element_Array;
      Send_Data : out Ada.Streams.Stream_Element_Array;
      Send_Last : out Ada.Streams.Stream_Element_Offset);
   --  Handle requests from clients.

   procedure Handle_Request
     (Src       :     Anet.Sockets.Unix.Full_Path_Type;
      Recv_Data :     Ada.Streams.Stream_Element_Array;
      Send_Data : out Ada.Streams.Stream_Element_Array;
      Send_Last : out Ada.Streams.Stream_Element_Offset)
   is
      Stream : aliased Anet.Streams.Memory_Stream_Type (Max_Elements => 4);
      Number : Integer;
   begin
      Ada.Text_IO.Put_Line ("Received data on socket "
                            & Anet.Sockets.Unix.To_String (Path => Src));
      Stream.Set_Buffer (Buffer => Recv_Data);
      Integer'Read (Stream'Access, Number);

      Number := Number + 1;

      Integer'Write (Stream'Access, Number);
      Send_Last := Stream.Get_Buffer'Length;
      Send_Data (Send_Data'First .. Send_Last) := Stream.Get_Buffer;
   end Handle_Request;

   Socket   : aliased Anet.Sockets.Unix.TCP_Socket_Type;
   Receiver : Unix_TCP_Receiver.Receiver_Type (S => Socket'Access);
begin
   Socket.Init;
   Socket.Bind (Path => "/tmp/anet.example");
   Receiver.Listen (Callback => Handle_Request'Access);
end Server;

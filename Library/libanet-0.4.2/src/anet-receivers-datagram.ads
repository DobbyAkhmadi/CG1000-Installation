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

with Anet.Sockets;

generic

   Buffer_Size : Ada.Streams.Stream_Element_Offset := 2048;
   --  Receive buffer size.

   type Socket_Type is limited new Sockets.Dgram_Socket_Type with private;
   --  Associated datagram socket.

   type Address_Type is private;
   --  Associated address type.

   with procedure Receive
     (Socket :     Socket_Type;
      Src    : out Address_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset);
   --  Socket receive procedure.

package Anet.Receivers.Datagram is

   Buffsize : constant Ada.Streams.Stream_Element_Offset;
   --  Buffer size used.

   type Rcv_Item_Callback is not null access procedure
     (Item : Ada.Streams.Stream_Element_Array;
      Src  : Address_Type);
   --  Data reception callback procedure. The Item argument contains the
   --  received data, the Src argument identifies the sender of the data.

   type Receiver_Type (S : not null access Socket_Type)
     is tagged limited private;
   --  Listens for incoming data on the given datagram socket and processes it
   --  by calling the registered listen callback.

   function Get_Rcv_Msg_Count (Receiver : Receiver_Type) return Count_Type;
   --  Returns the number of received and processed messages.

   procedure Listen
     (Receiver : in out Receiver_Type;
      Callback :        Rcv_Item_Callback);
   --  Start listening for data on given socket. The given callback is
   --  asynchronously executed upon data reception. Call stop procedure to
   --  properly shutdown the receiver.

   procedure Register_Error_Handler
     (Receiver : in out Receiver_Type;
      Callback :        Error_Handler_Callback);
   --  Register given callback for error handling. The error handler will be
   --  invoked if an exception occurs processing incoming data.
   --  The error handler must be registered before telling the receiver to
   --  listen for data.

   procedure Stop (Receiver : in out Receiver_Type);
   --  Stop listening for data.

   function Is_Listening (Receiver : Receiver_Type) return Boolean;
   --  Returns True if the receiver is currently listening for data.

private

   Buffsize : constant Ada.Streams.Stream_Element_Offset := Buffer_Size;

   task type Receiver_Task (Parent : not null access Receiver_Type) is

      entry Listen (Cb : Rcv_Item_Callback);
      --  Start listening for data on parent's socket. The callback procedure
      --  is called upon reception of new data.

      entry Set_Error_Handler (Cb : Error_Handler_Callback);
      --  Register given callback for error handling. The error handler will be
      --  invoked if an exception occurs processing incoming data.
      --  The task will cease to listen for data if the callback signals it to
      --  terminate by setting the Stop flag to True.

   end Receiver_Task;

   type Receiver_Type
     (S : not null access Socket_Type)
     is tagged limited record
      Item_Count : Protected_Count_Type;
      Trigger    : Trigger_Type;
      R_Task     : Receiver_Task (Parent => Receiver_Type'Access);
   end record;

end Anet.Receivers.Datagram;

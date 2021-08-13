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

package body Anet.Receivers.Datagram is

   procedure Empty_Cb
     (Item : Ada.Streams.Stream_Element_Array;
      Src  : Address_Type) is null;
   --  This placeholder callback is needed for initialization of data reception
   --  callbacks.

   -------------------------------------------------------------------------

   function Get_Rcv_Msg_Count (Receiver : Receiver_Type) return Count_Type
   is
   begin
      return Receiver.Item_Count.Get;
   end Get_Rcv_Msg_Count;

   -------------------------------------------------------------------------

   function Is_Listening (Receiver : Receiver_Type) return Boolean
   is
   begin
      return Receiver.Trigger.Is_Listening;
   end Is_Listening;

   -------------------------------------------------------------------------

   procedure Listen
     (Receiver : in out Receiver_Type;
      Callback :        Rcv_Item_Callback)
   is
   begin
      Receiver.Trigger.Activate;
      Receiver.R_Task.Listen (Cb => Callback);
   end Listen;

   -------------------------------------------------------------------------

   procedure Register_Error_Handler
     (Receiver : in out Receiver_Type;
      Callback :        Error_Handler_Callback)
   is
   begin
      Receiver.R_Task.Set_Error_Handler (Cb => Callback);
   end Register_Error_Handler;

   -------------------------------------------------------------------------

   procedure Stop (Receiver : in out Receiver_Type)
   is
   begin
      Receiver.Trigger.Shutdown;
      Receiver.Trigger.Wait_For_Termination;
   end Stop;

   -------------------------------------------------------------------------

   task body Receiver_Task
   is
      Data_Callback  : Rcv_Item_Callback      := Empty_Cb'Access;
      Error_Callback : Error_Handler_Callback := No_Op_Cb'Access;
      Stop           : Boolean                := False;
   begin
      loop
         Setup_Loop :
         loop
            select
               accept Listen (Cb : Rcv_Item_Callback)
               do
                  Data_Callback := Cb;
               end Listen;

               exit Setup_Loop;

            or
               accept Set_Error_Handler (Cb : Error_Handler_Callback)
               do
                  Error_Callback := Cb;
               end Set_Error_Handler;

            or

               terminate;
            end select;
         end loop Setup_Loop;

         Reception_Loop :
         loop
            declare
               Sender : Address_Type;
               Buffer : Ada.Streams.Stream_Element_Array (1 .. Buffer_Size);
               Last   : Ada.Streams.Stream_Element_Offset;
            begin
               select
                  Parent.Trigger.Stop;
                  exit Reception_Loop;
               then abort
                  Receive
                    (Socket => Parent.S.all,
                     Src    => Sender,
                     Item   => Buffer,
                     Last   => Last);
               end select;

               Data_Callback (Item => Buffer (Buffer'First .. Last),
                              Src  => Sender);
               Parent.Item_Count.Increment;

            exception
               when Ex : others =>
                  Error_Callback (E         => Ex,
                                  Stop_Flag => Stop);
                  if Stop then
                     exit Reception_Loop;
                  end if;
            end;
         end loop Reception_Loop;
         Parent.Trigger.Signal_Termination;
      end loop;
   end Receiver_Task;

end Anet.Receivers.Datagram;

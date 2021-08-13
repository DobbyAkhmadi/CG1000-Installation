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

package body Anet.Receivers.Stream is

   procedure Empty_Cb
     (Src       :     Address_Type;
      Recv_Data :     Ada.Streams.Stream_Element_Array;
      Send_Data : out Ada.Streams.Stream_Element_Array;
      Send_Last : out Ada.Streams.Stream_Element_Offset) is null;

   -------------------------------------------------------------------------

   function Get_Rcv_Msg_Count (Receiver : Receiver_Type) return Count_Type
   is
   begin
      return Receiver.Rcv_Count.Get;
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
      Callback :        Rcv_Send_Callback)
   is
   begin
      Receiver.Trigger.Activate;
      Receiver.S.Listen;
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
      Src            : Address_Type;
      Data_Callback  : Rcv_Send_Callback      := Empty_Cb'Access;
      Error_Callback : Error_Handler_Callback := No_Op_Cb'Access;
      Stop           : Boolean                := False;
   begin
      loop
         Setup_Loop :
         loop
            select
               accept Listen (Cb : Rcv_Send_Callback)
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

         Main_Loop :
         loop
            select
               Parent.Trigger.Stop;
               exit Main_Loop;
            then abort
               Accept_Connection (Socket     => Parent.S.all,
                                  New_Socket => Parent.S_Comm,
                                  Src        => Src);
            end select;

            Processing_Loop :
            loop
               declare
                  use type Ada.Streams.Stream_Element_Offset;

                  R_Buffer, S_Buffer : Ada.Streams.Stream_Element_Array
                    (1 .. Buffer_Size);
                  R_Last, S_Last     : Ada.Streams.Stream_Element_Offset;
               begin
                  select
                     Parent.Trigger.Stop;
                     exit Main_Loop;
                  then abort
                     Parent.S_Comm.Receive (Item => R_Buffer,
                                            Last => R_Last);
                  end select;

                  --  Exit processing loop on connection close.

                  exit Processing_Loop when R_Last = 0;

                  Parent.Rcv_Count.Increment;

                  Data_Callback
                    (Src       => Src,
                     Recv_Data => R_Buffer (R_Buffer'First .. R_Last),
                     Send_Data => S_Buffer,
                     Send_Last => S_Last);

                  Parent.S_Comm.Send
                    (Item => S_Buffer
                       (S_Buffer'First .. S_Last));

               exception
                  when Ex : others =>
                     Error_Callback (E         => Ex,
                                     Stop_Flag => Stop);
                     if Stop then
                        exit Main_Loop;
                     end if;
               end;
            end loop Processing_Loop;
         end loop Main_Loop;
         Parent.Trigger.Signal_Termination;
      end loop;
   end Receiver_Task;

end Anet.Receivers.Stream;

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

with Ada.Exceptions;

with System;

package Anet.Receivers is

   type Count_Type is mod System.Max_Binary_Modulus;

   type Error_Handler_Callback is not null access procedure
     (E         :        Ada.Exceptions.Exception_Occurrence;
      Stop_Flag : in out Boolean);
   --  Error handling callback procedure. E is the exception to handle. The
   --  stop flag signals the receiver to stop listening for data and terminate.

private

   procedure No_Op_Cb
     (E         :        Ada.Exceptions.Exception_Occurrence;
      Stop_Flag : in out Boolean) is null;
   --  This placeholder callback is needed for initialization of error handling
   --  callbacks.

   protected type Trigger_Type is

      procedure Activate;
      --  Activate trigger.

      procedure Shutdown;
      --  Signal shutdown to all tasks waiting on the Stop entry.

      entry Stop;
      --  Entry used for listener ATC.

      procedure Signal_Termination;
      --  Signal termination to all tasks waiting on the Wait_For_Termination
      --  entry.

      entry Wait_For_Termination;
      --  Wait until termination is signaled.

      function Is_Listening return Boolean;
      --  Returns true if the receiver task is currently listening for data.

   private
      Shutdown_Requested : Boolean := False;
      Is_Terminated      : Boolean := True;
   end Trigger_Type;
   --  This trigger is used to terminate receiver tasks by means of ATC.

   protected type Protected_Count_Type is
      function Get return Count_Type;
      procedure Increment;
   private
      Counter : Count_Type := 0;
   end Protected_Count_Type;
   --  This is a protected counter which can be read safely from outside
   --  the task.

end Anet.Receivers;

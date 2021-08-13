--
--  Copyright (C) 2011-2013 secunet Security Networks AG
--  Copyright (C) 2011-2016 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2011-2016 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Anet.Errno;
with Anet.Sockets.Thin;

package body Anet.Sockets is

   package C renames Interfaces.C;

   use type Interfaces.C.unsigned_long;
   use type Interfaces.C.long;

   -------------------------------------------------------------------------

   function Check_Accept (Result : Interfaces.C.int) return Accept_Result_Type
   is
   begin
      if Result = C_Failure then
         if GNAT.OS_Lib.Errno = Constants.Sys.EINTR then

            --  Aborted, most probably via an ATC in the receiver task.

            return Accept_Op_Aborted;
         end if;

         --  Some other error occurred.

         return Accept_Op_Error;
      end if;

      return Accept_Op_Ok;
   end Check_Accept;

   -------------------------------------------------------------------------

   procedure Check_Complete_Send
     (Item      : Ada.Streams.Stream_Element_Array;
      Result    : Interfaces.C.long;
      Error_Msg : String)
   is
      use Ada.Streams;

      Sent_Bytes : constant Stream_Element_Offset
        := Item'First + (Stream_Element_Offset (Result) - Item'First);
   begin
      if Sent_Bytes /= Item'Length then
         raise Socket_Error with Error_Msg & ", only" & Sent_Bytes'Img & " of"
           & Item'Length'Img & " bytes sent";
      end if;
   end Check_Complete_Send;

   -------------------------------------------------------------------------

   function Check_Receive (Result : Interfaces.C.long) return Recv_Result_Type
   is
   begin
      if Result = 0 then

         --  The peer performed an orderly shutdown.

         return Recv_Op_Orderly_Shutdown;
      end if;

      if Result = C_Failure then
         if GNAT.OS_Lib.Errno = Constants.Sys.EINTR then

            --  Aborted, most probably via an ATC in the receiver task.

            return Recv_Op_Aborted;
         end if;

         --  Some other error occurred.

         return Recv_Op_Error;
      end if;

      return Recv_Op_Ok;
   end Check_Receive;

   -------------------------------------------------------------------------

   procedure Close (Socket : in out Socket_Type)
   is
      Res : C.int;
   begin
      if Socket.Sock_FD /= -1 then
         Res := Thin.C_Close (Socket.Sock_FD);
         Errno.Check_Or_Raise
           (Result  => Res,
            Message => "Unable to close socket");
         Socket.Sock_FD  := -1;
         Socket.Protocol := 0;
      end if;
   end Close;

   -------------------------------------------------------------------------

   procedure Finalize (Socket : in out Socket_Type)
   is
   begin
      Socket_Type'Class (Socket).Close;
   end Finalize;

   -------------------------------------------------------------------------

   procedure Init
     (Socket   : in out Socket_Type;
      Family   :        Socket_Families.Family_Type;
      Mode     :        Mode_Type;
      Protocol :        Double_Byte := 0)
   is
      Res : C.int;
   begin
      Res := Thin.C_Socket
        (Domain   => Socket_Families.Families (Family),
         Typ      => Modes (Mode),
         Protocol => C.int (Protocol));
      Errno.Check_Or_Raise
        (Result  => Res,
         Message => "Unable to create socket (" & Family'Img & "/" & Mode'Img &
           ", protocol" & Protocol'Img & ")");

      Socket.Sock_FD  := Res;
      Socket.Protocol := Protocol;
   end Init;

   -------------------------------------------------------------------------

   procedure Listen
     (Socket  : Socket_Type;
      Backlog : Positive := 1)
   is
   begin
      Errno.Check_Or_Raise
        (Result  => Thin.C_Listen
           (Socket  => Socket.Sock_FD,
            Backlog => C.int (Backlog)),
         Message => "Unable to listen on socket with backlog" & Backlog'Img);
   end Listen;

   -------------------------------------------------------------------------

   procedure Receive
     (Socket :     Socket_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset)
   is
      use type Ada.Streams.Stream_Element_Offset;

      Res : C.long;
   begin
      Last := 0;

      Res := Thin.C_Recv (S     => Socket.Sock_FD,
                          Msg   => Item'Address,
                          Len   => Item'Length,
                          Flags => 0);

      case Check_Receive (Result => Res)
      is
         when Recv_Op_Orderly_Shutdown | Recv_Op_Aborted => return;
         when Recv_Op_Error =>
            raise Socket_Error with "Error receiving data from socket: "
              & Errno.Get_Errno_String;
         when Recv_Op_Ok =>
            Last := Item'First + Ada.Streams.Stream_Element_Offset (Res - 1);
      end case;
   end Receive;

   -------------------------------------------------------------------------

   procedure Send
     (Socket : Socket_Type;
      Item   : Ada.Streams.Stream_Element_Array)
   is
      Res : C.long;
   begin
      Res := Thin.C_Send
        (S     => Socket.Sock_FD,
         Buf   => Item'Address,
         Len   => Item'Length,
         Flags => Constants.Sys.MSG_NOSIGNAL);

      Errno.Check_Or_Raise
        (Result  => C.int (Res),
         Message => "Unable to send data on socket");
      Check_Complete_Send
        (Item      => Item,
         Result    => Res,
         Error_Msg => "Incomplete send operation on socket");
   end Send;

   -------------------------------------------------------------------------

   procedure Set_Nonblocking_Mode
     (Socket : Socket_Type;
      Enable : Boolean := True)
   is
      use Interfaces;

      Flags : Unsigned_32 := Unsigned_32
        (Thin.C_Fcntl
           (Fd  => Socket.Sock_FD,
            Cmd => Constants.Sys.F_GETFL,
            Arg => 0));
   begin
      if Enable then
         Flags := Flags or Unsigned_32 (OS_Constants.O_NONBLOCK);
      else
         Flags := Flags and not Unsigned_32 (OS_Constants.O_NONBLOCK);
      end if;

      Errno.Check_Or_Raise
        (Result  => Thin.C_Fcntl
           (Fd  => Socket.Sock_FD,
            Cmd => Constants.Sys.F_SETFL,
            Arg => C.int (Flags)),
         Message => "Unable to set non-blocking mode to " & Enable'Img);
   end Set_Nonblocking_Mode;

   -------------------------------------------------------------------------

   procedure Set_Socket_Option
     (Socket : Socket_Type;
      Level  : Level_Type := Socket_Level;
      Option : Option_Name_Bool;
      Value  : Boolean)
   is
      Val : C.int := C.int (Boolean'Pos (Value));
   begin
      Errno.Check_Or_Raise
        (Result  => Thin.C_Setsockopt
           (S       => Socket.Sock_FD,
            Level   => Levels (Level),
            Optname => Options_Bool (Option),
            Optval  => Val'Address,
            Optlen  => Val'Size / 8),
         Message => "Unable set boolean socket option " & Option'Img & " to " &
           Value'Img);
   end Set_Socket_Option;

   -------------------------------------------------------------------------

   procedure Set_Socket_Option
     (Socket : Socket_Type;
      Level  : Level_Type := Socket_Level;
      Option : Option_Name_Str;
      Value  : String)
   is
      Val : constant C.char_array := C.To_C (Value);
   begin
      Errno.Check_Or_Raise
        (Result  => Thin.C_Setsockopt
           (S       => Socket.Sock_FD,
            Level   => Levels (Level),
            Optname => Options_Str (Option),
            Optval  => Val'Address,
            Optlen  => Val'Size / 8),
         Message => "Unable set string socket option " & Option'Img & " to '" &
           Value & "'");
   end Set_Socket_Option;

   -------------------------------------------------------------------------

   procedure Shutdown
     (Socket : Socket_Type;
      Method : Sock_Shutdown_Cmd)
   is
   begin
      if Socket.Sock_FD /= -1 then
         Errno.Check_Or_Raise
           (Result  => Thin.C_Shutdown
              (S   => Socket.Sock_FD,
               How => Shutdown_Methods (Method)),
            Message => "Unable to shutdown socket");
      end if;
   end Shutdown;

end Anet.Sockets;

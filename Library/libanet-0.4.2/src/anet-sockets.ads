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

private with Ada.Finalization;

with Interfaces.C;

with Anet.Constants;
with Anet.OS_Constants;
with Anet.Socket_Families;

package Anet.Sockets is

   type Mode_Type is
     (Datagram_Socket,
      Raw_Socket,
      Stream_Socket);
   --  Supported socket modes.

   type Level_Type is (Socket_Level, TCP_Level, IPv6_Level);
   --  Protocol level type.

   type Sock_Shutdown_Cmd is
     (Block_Reception,
      Block_Transmission,
      Block_All_Communication);
   --  Socket shutdown methods.

   type Socket_Type is abstract tagged limited private;
   --  Communication socket.

   procedure Close (Socket : in out Socket_Type);
   --  Close given socket.

   procedure Shutdown
     (Socket : Socket_Type;
      Method : Sock_Shutdown_Cmd);
   --  Controlled shutdown of given socket.

   procedure Send
     (Socket : Socket_Type;
      Item   : Ada.Streams.Stream_Element_Array);
   --  Send data on socket to connected endpoint.

   procedure Receive
     (Socket :     Socket_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset);
   --  Receive data from given socket. This procedure blocks until data has
   --  been received. Last is the index value such that Item (Last) is the last
   --  character assigned. An exception is raised if a socket error occurs.

   procedure Listen
     (Socket  : Socket_Type;
      Backlog : Positive := 1);
   --  Listen for specified amount of requests on given socket.

   --  Enable/disable non-blocking mode of operation. Newly created sockets
   --  operate in blocking mode by default.
   procedure Set_Nonblocking_Mode
     (Socket : Socket_Type;
      Enable : Boolean := True);

   type Dgram_Socket_Type is limited interface;
   --  Datagram socket.

   type Stream_Socket_Type is limited interface;
   --  Stream socket.

   procedure Send
     (Socket : Stream_Socket_Type;
      Item   : Ada.Streams.Stream_Element_Array) is abstract;
   --  Send data on socket to connected endpoint.

   procedure Receive
     (Socket :     Stream_Socket_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset) is abstract;
   --  Receive data from given socket. This procedure blocks until data has
   --  been received. Last is the index value such that Item (Last) is the last
   --  character assigned. An exception is raised if a socket error occurs.

   procedure Listen
     (Socket  : Stream_Socket_Type;
      Backlog : Positive := 1) is abstract;
   --  Listen for specified amount of requests on given socket.

   procedure Accept_Connection
     (Socket     :     Stream_Socket_Type;
      New_Socket : out Stream_Socket_Type) is abstract;
   --  Accept first connection request from listening socket and return new
   --  connected socket.

   type Option_Name_Bool is
     (Broadcast,
      Reuse_Address,
      TCP_Nodelay,
      IPv6_V6_Only);
   --  Supported boolean socket options.

   type Option_Name_Str is (Bind_To_Device);
   --  Supported string based socket options.

   procedure Set_Socket_Option
     (Socket : Socket_Type;
      Level  : Level_Type := Socket_Level;
      Option : Option_Name_Bool;
      Value  : Boolean);
   --  Set socket option of given socket to specified boolean value. The level
   --  argument specifies the protocol level this option applies to.

   procedure Set_Socket_Option
     (Socket : Socket_Type;
      Level  : Level_Type := Socket_Level;
      Option : Option_Name_Str;
      Value  : String);
   --  Set socket option of given socket to specified string value. The level
   --  argument specifies the protocol level this option applies to.

private

   use type Interfaces.C.int;

   Modes : constant array (Mode_Type) of Interfaces.C.int
     := (Datagram_Socket => Constants.Sys.SOCK_DGRAM,
         Raw_Socket      => Constants.SOCK_RAW,
         Stream_Socket   => Constants.Sys.SOCK_STREAM);
   --  Socket mode mapping.

   Levels : constant array (Level_Type) of Interfaces.C.int
     := (Socket_Level => Constants.Sys.SOL_SOCKET,
         TCP_Level    => Constants.Sys.IPPROTO_TCP,
         IPv6_Level   => Constants.IPPROTO_IPV6);
   --  Protocol level mapping.

   Options_Bool : constant array (Option_Name_Bool) of Interfaces.C.int
     := (Reuse_Address => Constants.Sys.SO_REUSEADDR,
         Broadcast     => Constants.Sys.SO_BROADCAST,
         TCP_Nodelay   => Constants.Sys.TCP_NODELAY,
         IPv6_V6_Only  => OS_Constants.IPV6_V6ONLY);
   --  Mapping for option names with boolean value.

   Options_Str : constant array (Option_Name_Str) of Interfaces.C.int
     := (Bind_To_Device => Constants.SO_BINDTODEVICE);
   --  Mapping for option names with string value.

   Shutdown_Methods : constant array (Sock_Shutdown_Cmd) of Interfaces.C.int
     := (Block_Reception         => Constants.Sys.SHUT_RD,
         Block_Transmission      => Constants.Sys.SHUT_WR,
         Block_All_Communication => Constants.Sys.SHUT_RDWR);
   --  Mapping of socket shutdown methods.

   type Socket_Type is new Ada.Finalization.Limited_Controlled with record
      Sock_FD  : Interfaces.C.int := -1;
      Protocol : Double_Byte      := 0;
   end record;

   overriding
   procedure Finalize (Socket : in out Socket_Type);
   --  Close socket.

   procedure Init
     (Socket   : in out Socket_Type;
      Family   :        Socket_Families.Family_Type;
      Mode     :        Mode_Type;
      Protocol :        Double_Byte := 0);
   --  Initialize given socket with specified family, mode and protocol.

   procedure Check_Complete_Send
     (Item      : Ada.Streams.Stream_Element_Array;
      Result    : Interfaces.C.long;
      Error_Msg : String);
   --  Verify that a Send operation was able to transmit all bytes of given
   --  buffer by calculating the actual number of bytes sent from the buffer
   --  range and the send(2)/sendto(2) result specified. The procedure raises
   --  an exception starting with the given error message if the check fails.

   type Recv_Result_Type is
     (Recv_Op_Ok,
      Recv_Op_Aborted,
      Recv_Op_Error,
      Recv_Op_Orderly_Shutdown);
   --  Receive operation result status.

   function Check_Receive (Result : Interfaces.C.long) return Recv_Result_Type;
   --  Determine the result of a receive operation.

   type Accept_Result_Type is
     (Accept_Op_Ok,
      Accept_Op_Aborted,
      Accept_Op_Error);
   --  Accept operation result status.

   function Check_Accept (Result : Interfaces.C.int) return Accept_Result_Type;
   --  Determine the result of an accept operation.

end Anet.Sockets;

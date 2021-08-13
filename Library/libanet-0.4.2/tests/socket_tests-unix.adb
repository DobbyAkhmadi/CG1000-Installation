--
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

with Ada.Directories;

with Anet.Sockets.Unix;
with Anet.Receivers.Datagram;
with Anet.Receivers.Stream;
with Anet.Util;

with Test_Utils;

pragma Elaborate_All (Anet.Receivers.Datagram);
pragma Elaborate_All (Anet.Receivers.Stream);

package body Socket_Tests.Unix is

   use Ahven;
   use Anet;
   use type Ada.Streams.Stream_Element_Array;

   package Unix_UDP_Receiver is new Receivers.Datagram
     (Buffer_Size  => 1024,
      Socket_Type  => Sockets.Unix.UDP_Socket_Type,
      Address_Type => Sockets.Unix.Full_Path_Type,
      Receive      => Sockets.Unix.Receive);

   package Unix_TCP_Receiver is new Receivers.Stream
     (Buffer_Size       => 1024,
      Socket_Type       => Sockets.Unix.TCP_Socket_Type,
      Address_Type      => Sockets.Unix.Full_Path_Type,
      Accept_Connection => Sockets.Unix.Accept_Connection);

   procedure Unix_Echo is new Test_Utils.Echo
     (Address_Type => Sockets.Unix.Full_Path_Type);

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Tests for Unix sockets");
      T.Add_Test_Routine
        (Routine => Send_Unix_Stream'Access,
         Name    => "Send data (stream)");
      T.Add_Test_Routine
        (Routine => Send_Unix_Datagram'Access,
         Name    => "Send data (datagram)");
      T.Add_Test_Routine
        (Routine => Send_Various_Buffers'Access,
         Name    => "Send data (various buffer ranges)");
      T.Add_Test_Routine
        (Routine => Unix_Delete_Socket'Access,
         Name    => "Unix socket removal");
      T.Add_Test_Routine
        (Routine => Valid_Unix_Paths'Access,
         Name    => "Unix path validation");
      T.Add_Test_Routine
        (Routine => To_String'Access,
         Name    => "Unix path to string conversion");
   end Initialize;

   -------------------------------------------------------------------------

   procedure Send_Unix_Datagram
   is
      use type Receivers.Count_Type;

      C            : Receivers.Count_Type := 0;
      Path         : constant String      := "/tmp/mysock-"
        & Util.Random_String (Len => 8);
      S_Srv, S_Cli : aliased Sockets.Unix.UDP_Socket_Type;
      Rcvr         : Unix_UDP_Receiver.Receiver_Type (S => S_Srv'Access);
   begin
      S_Srv.Init;
      S_Srv.Bind (Path => Sockets.Unix.Path_Type (Path));
      Util.Wait_For_File (Path     => Path,
                          Timespan => 2.0);

      Rcvr.Listen (Callback => Test_Utils.Dump'Access);

      S_Cli.Init;
      S_Cli.Connect (Path => Sockets.Unix.Path_Type (Path));
      S_Cli.Send (Item => Ref_Chunk);

      for I in 1 .. 30 loop
         C := Rcvr.Get_Rcv_Msg_Count;
         exit when C > 0;
         delay 0.1;
      end loop;

      Rcvr.Stop;

      Assert (Condition => C = 1,
              Message   => "Message count not 1:" & C'Img);
      Assert (Condition => Test_Utils.Get_Dump = Ref_Chunk,
              Message   => "Result mismatch");
      Assert (Condition => Path = Sockets.Unix.To_String
              (Path => Test_Utils.Get_Last_Address),
              Message   => "Source path mismatch");

   exception
      when others =>
         Rcvr.Stop;
         raise;
   end Send_Unix_Datagram;

   -------------------------------------------------------------------------

   procedure Send_Unix_Stream
   is
      use type Receivers.Count_Type;

      C            : Receivers.Count_Type := 0;
      Path         : constant String      := "/tmp/mysock-"
        & Util.Random_String (Len => 8);
      S_Srv, S_Cli : aliased Sockets.Unix.TCP_Socket_Type;
      Rcvr         : Unix_TCP_Receiver.Receiver_Type (S => S_Srv'Access);
   begin
      S_Srv.Init;
      S_Srv.Bind (Path => Sockets.Unix.Path_Type (Path));
      Util.Wait_For_File (Path     => Path,
                          Timespan => 2.0);

      Rcvr.Listen (Callback => Unix_Echo'Access);

      S_Cli.Init;
      S_Cli.Connect (Path => Sockets.Unix.Path_Type (Path));
      S_Cli.Send (Item => Ref_Chunk);

      for I in 1 .. 30 loop
         C := Rcvr.Get_Rcv_Msg_Count;
         exit when C > 0;
         delay 0.1;
      end loop;

      Assert (Condition => C = 1,
              Message   => "Message count not 1:" & C'Img);

      declare
         Buffer : Ada.Streams.Stream_Element_Array
           (1 .. Unix_TCP_Receiver.Buffsize);
         Last   : Ada.Streams.Stream_Element_Offset;
      begin
         S_Cli.Receive (Item => Buffer,
                        Last => Last);
         Rcvr.Stop;

         Assert (Condition => Buffer (Buffer'First .. Last) = Ref_Chunk,
                 Message   => "Response mismatch");
      end;

   exception
      when others =>
         Rcvr.Stop;
         raise;
   end Send_Unix_Stream;

   -------------------------------------------------------------------------

   procedure Send_Various_Buffers
   is
      use Ada.Streams;

      Last  : Stream_Element_Offset;
      R     : Stream_Element_Array (1 .. 10);
      S_Cli : aliased Sockets.Unix.UDP_Socket_Type;
      Path  : constant String := "/tmp/mysock-" & Util.Random_String
        (Len => 8);

      task Receiver is
         entry Ready;
      end Receiver;

      task body Receiver is
         S_Srv : aliased Sockets.Unix.UDP_Socket_Type;
      begin
         S_Srv.Init;
         S_Srv.Bind (Path => Sockets.Unix.Path_Type (Path));
         loop
            S_Srv.Receive (Item => R,
                           Last => Last);
            accept Ready;
         end loop;
      end Receiver;
   begin
      Util.Wait_For_File (Path     => Path,
                          Timespan => 2.0);

      S_Cli.Init;
      S_Cli.Connect (Path => Sockets.Unix.Path_Type (Path));

      declare
         B : constant Stream_Element_Array (1 .. 10) := (others => 12);
      begin
         S_Cli.Send (Item => B);
         select
            delay 2.0;
         then abort
            Receiver.Ready;
         end select;
         Assert (Condition => B = R,
                 Message   => "Result mismatch (1 .. 10)");
         Assert (Condition => Last = 10,
                 Message   => "Last mismatch (1 .. 10)");
         R := (others => 0);
      end;

      declare
         B : constant Stream_Element_Array (0 .. 9) := (others => 12);
      begin
         S_Cli.Send (Item => B);
         select
            delay 2.0;
         then abort
            Receiver.Ready;
         end select;
         Assert (Condition => B = R,
                 Message   => "Result mismatch (0 .. 9)");
         Assert (Condition => Last = 10,
                 Message   => "Last mismatch (0 .. 9)");
         R := (others => 0);
      end;

      declare
         B : constant Stream_Element_Array (5 .. 14) := (others => 12);
      begin
         S_Cli.Send (Item => B);
         select
            delay 2.0;
         then abort
            Receiver.Ready;
         end select;
         Assert (Condition => B = R,
                 Message   => "Result mismatch (5 .. 14)");
         Assert (Condition => Last = 10,
                 Message   => "Last mismatch (5 .. 14)");
         R := (others => 0);
      end;

      declare
         Empty : constant Stream_Element_Array (1 .. 0) := (others => 0);
      begin
         S_Cli.Send (Item => Empty);
         select
            delay 2.0;
         then abort
            Receiver.Ready;
         end select;
         Assert (Condition => Last = 0,
                 Message   => "Last mismatch (1 .. 0)");
      end;

      abort Receiver;

   exception
      when others =>
         if not Receiver'Terminated then
            abort Receiver;
         end if;
         raise;
   end Send_Various_Buffers;

   -------------------------------------------------------------------------

   procedure To_String
   is
      use Anet.Sockets.Unix;

      Ref_Path_1 : constant Full_Path_Type := (others => 'a');
      Ref_Path_2 : constant Full_Path_Type := (others => ' ');
      Ref_Path_3 : constant Path_Type
        := Path_Type ("/tmp/my-sock" & Util.Random_String (Len => 8));
   begin
      Assert (Condition => To_String
              (Path => Ref_Path_1) = String (Ref_Path_1),
              Message   => "Path mismatch (1)");
      Assert (Condition => To_String (Path => Ref_Path_2) = "",
              Message   => "Path mismatch (2)");

      declare
         Path : Full_Path_Type := (others => ' ');
      begin
         Path (Path'First .. Ref_Path_3'Length) := Ref_Path_3;
         Assert (Condition => To_String (Path => Path) = String (Ref_Path_3),
                 Message   => "Path mismatch (3)");
      end;
   end To_String;

   -------------------------------------------------------------------------

   procedure Unix_Delete_Socket
   is
      Path : constant String := "./my_socket";
   begin
      declare
         Sock : Sockets.Unix.UDP_Socket_Type;
      begin
         Sock.Init;
         Sock.Bind (Path => Sockets.Unix.Path_Type (Path));
         Assert (Condition => Ada.Directories.Exists (Name => Path),
                 Message   => "Path not found");
      end;
      Assert (Condition => not Ada.Directories.Exists (Name => Path),
              Message   => "Socket path still there");
   end Unix_Delete_Socket;

   -------------------------------------------------------------------------

   procedure Valid_Unix_Paths
   is
      Too_Long : constant String
        := (1 .. Sockets.Unix.Path_Range'Last + 1 => 'a');
   begin
      Assert (Condition => Sockets.Unix.Is_Valid (Path => "/tmp/foopath"),
              Message   => "Invalid path '/tmp/foopath'");
      Assert (Condition => not Sockets.Unix.Is_Valid (Path => ""),
              Message   => "Valid empty path");
      Assert (Condition => not Sockets.Unix.Is_Valid (Path => Too_Long),
              Message   => "Valid Path '" & Too_Long & "'");
   end Valid_Unix_Paths;

end Socket_Tests.Unix;

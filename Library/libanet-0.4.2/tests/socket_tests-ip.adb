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

with Ada.Streams;
with Ada.Exceptions;

with Anet.Sockets.Inet;
with Anet.Receivers.Datagram;
with Anet.Receivers.Stream;

with Test_Utils;
with Test_Constants;

pragma Elaborate_All (Anet.Receivers.Datagram);
pragma Elaborate_All (Anet.Receivers.Stream);

package body Socket_Tests.IP is

   use Ahven;
   use Anet;
   use Anet.Sockets;
   use type Ada.Streams.Stream_Element_Array;

   package UDPv4_Receiver is new Receivers.Datagram
     (Buffer_Size  => 1024,
      Socket_Type  => Inet.UDPv4_Socket_Type,
      Address_Type => Inet.IPv4_Sockaddr_Type,
      Receive      => Inet.Receive);

   package UDPv6_Receiver is new Receivers.Datagram
     (Buffer_Size  => 1024,
      Socket_Type  => Inet.UDPv6_Socket_Type,
      Address_Type => Inet.IPv6_Sockaddr_Type,
      Receive      => Inet.Receive);

   package TCPv4_Receiver is new Receivers.Stream
     (Buffer_Size       => 1024,
      Socket_Type       => Inet.TCPv4_Socket_Type,
      Address_Type      => Inet.IPv4_Sockaddr_Type,
      Accept_Connection => Inet.Accept_Connection);

   package TCPv6_Receiver is new Receivers.Stream
     (Buffer_Size       => 1024,
      Socket_Type       => Inet.TCPv6_Socket_Type,
      Address_Type      => Inet.IPv6_Sockaddr_Type,
      Accept_Connection => Inet.Accept_Connection);

   procedure Error_Handler
     (E         :        Ada.Exceptions.Exception_Occurrence;
      Stop_Flag : in out Boolean);
   --  Receiver error handler callback for testing purposes. It ignores the
   --  exception and tells the receiver to terminate by setting the stop flag.

   procedure Inet4_Echo is new Test_Utils.Echo
     (Address_Type => Inet.IPv4_Sockaddr_Type);
   procedure Inet6_Echo is new Test_Utils.Echo
     (Address_Type => Inet.IPv6_Sockaddr_Type);

   -------------------------------------------------------------------------

   procedure Accept_Source_V4
   is
      Src : Inet.IPv4_Sockaddr_Type
        := (Addr => Any_Addr,
            Port => Any_Port);

      Cli_Port : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;
      Srv_Port : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;

      task Server is
         entry Start;
         entry Finished;
      end Server;

      task body Server
      is
         Sock, New_Sock : Inet.TCPv4_Socket_Type;
      begin
         Sock.Init;
         Sock.Bind (Address => Loopback_Addr_V4,
                    Port    => Srv_Port);
         Sock.Listen;

         accept Start;
         Sock.Accept_Connection (New_Socket => New_Sock,
                                 Src        => Src);

         accept Finished;
      end Server;

      Cli     : Inet.TCPv4_Socket_Type;
      Aborted : Boolean := False;
   begin
      Cli.Init;
      Cli.Bind (Address => Loopback_Addr_V4,
                Port    => Cli_Port);

      Server.Start;
      Cli.Connect (Address => Loopback_Addr_V4,
                   Port    => Srv_Port);

      select
         delay 2.0;
         Aborted := True;
      then abort
         Server.Finished;
      end select;
      Assert (Condition => not Aborted,
              Message   => "Task aborted");

      Assert (Condition => Src.Addr = Loopback_Addr_V4,
              Message   => "Source address mismatch: "
              & Anet.To_String (Address => Src.Addr));
      Assert (Condition => Src.Port = Cli_Port,
              Message   => "Source port mismatch:" & Src.Port'Img);

   exception
      when others =>
         abort Server;
         raise;
   end Accept_Source_V4;

   -------------------------------------------------------------------------

   procedure Accept_Source_V6
   is
      Src : Inet.IPv6_Sockaddr_Type
        := (Addr => Any_Addr_V6,
            Port => Any_Port);

      Cli_Port : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;
      Srv_Port : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;

      task Server is
         entry Start;
         entry Finished;
      end Server;

      task body Server
      is
         Sock, New_Sock : Inet.TCPv6_Socket_Type;
      begin
         Sock.Init;
         Sock.Bind (Address => Loopback_Addr_V6,
                    Port    => Srv_Port);
         Sock.Listen;

         accept Start;
         Sock.Accept_Connection (New_Socket => New_Sock,
                                 Src        => Src);

         accept Finished;
      end Server;

      Cli     : Inet.TCPv6_Socket_Type;
      Aborted : Boolean := False;
   begin
      Cli.Init;
      Cli.Bind (Address => Loopback_Addr_V6,
                Port    => Cli_Port);

      Server.Start;
      Cli.Connect (Address => Loopback_Addr_V6,
                   Port    => Srv_Port);

      select
         delay 2.0;
         Aborted := True;
      then abort
         Server.Finished;
      end select;
      Assert (Condition => not Aborted,
              Message   => "Task aborted");

      Assert (Condition => Src.Addr = Loopback_Addr_V6,
              Message   => "Source address mismatch: "
              & Anet.To_String (Address => Src.Addr));
      Assert (Condition => Src.Port = Cli_Port,
              Message   => "Source port mismatch:" & Src.Port'Img);

   exception
      when others =>
         abort Server;
         raise;
   end Accept_Source_V6;

   -------------------------------------------------------------------------

   procedure Error_Callbacks
   is
      Sock : aliased Inet.UDPv4_Socket_Type;
      Port : constant Test_Utils.Test_Port_Type := Test_Utils.Get_Random_Port;
   begin
      Sock.Init;
      Sock.Bind (Address => Loopback_Addr_V4,
                 Port    => Port);

      declare
         Rcvr : UDPv4_Receiver.Receiver_Type (S => Sock'Access);
      begin
         Rcvr.Listen (Callback => Test_Utils.Raise_Error'Access);

         Sock.Send (Item     => Ref_Chunk,
                    Dst_Addr => Loopback_Addr_V4,
                    Dst_Port => Port);

         --  By default all errors should be ignored

         Assert (Condition => Rcvr.Is_Listening,
                 Message   => "Receiver not listening");

         Rcvr.Stop;

      exception
         when others =>
            Rcvr.Stop;
            raise;
      end;

      declare
         Rcvr : UDPv4_Receiver.Receiver_Type (S => Sock'Access);
      begin
         Rcvr.Register_Error_Handler (Callback => Error_Handler'Access);
         Rcvr.Listen (Callback => Test_Utils.Raise_Error'Access);

         Sock.Send (Item     => Ref_Chunk,
                    Dst_Addr => Loopback_Addr_V4,
                    Dst_Port => Port);

         for I in 1 .. 30 loop
            exit when not Rcvr.Is_Listening;
            delay 0.1;
         end loop;

         Assert (Condition => not Rcvr.Is_Listening,
                 Message   => "Receiver still listening");

         Rcvr.Listen (Callback => Test_Utils.Raise_Error'Access);
         Assert (Condition => Rcvr.Is_Listening,
                 Message   => "Receiver not restarted");
         Rcvr.Stop;

      exception
         when others =>
            Rcvr.Stop;
            raise;
      end;
   end Error_Callbacks;

   -------------------------------------------------------------------------

   procedure Error_Handler
     (E         :        Ada.Exceptions.Exception_Occurrence;
      Stop_Flag : in out Boolean)
   is
      pragma Unreferenced (E);
   begin
      Stop_Flag := True;
   end Error_Handler;

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Tests for IP sockets");
      T.Add_Test_Routine
        (Routine => Send_V4_Stream'Access,
         Name    => "Send data (IPv4, stream)");
      T.Add_Test_Routine
        (Routine => Send_V4_Datagram'Access,
         Name    => "Send data (IPv4, datagram)");
      T.Add_Test_Routine
        (Routine => Send_V6_Stream'Access,
         Name    => "Send data (IPv6, stream)");
      T.Add_Test_Routine
        (Routine => Send_V6_Datagram'Access,
         Name    => "Send data (IPv6, datagram)");
      T.Add_Test_Routine
        (Routine => Send_Multicast_V4'Access,
         Name    => "Send data (IPv4, multicast)");
      T.Add_Test_Routine
        (Routine => Send_Multicast_V6'Access,
         Name    => "Send data (IPv6, multicast)");
      T.Add_Test_Routine
        (Routine => Listen_Callbacks'Access,
         Name    => "Data reception callback handling");
      T.Add_Test_Routine
        (Routine => Error_Callbacks'Access,
         Name    => "Error callback handling");
      T.Add_Test_Routine
        (Routine => Non_Blocking'Access,
         Name    => "Non-blocking operation");
      T.Add_Test_Routine
        (Routine => Shutdown_Socket'Access,
         Name    => "Shutdown socket (IPv4)");
      T.Add_Test_Routine
        (Routine => Accept_Source_V4'Access,
         Name    => "Peer src after accept (IPv4)");
      T.Add_Test_Routine
        (Routine => Accept_Source_V6'Access,
         Name    => "Peer src after accept (IPv6)");
      T.Add_Test_Routine
        (Routine => Receive_Source_V4'Access,
         Name    => "Peer src after receive (IPv4)");
      T.Add_Test_Routine
        (Routine => Receive_Source_V6'Access,
         Name    => "Peer src after receive (IPv6)");
   end Initialize;

   -------------------------------------------------------------------------

   procedure Listen_Callbacks
   is
      use type Receivers.Count_Type;

      C    : Receivers.Count_Type := 0;
      Sock : aliased Inet.UDPv4_Socket_Type;
      Rcvr : UDPv4_Receiver.Receiver_Type (S => Sock'Access);
      Port : constant Test_Utils.Test_Port_Type := Test_Utils.Get_Random_Port;
   begin
      Sock.Init;
      Sock.Bind (Address => Loopback_Addr_V4,
                 Port    => Port);
      Rcvr.Listen (Callback => Test_Utils.Dump'Access);

      Assert (Condition => Rcvr.Is_Listening,
              Message   => "Receiver not listening");

      Sock.Send (Item     => Ref_Chunk,
                 Dst_Addr => Loopback_Addr_V4,
                 Dst_Port => Port);

      for I in 1 .. 30 loop
         C := Rcvr.Get_Rcv_Msg_Count;
         exit when C > 0;
         delay 0.1;
      end loop;

      Rcvr.Stop;

      Assert (Condition => not Rcvr.Is_Listening,
              Message   => "Receiver still listening");

      Assert (Condition => C = 1,
              Message   => "Message count not 1:" & C'Img);
      Assert (Condition => Test_Utils.Get_Dump = Ref_Chunk,
              Message   => "Result mismatch");

   exception
      when others =>
         Rcvr.Stop;
         raise;
   end Listen_Callbacks;

   -------------------------------------------------------------------------

   procedure Non_Blocking
   is
      Sock    : Inet.UDPv4_Socket_Type;
      Buffer  : Ada.Streams.Stream_Element_Array (1 .. 1);
      Last    : Ada.Streams.Stream_Element_Offset;
      Aborted : Boolean := False;
      Port    : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;
   begin
      Sock.Init;
      Sock.Set_Nonblocking_Mode (Enable => True);
      Sock.Bind (Address => Loopback_Addr_V4,
                 Port    => Port);

      begin
         select
            delay 2.0;
            Aborted := True;
         then abort
            Sock.Receive (Item => Buffer,
                          Last => Last);
         end select;
         Assert (Condition => not Aborted,
                 Message   => "Receive aborted");

      exception
         when Socket_Error => null;
      end;

      Sock.Set_Nonblocking_Mode (Enable => False);

      --  This should block again.

      select
         delay 2.0;
         Aborted := True;
      then abort
         Sock.Receive (Item => Buffer,
                       Last => Last);
      end select;
      Assert (Condition => Aborted,
              Message   => "Receive not aborted");
   end Non_Blocking;

   -------------------------------------------------------------------------

   procedure Receive_Source_V4
   is
      Src : Inet.IPv4_Sockaddr_Type
        := (Addr => Any_Addr,
            Port => Any_Port);

      Cli_Port : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;
      Srv_Port : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;

      task Server;

      task body Server
      is
         Cli : Inet.UDPv4_Socket_Type;
      begin
         Cli.Init;
         Cli.Bind (Address => Loopback_Addr_V4,
                   Port    => Cli_Port);

         --  Precautionary delay to make sure receiver is ready.

         delay 0.2;

         Cli.Send (Item     => Ada.Streams.Stream_Element_Array'(1 => 12),
                   Dst_Addr => Loopback_Addr_V4,
                   Dst_Port => Srv_Port);
      end Server;

      Sock    : Inet.UDPv4_Socket_Type;
      Buffer  : Ada.Streams.Stream_Element_Array (1 .. 1);
      Last    : Ada.Streams.Stream_Element_Offset;
      Aborted : Boolean := False;
   begin
      Sock.Init;
      Sock.Bind (Address => Loopback_Addr_V4,
                 Port    => Srv_Port);

      select
         delay 2.0;
         Aborted := True;
      then abort
         Sock.Receive (Src  => Src,
                       Item => Buffer,
                       Last => Last);
      end select;
      Assert (Condition => not Aborted,
              Message   => "Receive aborted");

      Assert (Condition => Src.Addr = Loopback_Addr_V4,
              Message   => "Source address mismatch: "
              & Anet.To_String (Address => Src.Addr));
      Assert (Condition => Src.Port = Cli_Port,
              Message   => "Source port mismatch:" & Src.Port'Img);

   exception
      when others =>
         abort Server;
         raise;
   end Receive_Source_V4;

   -------------------------------------------------------------------------

   procedure Receive_Source_V6
   is
      Src : Inet.IPv6_Sockaddr_Type
        := (Addr => Any_Addr_V6,
            Port => Any_Port);

      Cli_Port : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;
      Srv_Port : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;

      task Server;

      task body Server
      is
         Cli : Inet.UDPv6_Socket_Type;
      begin
         Cli.Init;
         Cli.Bind (Address => Loopback_Addr_V6,
                   Port    => Cli_Port);

         --  Precautionary delay to make sure receiver is ready.

         delay 0.2;

         Cli.Send (Item     => Ada.Streams.Stream_Element_Array'(1 => 12),
                   Dst_Addr => Loopback_Addr_V6,
                   Dst_Port => Srv_Port);
      end Server;

      Sock    : Inet.UDPv6_Socket_Type;
      Buffer  : Ada.Streams.Stream_Element_Array (1 .. 1);
      Last    : Ada.Streams.Stream_Element_Offset;
      Aborted : Boolean := False;
   begin
      Sock.Init;
      Sock.Bind (Address => Loopback_Addr_V6,
                 Port    => Srv_Port);

      select
         delay 2.0;
         Aborted := True;
      then abort
         Sock.Receive (Src  => Src,
                       Item => Buffer,
                       Last => Last);
      end select;
      Assert (Condition => not Aborted,
              Message   => "Receive aborted");

      Assert (Condition => Src.Addr = Loopback_Addr_V6,
              Message   => "Source address mismatch: "
              & Anet.To_String (Address => Src.Addr));
      Assert (Condition => Src.Port = Cli_Port,
              Message   => "Source port mismatch:" & Src.Port'Img);

   exception
      when others =>
         abort Server;
         raise;
   end Receive_Source_V6;

   -------------------------------------------------------------------------

   procedure Send_Multicast_V4
   is
      use type Receivers.Count_Type;

      C    : Receivers.Count_Type := 0;
      Sock : aliased Inet.UDPv4_Socket_Type;
      Rcvr : UDPv4_Receiver.Receiver_Type (S => Sock'Access);
      Port : constant Test_Utils.Test_Port_Type := Test_Utils.Get_Random_Port;
      Grp  : constant IPv4_Addr_Type
        := To_IPv4_Addr (Str => "224.0.0.117");
   begin
      Sock.Init;
      Sock.Bind (Address => Grp,
                 Port    => Port);
      Sock.Join_Multicast_Group
        (Group => Grp,
         Iface => Test_Constants.Loopback_Iface_Name);
      Sock.Multicast_Set_Sending_Interface
        (Iface_Addr => Loopback_Addr_V4);

      Rcvr.Listen (Callback => Test_Utils.Dump'Access);

      --  Precautionary delay to make sure receiver task is ready.

      delay 0.2;

      Sock.Send (Item     => Ref_Chunk,
                 Dst_Addr => Grp,
                 Dst_Port => Port);

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

   exception
      when others =>
         Rcvr.Stop;
         raise;
   end Send_Multicast_V4;

   -------------------------------------------------------------------------

   procedure Send_Multicast_V6
   is
      use type Receivers.Count_Type;
      use type Test_Utils.OS_Type;

      C    : Receivers.Count_Type := 0;
      Sock : aliased Inet.UDPv6_Socket_Type;
      Rcvr : UDPv6_Receiver.Receiver_Type (S => Sock'Access);
      Port : constant Test_Utils.Test_Port_Type := Test_Utils.Get_Random_Port;
      Grp  : constant IPv6_Addr_Type
        := To_IPv6_Addr (Str => "ff04:0000:0000:0000:0000:0000:0001:0002");
   begin
      if Test_Utils.OS = Test_Utils.BSD then
         Skip (Message => "Not supported");
      end if;

      Sock.Init;
      Sock.Bind (Address => Grp,
                 Port    => Port);
      Sock.Join_Multicast_Group (Group => Grp);

      Rcvr.Listen (Callback => Test_Utils.Dump'Access);

      --  Precautionary delay to make sure receiver task is ready.

      delay 0.2;

      Sock.Send (Item     => Ref_Chunk,
                 Dst_Addr => Grp,
                 Dst_Port => Port);

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

   exception
      when others =>
         Rcvr.Stop;
         raise;
   end Send_Multicast_V6;

   -------------------------------------------------------------------------

   procedure Send_V4_Datagram
   is
      use type Receivers.Count_Type;

      C    : Receivers.Count_Type := 0;
      Sock : aliased Inet.UDPv4_Socket_Type;
      Rcvr : UDPv4_Receiver.Receiver_Type (S => Sock'Access);
      Port : constant Test_Utils.Test_Port_Type := Test_Utils.Get_Random_Port;
   begin
      Sock.Init;
      Sock.Bind (Address => Loopback_Addr_V4,
                 Port    => Port);

      Rcvr.Listen (Callback => Test_Utils.Dump'Access);

      --  Precautionary delay to make sure receiver task is ready.

      delay 0.2;

      Sock.Send (Item     => Ref_Chunk,
                 Dst_Addr => Loopback_Addr_V4,
                 Dst_Port => Port);

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
      Assert (Condition => Test_Utils.Get_Last_Address.Addr = Loopback_Addr_V4,
              Message   => "Address mismatch");

   exception
      when others =>
         Rcvr.Stop;
         raise;
   end Send_V4_Datagram;

   -------------------------------------------------------------------------

   procedure Send_V4_Stream
   is
      use type Receivers.Count_Type;

      C            : Receivers.Count_Type := 0;
      S_Srv, S_Cli : aliased Inet.TCPv4_Socket_Type;
      Rcvr         : TCPv4_Receiver.Receiver_Type (S => S_Srv'Access);
      Port         : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;
   begin
      S_Srv.Init;
      S_Srv.Bind (Address => Loopback_Addr_V4,
                  Port    => Port);

      Rcvr.Listen (Callback => Inet4_Echo'Access);

      --  Precautionary delay to make sure receiver task is ready.

      delay 0.2;

      S_Cli.Init;
      S_Cli.Bind (Address => Loopback_Addr_V4,
                  Port    => Port + 1);
      S_Cli.Connect (Address => Loopback_Addr_V4,
                     Port    => Port);
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
           (1 .. TCPv4_Receiver.Buffsize);
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
   end Send_V4_Stream;

   -------------------------------------------------------------------------

   procedure Send_V6_Datagram
   is
      use type Receivers.Count_Type;

      C    : Receivers.Count_Type := 0;
      Sock : aliased Inet.UDPv6_Socket_Type;
      Rcvr : UDPv6_Receiver.Receiver_Type (S => Sock'Access);
      Port : constant Test_Utils.Test_Port_Type := Test_Utils.Get_Random_Port;
   begin
      Sock.Init;
      Sock.Bind (Address => Loopback_Addr_V6,
                 Port    => Port);

      Rcvr.Listen (Callback => Test_Utils.Dump'Access);

      --  Precautionary delay to make sure receiver task is ready.

      delay 0.2;

      Sock.Send (Item     => Ref_Chunk,
                 Dst_Addr => Loopback_Addr_V6,
                 Dst_Port => Port);

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
      Assert (Condition => Test_Utils.Get_Last_Address.Addr = Loopback_Addr_V6,
              Message   => "Address mismatch");

   exception
      when others =>
         Rcvr.Stop;
         raise;
   end Send_V6_Datagram;

   -------------------------------------------------------------------------

   procedure Send_V6_Stream
   is
      use type Receivers.Count_Type;

      C            : Receivers.Count_Type := 0;
      S_Srv, S_Cli : aliased Inet.TCPv6_Socket_Type;
      Rcvr         : TCPv6_Receiver.Receiver_Type (S => S_Srv'Access);
      Port         : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;
   begin
      S_Srv.Init;
      S_Srv.Bind (Address => Loopback_Addr_V6,
                  Port    => Port);

      Rcvr.Listen (Callback => Inet6_Echo'Access);

      --  Precautionary delay to make sure receiver task is ready.

      delay 0.2;

      S_Cli.Init;
      S_Cli.Set_Socket_Option
        (Level  => IPv6_Level,
         Option => IPv6_V6_Only,
         Value  => True);
      S_Cli.Bind (Address => Loopback_Addr_V6,
                  Port    => Port + 1);
      S_Cli.Connect (Address => Loopback_Addr_V6,
                     Port    => Port);
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
           (1 .. TCPv4_Receiver.Buffsize);
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
   end Send_V6_Stream;

   -------------------------------------------------------------------------

   procedure Shutdown_Socket
   is
      use type Ada.Streams.Stream_Element_Offset;

      Buffer       : Ada.Streams.Stream_Element_Array (1 .. 1024);
      Last         : Ada.Streams.Stream_Element_Offset;
      S_Srv, S_Cli : aliased Inet.TCPv4_Socket_Type;
      Rcvr         : TCPv4_Receiver.Receiver_Type (S => S_Srv'Access);
      Port         : constant Test_Utils.Test_Port_Type
        := Test_Utils.Get_Random_Port;
   begin
      S_Srv.Init;
      S_Srv.Bind (Address => Loopback_Addr_V4,
                  Port    => Port);
      Rcvr.Listen (Callback => Inet4_Echo'Access);

      --  Precautionary delay to make sure receiver task is ready.

      delay 0.2;

      S_Cli.Init;
      S_Cli.Bind (Address => Loopback_Addr_V4,
                  Port    => Port + 1);
      S_Cli.Connect (Address => Loopback_Addr_V4,
                     Port    => Port);
      S_Cli.Send (Item => Ref_Chunk);

      --  Confirm sending and receiving work as expected.

      begin
         S_Cli.Receive (Item => Buffer,
                        Last => Last);

         Assert (Condition => Buffer (Buffer'First .. Last) = Ref_Chunk,
                 Message   => "Response mismatch");
      end;

      --  Confirm error occurs when sending on a socket that has shut down
      --  sending before the server socket is closed.

      S_Cli.Shutdown (Method => Block_Transmission);

      begin
         S_Cli.Send (Item => Ref_Chunk);
         Fail (Message => "Exception expected");

      exception
         when Socket_Error => null;
      end;

      --  Confirm that there are no bytes received on a socket that has blocked
      --  reception before the server socket is closed.

      S_Cli.Shutdown (Method => Block_Reception);

      S_Cli.Receive (Item => Buffer,
                     Last => Last);
      Assert (Condition => Last = 0,
              Message   => "Last not zero");

      Rcvr.Stop;
      S_Cli.Close; --  Redundant
      S_Srv.Close;

   exception
      when others =>
         Rcvr.Stop;
         S_Cli.Close;
         S_Srv.Close;
         raise;
   end Shutdown_Socket;

end Socket_Tests.IP;

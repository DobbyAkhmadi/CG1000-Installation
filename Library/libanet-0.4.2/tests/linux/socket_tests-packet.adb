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

with Anet.Sockets.Packet;
with Anet.Receivers.Datagram;

with Test_Constants;
with Test_Utils.GNU_Linux;

pragma Elaborate_All (Anet.Receivers.Datagram);

package body Socket_Tests.Packet is

   use Ahven;
   use Anet;
   use type Ada.Streams.Stream_Element_Array;

   package Packet_UDP_Receiver is new Receivers.Datagram
     (Buffer_Size  => 1024,
      Socket_Type  => Sockets.Packet.UDP_Socket_Type,
      Address_Type => Ether_Addr_Type,
      Receive      => Sockets.Packet.Receive);

   package Packet_Raw_Receiver is new Receivers.Datagram
     (Buffer_Size  => 1024,
      Socket_Type  => Sockets.Packet.Raw_Socket_Type,
      Address_Type => Ether_Addr_Type,
      Receive      => Sockets.Packet.Receive);

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Tests for Packet sockets");
      T.Add_Test_Routine
        (Routine => Send_Packet_Datagram'Access,
         Name    => "Send data (datagram)");
      T.Add_Test_Routine
        (Routine => Send_Packet_Raw'Access,
         Name    => "Send data (raw)");
   end Initialize;

   -------------------------------------------------------------------------

   procedure Send_Packet_Datagram
   is
      use type Receivers.Count_Type;

      C    : Receivers.Count_Type := 0;
      Sock : aliased Sockets.Packet.UDP_Socket_Type;
      Rcvr : Packet_UDP_Receiver.Receiver_Type (S => Sock'Access);
   begin
      if not Test_Utils.Has_Root_Perms then
         Skip (Message => "Run as root");
      end if;

      Sock.Init;
      Sock.Bind (Iface => Test_Constants.Loopback_Iface_Name);

      Rcvr.Listen (Callback => Test_Utils.GNU_Linux.Dump'Access);

      --  Precautionary delay to make sure receiver task is ready.

      delay 0.2;

      Sock.Send (Item  => Ref_Chunk,
                 To    => Bcast_HW_Addr,
                 Iface => Test_Constants.Loopback_Iface_Name);

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
   end Send_Packet_Datagram;

   -------------------------------------------------------------------------

   procedure Send_Packet_Raw
   is
      use type Receivers.Count_Type;

      C    : Receivers.Count_Type := 0;
      Sock : aliased Sockets.Packet.Raw_Socket_Type;
      Rcvr : Packet_Raw_Receiver.Receiver_Type (S => Sock'Access);
   begin
      if not Test_Utils.Has_Root_Perms then
         Skip (Message => "Run as root");
      end if;

      Sock.Init;
      Sock.Bind (Iface => Test_Constants.Loopback_Iface_Name);

      Rcvr.Listen (Callback => Test_Utils.GNU_Linux.Dump'Access);

      --  Precautionary delay to make sure receiver task is ready.

      delay 0.2;

      Sock.Send (Item  => Ref_Chunk);

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
   end Send_Packet_Raw;

end Socket_Tests.Packet;

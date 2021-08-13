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

with Anet.Sockets.Netlink;
with Anet.Receivers.Datagram;

with Test_Utils.GNU_Linux;

pragma Elaborate_All (Anet.Receivers.Datagram);

package body Socket_Tests.Netlink is

   use Ahven;
   use Anet;
   use type Ada.Streams.Stream_Element_Array;

   package Netlink_Receiver is new Receivers.Datagram
     (Buffer_Size  => 1024,
      Socket_Type  => Sockets.Netlink.Raw_Socket_Type,
      Address_Type => Sockets.Netlink.Netlink_Addr_Type,
      Receive      => Sockets.Netlink.Receive);

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Tests for Netlink sockets");
      T.Add_Test_Routine
        (Routine => Send_Netlink_Raw'Access,
         Name    => "Send data (raw)");
   end Initialize;

   -------------------------------------------------------------------------

   procedure Send_Netlink_Raw
   is
      use type Receivers.Count_Type;

      C    : Receivers.Count_Type := 0;
      Sock : aliased Sockets.Netlink.Raw_Socket_Type;
      Rcvr : Netlink_Receiver.Receiver_Type (S => Sock'Access);
      Pid  : constant Sockets.Netlink.Netlink_Addr_Type := 23499;
   begin
      if not Test_Utils.Has_Root_Perms then
         Skip (Message => "Run as root");
      end if;

      Sock.Init (Protocol => Sockets.Netlink.Proto_Netlink_Xfrm);
      Sock.Bind (Address => Pid);

      Rcvr.Listen (Callback => Test_Utils.GNU_Linux.Dump'Access);

      --  Precautionary delay to make sure receiver task is ready.

      delay 0.2;

      Sock.Send (Item => Ref_Chunk,
                 To   => Pid);

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
   end Send_Netlink_Raw;

end Socket_Tests.Netlink;

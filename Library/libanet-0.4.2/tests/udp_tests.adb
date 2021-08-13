--
--  Copyright (C) 2011, 2012 secunet Security Networks AG
--  Copyright (C) 2011, 2012 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2011, 2012 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Anet.UDP;

with Test_Utils;

package body UDP_Tests is

   use Ahven;
   use Anet;

   -------------------------------------------------------------------------

   procedure Create_UDP_Header
   is
      Ref_Payload : constant Ada.Streams.Stream_Element_Array
        := (16#FF#, 16#FF#);

      Ref_UDP_Hdr : constant Ada.Streams.Stream_Element_Array
        := (16#03#, 16#FF#, 16#84#, 16#D0#, 16#00#, 16#0A#, 16#E1#, 16#82#);
   begin
      declare
         use type Ada.Streams.Stream_Element_Array;

         UDP_Header : constant Ada.Streams.Stream_Element_Array
           := UDP.Create_Header
             (Payload  => Ref_Payload,
              Src_IP   => Anet.IPv4_Addr_Type'(192, 168, 234, 12),
              Dst_IP   => Anet.IPv4_Addr_Type'(192, 168,  42, 42),
              Src_Port => 1023,
              Dst_Port => 34000);
      begin
         Assert (Condition => Ref_UDP_Hdr = UDP_Header,
                 Message   => "UDP header incorrect");
      end;
   end Create_UDP_Header;

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Tests for UDP processing");
      T.Add_Test_Routine
        (Routine => Create_UDP_Header'Access,
         Name    => "Create UDP header");
      T.Add_Test_Routine
        (Routine => Validate_UDP_Checksum'Access,
         Name    => "Validate UDP checksum");
   end Initialize;

   -------------------------------------------------------------------------

   procedure Validate_UDP_Checksum
   is
      use Ada.Exceptions;
      use type Ada.Streams.Stream_Element_Offset;

      UDP_Hdr : constant Ada.Streams.Stream_Element_Array (1 .. 8)
        := (16#00#, 16#43#, 16#00#, 16#44#, 16#01#, 16#37#, 16#b9#, 16#7d#);
      Pkt     : Ada.Streams.Stream_Element_Array
        (1 .. 8 + Test_Utils.DHCP_Ack'Length);
      No_Chk  : Ada.Streams.Stream_Element_Array := UDP_Hdr;
   begin

      --  Checksum valid, this should not rise an exception.

      Pkt (1 .. 8)        := UDP_Hdr;
      Pkt (9 .. Pkt'Last) := Test_Utils.DHCP_Ack;
      UDP.Validate_Checksum (Packet => Pkt,
                             Src_IP => (192, 168, 239, 1),
                             Dst_IP => (192, 168, 239, 119));

      --  Checksum not set, this should not rise an exception.

      No_Chk (7 .. 8) := (others => 0);
      UDP.Validate_Checksum (Packet => No_Chk,
                             Src_IP => Anet.Any_Addr,
                             Dst_IP => Anet.Any_Addr);

      --  Invalidate checksum

      Pkt (7 .. 8) := (others => 16#ca#);

      begin
         UDP.Validate_Checksum (Packet => Pkt,
                                Src_IP => (192, 168, 239, 1),
                                Dst_IP => (192, 168, 239, 119));

      exception
         when E : UDP.Invalid_UDP_Packet =>
            Assert (Condition => Exception_Message (X => E)
                    = "UDP header checksum 51914 invalid, should be 47485",
                    Message   => "Exception mismatch");
      end;
   end Validate_UDP_Checksum;

end UDP_Tests;

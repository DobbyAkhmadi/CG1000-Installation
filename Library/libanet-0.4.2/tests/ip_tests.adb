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
with Anet.IPv4;
with Anet.OS;

with Test_Utils;

package body IP_Tests is

   use Ahven;
   use Anet;

   -------------------------------------------------------------------------

   procedure Create_IP_Header
   is
      Ref_Payload : constant Ada.Streams.Stream_Element_Array
        := (16#03#, 16#FF#, 16#84#, 16#D0#, 16#00#, 16#08#, 16#77#, 16#0F#);

      Ref_IP_Hdr  : constant Ada.Streams.Stream_Element_Array
        := (16#45#, 16#00#, 16#00#, 16#1C#, 16#00#, 16#00#, 16#00#, 16#00#,
            16#40#, 16#11#, 16#e5#, 16#49#, 16#c0#, 16#a8#, 16#ea#, 16#0c#,
            16#c0#, 16#a8#, 16#2a#, 16#2a#);
   begin
      declare
         use type Ada.Streams.Stream_Element_Array;

         IP_Header : constant Ada.Streams.Stream_Element_Array :=
           IPv4.Create_Header
             (Payload => Ref_Payload,
              Src_IP  => IPv4_Addr_Type'(192, 168, 234, 12),
              Dst_IP  => IPv4_Addr_Type'(192, 168,  42, 42));
      begin
         Assert (Condition => Ref_IP_Hdr = IP_Header,
                 Message   => "IP header incorrect");
      end;
   end Create_IP_Header;

   -------------------------------------------------------------------------

   procedure Create_IP_Packet
   is
      use type Ada.Streams.Stream_Element_Array;

      Ref_Packet : constant Ada.Streams.Stream_Element_Array
        := OS.Read_File (Filename => "data/ip-udp-dhcp-ack.dat");
      Payload    : constant Ada.Streams.Stream_Element_Array
        := OS.Read_File (Filename => "data/dhcp-ack1.dat");
   begin
      declare
         Packet : constant Ada.Streams.Stream_Element_Array :=
           IPv4.Create_Packet
             (Payload  => Payload,
              Src_IP   => (192, 168, 239, 1),
              Src_Port => 67,
              Dst_IP   => (192, 168, 239, 119),
              Dst_Port => 68);
      begin
         Assert (Condition => Ref_Packet = Packet,
                 Message   => "IP packet incorrect");
      end;
   end Create_IP_Packet;

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Tests for IP processing");
      T.Add_Test_Routine
        (Routine => Create_IP_Header'Access,
         Name    => "Create IP header");
      T.Add_Test_Routine
        (Routine => Create_IP_Packet'Access,
         Name    => "Create IP packet");
      T.Add_Test_Routine
        (Routine => Validate_IP_Packet'Access,
         Name    => "Validate IP packet");
   end Initialize;

   -------------------------------------------------------------------------

   procedure Validate_IP_Packet
   is
      use Ada.Exceptions;

      Valid_Packet : Ada.Streams.Stream_Element_Array (1 .. 331)
        := (
            --  IP header
            16#45#, 16#00#, 16#01#, 16#4b#, 16#78#, 16#14#, 16#00#, 16#00#,
            16#40#, 16#11#, 16#a1#, 16#c3#, 16#c0#, 16#a8#, 16#ef#, 16#01#,
            16#c0#, 16#a8#, 16#ef#, 16#77#,

            --  UDP header
            16#00#, 16#43#, 16#00#, 16#44#, 16#01#, 16#37#, 16#b9#, 16#7d#,

            --  Payload
            others => 0
           );

      Dummy : Ada.Streams.Stream_Element_Array (1 .. 1);
      pragma Unreferenced (Dummy);
   begin
      Valid_Packet (29 .. 331) := Test_Utils.DHCP_Ack;

      declare
         Stripped : constant Ada.Streams.Stream_Element_Array
           := IPv4.Validate_And_Strip (Packet => Valid_Packet);
      begin
         Assert (Condition => Stripped'Length = Valid_Packet'Length - 28,
                 Message   => "Stripping failed");
      end;

      declare
         Too_Short : constant Ada.Streams.Stream_Element_Array (1 .. 263)
           := (others => 0);
      begin
         Dummy := IPv4.Validate_And_Strip (Packet => Too_Short);
         Fail (Message => "Exception expected (too short)");

      exception
         when E : IPv4.Invalid_IP_Packet =>
            Assert (Condition => Exception_Message
                    (X => E) = "Invalid packet size: 263",
                    Message   => "Exception mismatch (too short)");
      end;

      declare
         Invalid_Version : Ada.Streams.Stream_Element_Array := Valid_Packet;
      begin
         Invalid_Version (1) := 16#55#;

         Dummy := IPv4.Validate_And_Strip (Packet => Invalid_Version);
         Fail (Message => "Exception expected (version)");

      exception
         when E : IPv4.Invalid_IP_Packet =>
            Assert (Condition => Exception_Message
                    (X => E) = "Invalid IP version: 5",
                    Message   => "Exception mismatch (version)");
      end;

      declare
         Invalid_IHL : Ada.Streams.Stream_Element_Array := Valid_Packet;
      begin
         Invalid_IHL (1) := 16#43#;

         Dummy := IPv4.Validate_And_Strip (Packet => Invalid_IHL);
         Fail (Message => "Exception expected (IHL)");

      exception
         when E : IPv4.Invalid_IP_Packet =>
            Assert (Condition => Exception_Message
                    (X => E) = "Invalid IHL: 3",
                    Message   => "Exception mismatch (IHL)");
      end;

      begin
         Dummy := IPv4.Validate_And_Strip (Packet => Valid_Packet (1 .. 264));
         Fail (Message => "Exception expected (total length)");

      exception
         when E : IPv4.Invalid_IP_Packet =>
            Assert (Condition => Exception_Message (X => E)
                    = "Invalid total length: 331 (packet is 264 bytes)",
                    Message   => "Exception mismatch (total length)");
      end;

      declare
         No_UDP : Ada.Streams.Stream_Element_Array := Valid_Packet;
      begin
         No_UDP (10) := 16#12#;

         Dummy := IPv4.Validate_And_Strip (Packet => No_UDP);
         Fail (Message => "Exception expected (UDP)");

      exception
         when E : IPv4.Invalid_IP_Packet =>
            Assert (Condition => Exception_Message
                    (X => E) = "Protocol is not UDP",
                    Message   => "Exception mismatch (UDP)");
      end;

      Invalid_IP_Checksum :
      declare
         Invalid_Checksum : Ada.Streams.Stream_Element_Array := Valid_Packet;
      begin
         Invalid_Checksum (11 .. 12) := (others => 11);

         Dummy := IPv4.Validate_And_Strip (Packet => Invalid_Checksum);
         Fail (Message => "Exception expected (IP checksum)");

      exception
         when E : IPv4.Invalid_IP_Packet =>
            Assert (Condition => Exception_Message (X => E)
                    = "IP header checksum 2827 invalid, should be 41411",
                    Message   => "Exception mismatch (IP checksum)");
      end Invalid_IP_Checksum;

      Invalid_UDP_Checksum :
      declare
         Invalid_Checksum : Ada.Streams.Stream_Element_Array := Valid_Packet;
      begin
         Invalid_Checksum (27 .. 28) := (others => 12);

         Dummy := IPv4.Validate_And_Strip (Packet => Invalid_Checksum);
         Fail (Message => "Exception expected (UDP checksum)");

      exception
         when E : UDP.Invalid_UDP_Packet =>
            Assert (Condition => Exception_Message (X => E)
                    = "UDP header checksum 3084 invalid, should be 47485",
                    Message   => "Exception mismatch (UDP checksum)");
      end Invalid_UDP_Checksum;
   end Validate_IP_Packet;

end IP_Tests;

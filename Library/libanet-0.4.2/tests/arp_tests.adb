--
--  Copyright (C) 2018 secunet Security Networks AG
--  Copyright (C) 2018 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2018 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Anet.ARP;

package body ARP_Tests is

   use Ahven;
   use Anet;

   -------------------------------------------------------------------------

   procedure Header_To_Stream
   is
      use type Ada.Streams.Stream_Element_Array;

      Ref_Hdr : constant Ada.Streams.Stream_Element_Array
        := (16#00#, 16#01#, 16#08#, 16#00#, 16#06#, 16#04#, 16#00#, 16#02#,
            16#01#, 16#32#, 16#2a#, 16#a5#, 16#12#, 16#59#, 16#C0#, 16#00#,
            16#d6#, 16#80#, 16#ff#, 16#ff#, 16#ff#, 16#ff#, 16#ff#, 16#ff#,
            16#C0#, 16#01#, 16#d6#, 16#7f#);
      ARP_Hdr : constant Ada.Streams.Stream_Element_Array
        := ARP.To_Stream
          (Header => (Operation => ARP.ARP_Reply,
                      Src_Ether => (16#01#, 16#32#, 16#2a#, 16#a5#, 16#12#,
                                    16#59#),
                      Src_IP    => (192, 0, 214, 128),
                      Dst_Ether => (others => 16#ff#),
                      Dst_IP    => (192, 1, 214, 127)));
   begin
      Assert (Condition => Ref_Hdr = ARP_Hdr,
              Message   => "ARP header incorrect");
   end Header_To_Stream;

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Tests for ARP processing");
      T.Add_Test_Routine
        (Routine => Header_To_Stream'Access,
         Name    => "Header to stream array");
      T.Add_Test_Routine
        (Routine => Stream_To_Header'Access,
         Name    => "Stream array to header");
   end Initialize;

   -------------------------------------------------------------------------

   procedure Stream_To_Header
   is
      use type Ada.Streams.Stream_Element_Offset;
      use type ARP.Header_Type;

      Input : constant Ada.Streams.Stream_Element_Array
        := (16#00#, 16#01#, 16#08#, 16#00#, 16#06#, 16#04#, 16#00#, 16#02#,
            16#01#, 16#32#, 16#2a#, 16#a5#, 16#12#, 16#59#, 16#C0#, 16#00#,
            16#d6#, 16#80#, 16#ff#, 16#ff#, 16#ff#, 16#ff#, 16#ff#, 16#ff#,
            16#C0#, 16#01#, 16#d6#, 16#7f#);
      Ref_Hdr : constant ARP.Header_Type
        := (Operation => ARP.ARP_Reply,
            Src_Ether => (16#01#, 16#32#, 16#2a#, 16#a5#, 16#12#,
                          16#59#),
            Src_IP    => (192, 0, 214, 128),
            Dst_Ether => (others => 16#ff#),
            Dst_IP    => (192, 1, 214, 127));
   begin
      Assert (Condition => ARP.To_Header (Buffer => Input) = Ref_Hdr,
              Message   => "Header mismatch");

      declare
         Dummy : ARP.Header_Type;
      begin
         Dummy := ARP.To_Header (Buffer => Input
                                 (Input'First .. Input'Last - 1));
         Fail (Message => "Exception expected (1)");

      exception
         when E : ARP.Invalid_ARP_Packet =>
            Assert (Condition => Ada.Exceptions.Exception_Message (X => E)
                    = "Unexpected ARP packet size: 27",
                    Message   => "Exception mismatch (1)");
      end;

      declare
         Input2 : Ada.Streams.Stream_Element_Array := Input;
         Dummy  : ARP.Header_Type;
      begin
         Input2 (Input2'First + 7) := 122;
         Dummy := ARP.To_Header (Buffer => Input2);
         Fail (Message => "Exception expected (1)");

      exception
         when E : ARP.Invalid_ARP_Packet =>
            Assert (Condition => Ada.Exceptions.Exception_Message (X => E)
                    = "Unknown ARP operation code: 122",
                    Message   => "Exception mismatch (1)");
      end;
   end Stream_To_Header;

end ARP_Tests;

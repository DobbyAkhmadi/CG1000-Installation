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

with Anet.Constants;
with Anet.Types;

package body Type_Tests is

   use Ahven;
   use Anet;

   -------------------------------------------------------------------------

   procedure Byte_Array_To_String
   is
      Data        : constant Byte_Array (5 .. 8) := (97, 98, 99, 65);
      Data_String : constant String              := "abcA";
      Single_Byte : constant Byte_Array (5 .. 5) := (5 => 64);
      Nul_Data    : constant Byte_Array (2 .. 5) := (97, 98, 0, 97);
      Nul_String  : constant String              := "ab";
   begin
      Assert (Condition => Data_String = To_String (Bytes => Data),
              Message   => "String mismatch");

      Assert (Condition => "@" = To_String (Bytes => Single_Byte),
              Message   => "Single byte mismatch");

      Assert (Condition => Nul_String = To_String (Bytes => Nul_Data),
              Message   => "Nul string mismatch");
   end Byte_Array_To_String;

   -------------------------------------------------------------------------

   procedure HW_Addr_To_String
   is
      Addr1 : constant Hardware_Addr_Type
        := (16#00#, 16#00#, 16#00#, 16#00#);
      Addr2 : constant Hardware_Addr_Type
        (HW_Addr_Len_Type'Range)
        :=  (others => 16#FF#);
      Addr3 : constant Hardware_Addr_Type
        := (16#DE#, 16#AD#, 16#BE#, 16#EF#, 16#CA#, 16#FE#);
   begin
      Assert (Condition => To_String (Address => Addr1) = "00:00:00:00",
              Message   => "Addr1 mismatch");
      Assert (Condition => To_String (Address => Addr2) =
                "FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF:FF",
              Message   => "Addr2 mismatch");
      Assert (Condition => To_String (Address => Addr3) =
                "DE:AD:BE:EF:CA:FE",
              Message   => "Addr3 mismatch");
   end HW_Addr_To_String;

   -------------------------------------------------------------------------

   procedure Initialize (T : in out Testcase)
   is
   begin
      T.Set_Name (Name => "Tests for basic Anet types");
      T.Add_Test_Routine
        (Routine => IPv4_Addr_To_String'Access,
         Name    => "IPv4 address to string conversion");
      T.Add_Test_Routine
        (Routine => IPv6_Addr_To_String'Access,
         Name    => "IPv6 address to string conversion");
      T.Add_Test_Routine
        (Routine => HW_Addr_To_String'Access,
         Name    => "HW address to string conversion");
      T.Add_Test_Routine
        (Routine => String_To_IPv4_Addr'Access,
         Name    => "String to IPv4 address conversion");
      T.Add_Test_Routine
        (Routine => String_To_Byte'Access,
         Name    => "String to byte conversion");
      T.Add_Test_Routine
        (Routine => String_To_IPv6_Addr'Access,
         Name    => "String to IPv6 address conversion");
      T.Add_Test_Routine
        (Routine => Byte_Array_To_String'Access,
         Name    => "Byte array to string conversion");
      T.Add_Test_Routine
        (Routine => String_To_Byte_Array'Access,
         Name    => "String to byte array conversion");
      T.Add_Test_Routine
        (Routine => Stream_To_Hex'Access,
         Name    => "Stream to hex string conversion");
      T.Add_Test_Routine
        (Routine => Valid_Iface_Names'Access,
         Name    => "Interface name validation");
   end Initialize;

   -------------------------------------------------------------------------

   procedure IPv4_Addr_To_String
   is
      Addr1 : constant IPv4_Addr_Type := (0, 0, 0, 0);
      Addr2 : constant IPv4_Addr_Type := (255, 255, 255, 255);
      Addr3 : constant IPv4_Addr_Type := (192, 168, 10, 1);
   begin
      Assert (Condition => To_String (Address => Addr1) = "0.0.0.0",
              Message   => "Addr1 mismatch");
      Assert (Condition => To_String (Address => Addr2) = "255.255.255.255",
              Message   => "Addr2 mismatch");
      Assert (Condition => To_String (Address => Addr3) = "192.168.10.1",
              Message   => "Addr3 mismatch");
   end IPv4_Addr_To_String;

   -------------------------------------------------------------------------

   procedure IPv6_Addr_To_String
   is
      Addr1 : constant IPv6_Addr_Type := (others => 0);
      Addr2 : constant IPv6_Addr_Type := (others => 255);
      Addr3 : constant IPv6_Addr_Type :=
        (255, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2);
   begin
      Assert (Condition => To_String (Address => Addr1) = "::",
              Message   => "Addr1 mismatch");
      Assert (Condition => To_String (Address => Addr2)
              = "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff",
              Message   => "Addr2 mismatch");
      Assert (Condition => To_String (Address => Addr3) = "ff02::1:2",
              Message   => "Addr3 mismatch");
   end IPv6_Addr_To_String;

   -------------------------------------------------------------------------

   procedure Stream_To_Hex
   is
      use Ada.Streams;

      A1 : constant Stream_Element_Array
        := (16#12#, 16#ca#, 16#8f#, 16#9c#, 16#05#);
      A2 : constant Stream_Element_Array (1 .. 0) := (others => <>);
   begin
      Assert (Condition => To_Hex (Data => A1) = "12CA8F9C05",
              Message   => "Hex string mismatch");
      Assert (Condition => To_Hex (Data => A2) = "",
              Message   => "Empty string expected");
   end Stream_To_Hex;

   -------------------------------------------------------------------------

   procedure String_To_Byte
   is
   begin
      Assert (Condition => To_Byte (Str => "00") = 0,
              Message   => "Conversion failed for '0'");
      Assert (Condition => To_Byte (Str => "0a") = 10,
              Message   => "Conversion failed for '0'");
      Assert (Condition => To_Byte (Str => "0f") = 15,
              Message   => "Conversion failed for '0f'");
      Assert (Condition => To_Byte (Str => "10") = 16,
              Message   => "Conversion failed for 'ff'");
      Assert (Condition => To_Byte (Str => "ff") = 255,
              Message   => "Conversion failed for 'ff'");
   end String_To_Byte;

   -------------------------------------------------------------------------

   procedure String_To_Byte_Array
   is
      D1     : constant Byte_Array (5 .. 8) := (97, 98, 99, 65);
      D1_Str : constant String              := "abcA";
      D2     : constant Byte_Array          := (97, 98, 99, 65);
      D2_Str : constant String (2 .. 5)     := "abcA";
      D3     : constant Byte_Array (1 .. 0) := (others => 0);
      D3_Str : constant String              := "";
   begin
      Assert (Condition => To_Bytes (Str => D1_Str) = D1,
              Message   => "Bytes mismatch1");
      Assert (Condition => To_Bytes (Str => D2_Str) = D2,
              Message   => "Bytes mismatch2");
      Assert (Condition => To_Bytes (Str => D3_Str) = D3,
              Message   => "Bytes mismatch3");
   end String_To_Byte_Array;

   -------------------------------------------------------------------------

   procedure String_To_IPv4_Addr
   is
   begin
      Assert (Condition => To_IPv4_Addr (Str => "0.0.0.0") = Any_Addr,
              Message   => "Any address mismatch");
      Assert (Condition => To_IPv4_Addr
              (Str => "255.255.255.255") = Bcast_Addr,
              Message   => "Broadcast address mismatch");

      Assert (Condition => To_IPv4_Addr
              (Str => "127.0.0.1") = (127, 0, 0, 1),
              Message   => "Localhost address mismatch");
      Assert (Condition => To_IPv4_Addr
              (Str => "192.168.0.42") = (192, 168, 0, 42),
              Message   => "IPv4 address mismatch");

      declare
         IP_Str : constant String (2 .. 13) := "192.168.0.42";
      begin
         Assert (Condition => To_IPv4_Addr (Str => IP_Str) = (192, 168, 0, 42),
                 Message   => "IP address mismatch (str)");
      end;

      declare
         IP : IPv4_Addr_Type;
         pragma Unreferenced (IP);
      begin
         IP := To_IPv4_Addr (Str => "");

      exception
         when Constraint_Error => null;
      end;

      declare
         IP : IPv4_Addr_Type;
         pragma Unreferenced (IP);
      begin
         IP := To_IPv4_Addr (Str => "192.168.300.0");

      exception
         when Constraint_Error => null;
      end;

      declare
         IP : IPv4_Addr_Type;
         pragma Unreferenced (IP);
      begin
         IP := To_IPv4_Addr (Str => "192.168.0");

      exception
         when Constraint_Error => null;
      end;
   end String_To_IPv4_Addr;

   -------------------------------------------------------------------------

   procedure String_To_IPv6_Addr
   is
   begin
      Assert (Condition => To_IPv6_Addr
              (Str => "0000:0000:0000:0000:0000:0000:0000:0000")
              = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
              Message   => "Zero address mismatch");
      Assert (Condition => To_IPv6_Addr
              (Str => "ffff:ffff:ffff:ffff:ffff:ffff:ffff:ffff")
              = IPv6_Addr_Type'(others => 255),
              Message   => "ff.. address mismatch");
      Assert (Condition => To_IPv6_Addr
              (Str => "ff02:0000:0000:0000:0000:0000:0001:0002")
              = (255, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2),
              Message   => "All_DHCP_Relay address mismatch");
      Assert (Condition => To_IPv6_Addr
              (Str => "ff02::0001:0002")
              = (255, 2, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 2),
              Message   => "Shortform address mismatch (1)");
      Assert (Condition => To_IPv6_Addr
              (Str => "::1")
              = (0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1),
              Message   => "Shortform address mismatch (2)");

      declare
         IP : IPv6_Addr_Type;
         pragma Unreferenced (IP);
      begin
         IP := To_IPv6_Addr (Str => "");

      exception
         when Constraint_Error => null;
      end;

      declare
         IP : IPv6_Addr_Type;
         pragma Unreferenced (IP);
      begin
         IP := To_IPv6_Addr (Str => "ff02:0000:0000:0002");

      exception
         when Constraint_Error => null;
      end;

      declare
         IP : IPv6_Addr_Type;
         pragma Unreferenced (IP);
      begin
         IP := To_IPv6_Addr (Str => "ff02:0000:0000:zx81:0000:0000:0001:0002");

      exception
         when Constraint_Error => null;
      end;
   end String_To_IPv6_Addr;

   -------------------------------------------------------------------------

   procedure Valid_Iface_Names
   is
      Too_Long : constant String :=
        (1 .. Constants.IFNAMSIZ + 1 => 'a');
   begin
      Assert (Condition => Types.Is_Valid_Iface (Name => "lo"),
              Message   => "Invalid interface name 'lo'");
      Assert (Condition => not Types.Is_Valid_Iface (Name => ""),
              Message   => "Valid empty interface name");
      Assert (Condition => not Types.Is_Valid_Iface (Name => Too_Long),
              Message   => "Valid interface name '" & Too_Long & "'");
   end Valid_Iface_Names;

end Type_Tests;

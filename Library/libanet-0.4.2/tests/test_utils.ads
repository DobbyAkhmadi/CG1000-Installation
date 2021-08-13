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

with Ada.Streams;

with Anet.Sockets.Inet;
with Anet.Sockets.Unix;

package Test_Utils is

   type OS_Type is (Linux, BSD);

   OS : OS_Type := Linux;

   Has_Root_Perms : Boolean := False;

   DHCP_Ack : constant Ada.Streams.Stream_Element_Array
     := (16#02#, 16#13#, 16#06#, 16#0c#, 16#9e#, 16#eb#, 16#b7#, 16#66#,
         16#ca#, 16#fe#, 16#80#, 16#00#, 16#0a#, 16#38#, 16#15#, 16#f2#,
         16#c0#, 16#a8#, 16#ef#, 16#77#, 16#c0#, 16#a8#, 16#ef#, 16#01#,
         16#ac#, 16#18#, 16#6b#, 16#0c#, 16#00#, 16#22#, 16#fb#, 16#52#,
         16#8b#, 16#f8#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#74#, 16#65#, 16#73#, 16#74#,
         16#73#, 16#65#, 16#72#, 16#76#, 16#65#, 16#72#, 16#2e#, 16#65#,
         16#78#, 16#61#, 16#6d#, 16#70#, 16#6c#, 16#65#, 16#2e#, 16#63#,
         16#68#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#70#, 16#78#, 16#65#, 16#6c#,
         16#69#, 16#6e#, 16#75#, 16#78#, 16#2e#, 16#30#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#, 16#00#,
         16#00#, 16#00#, 16#00#, 16#00#, 16#63#, 16#82#, 16#53#, 16#63#,
         16#35#, 16#01#, 16#05#, 16#36#, 16#04#, 16#c0#, 16#a8#, 16#ef#,
         16#01#, 16#33#, 16#04#, 16#00#, 16#01#, 16#51#, 16#80#, 16#3a#,
         16#04#, 16#00#, 16#00#, 16#a8#, 16#c0#, 16#3b#, 16#04#, 16#00#,
         16#01#, 16#27#, 16#50#, 16#01#, 16#04#, 16#ff#, 16#ff#, 16#ff#,
         16#00#, 16#03#, 16#04#, 16#c0#, 16#a8#, 16#ef#, 16#01#, 16#06#,
         16#08#, 16#50#, 16#fe#, 16#a1#, 16#7e#, 16#50#, 16#fe#, 16#a1#,
         16#7d#, 16#0f#, 16#0b#, 16#73#, 16#77#, 16#69#, 16#73#, 16#73#,
         16#2d#, 16#69#, 16#74#, 16#2e#, 16#63#, 16#68#, 16#ff#);
   --  Hex stream of reference DHCP Ack bootp message.

   function Equal_Files
     (Filename1 : String;
      Filename2 : String)
      return Boolean;
   --  Compare two files byte-wise. Returns True if both files are equal.
   --  The two files are closed but not removed after comparison. Raises
   --  Open_File_Error exception if one of the given files cannot be opened.

   procedure Dump
     (Data : Ada.Streams.Stream_Element_Array;
      Src  : Anet.Sockets.Inet.IPv4_Sockaddr_Type);
   --  This procedure dumps the given data to an internal buffer. Use the
   --  Get_Dump function to retrieve the content of the buffer.

   procedure Dump
     (Data : Ada.Streams.Stream_Element_Array;
      Src  : Anet.Sockets.Inet.IPv6_Sockaddr_Type);
   --  This procedure dumps the given data to an internal buffer. Use the
   --  Get_Dump function to retrieve the content of the buffer.

   procedure Dump
     (Data : Ada.Streams.Stream_Element_Array;
      Src  : Anet.Sockets.Unix.Full_Path_Type);
   --  This procedure dumps the given data to an internal buffer. Use the
   --  Get_Dump function to retrieve the content of the buffer.

   function Get_Dump return Ada.Streams.Stream_Element_Array;
   --  Return last dumped buffer. The internal buffer is cleared after a call
   --  to this function.

   function Get_Last_Address return Anet.Sockets.Inet.IPv4_Sockaddr_Type;
   --  Return last IPv4 address used in call to Dump procedure.

   function Get_Last_Address return Anet.Sockets.Inet.IPv6_Sockaddr_Type;
   --  Return last IPv6 address used in call to Dump procedure.

   function Get_Last_Address return Anet.Sockets.Unix.Full_Path_Type;
   --  Return last Unix path used in call to Dump procedure.

   generic
      type Address_Type is private;
   procedure Echo
     (Src       :     Address_Type;
      Recv_Data :     Ada.Streams.Stream_Element_Array;
      Send_Data : out Ada.Streams.Stream_Element_Array;
      Send_Last : out Ada.Streams.Stream_Element_Offset);
   --  Echo the received data back to the sender.

   procedure Raise_Error
     (Data : Ada.Streams.Stream_Element_Array;
      Src  : Anet.Sockets.Inet.IPv4_Sockaddr_Type);
   --  This procedure raises a constraint error. It is used to verify error
   --  handling of the receiver type.

   subtype Test_Port_Type is Anet.Port_Type range 30000 .. 40000;
   --  Ports used in unit tests.

   function Get_Random_Port return Test_Port_Type;
   --  Get random test port number.

   Open_File_Error : exception;

private

   Buffer         : Ada.Streams.Stream_Element_Array (1 .. 1500);
   Last           : Ada.Streams.Stream_Element_Offset;
   Last_Addr_v4   : Anet.Sockets.Inet.IPv4_Sockaddr_Type;
   Last_Addr_v6   : Anet.Sockets.Inet.IPv6_Sockaddr_Type;
   Last_Addr_Unix : Anet.Sockets.Unix.Full_Path_Type;

end Test_Utils;

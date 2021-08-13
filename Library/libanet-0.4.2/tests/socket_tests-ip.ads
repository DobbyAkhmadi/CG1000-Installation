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

with Ahven.Framework;

package Socket_Tests.IP is

   type Testcase is new Ahven.Framework.Test_Case with null record;

   procedure Initialize (T : in out Testcase);
   --  Initialize testcase.

   procedure Send_V4_Stream;
   --  Test sending over IPv4 stream socket.

   procedure Send_V4_Datagram;
   --  Test sending over IPv4 datagram socket.

   procedure Send_V6_Stream;
   --  Test sending over IPv6 stream socket.

   procedure Send_V6_Datagram;
   --  Test sending over IPv6 datagram socket.

   procedure Send_Multicast_V4;
   --  Test sending over IPv4 multicast.

   procedure Send_Multicast_V6;
   --  Test sending over IPv6 multicast.

   procedure Listen_Callbacks;
   --  Test data reception callback handling.

   procedure Error_Callbacks;
   --  Test error callback handling.

   procedure Non_Blocking;
   --  Test non-blocking mode of operation.

   procedure Shutdown_Socket;
   --  Test communication after socket shutdown.

   procedure Accept_Source_V4;
   --  Test source info handling of V4 Accept_Connection procedure.

   procedure Accept_Source_V6;
   --  Test source info handling of V6 Accept_Connection procedure.

   procedure Receive_Source_V4;
   --  Test source info handling of V4 Receive procedure.

   procedure Receive_Source_V6;
   --  Test source info handling of V6 Receive procedure.

end Socket_Tests.IP;

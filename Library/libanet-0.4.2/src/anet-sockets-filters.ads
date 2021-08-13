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

package Anet.Sockets.Filters is

   type Sock_Filter_Type is record
      Code : Interfaces.Unsigned_16;
      --  Actual filter code.
      JT   : Interfaces.Unsigned_8;
      --  Jump true.
      JF   : Interfaces.Unsigned_8;
      --  Jump false.
      K    : Interfaces.Unsigned_32;
      --  Generic multiuse field.
   end record;
   pragma Convention (C, Sock_Filter_Type);
   --  Linux Packet Filter (LPF) block (struct sock_filter).

   type Sock_Filter_Array is array (Positive range <>) of Sock_Filter_Type;
   --  Sock filter array.

   procedure Set_Filter
     (Socket : Socket_Type;
      Filter : Sock_Filter_Array);
   --  Apply filter on given socket.

   -------------
   -- Filters --
   -------------

   Filter_Discard_All : constant Sock_Filter_Array;
   --  Filter: discard all packets.

   Filter_UDP_Port_Bootpc : constant Sock_Filter_Array;
   --  Filter: udp and dst port 68.

   Filter_UDP_Port_Bootps : constant Sock_Filter_Array;
   --  Filter: udp and dst port 67.

private

   Filter_Discard_All : constant Sock_Filter_Array (1 .. 1)
     := (1 => (16#06#, 0, 0, 16#00000000#));
   --  Compiled LPF filter, discard all packets.

   Filter_UDP_Port_Bootpc : constant Sock_Filter_Array (1 .. 9)
     := ((16#30#, 0, 0, 16#00000009#),
         (16#15#, 0, 6, 16#00000011#),
         (16#28#, 0, 0, 16#00000006#),
         (16#45#, 4, 0, 16#00001fff#),
         (16#b1#, 0, 0, 16#00000000#),
         (16#48#, 0, 0, 16#00000002#),
         (16#15#, 0, 1, 16#00000044#),
         (16#06#, 0, 0, 16#ffffffff#),
         (16#06#, 0, 0, 16#00000000#));
   --  Compiled LPF filter shamelessly stolen from busybox dhcpc.

   Filter_UDP_Port_Bootps : constant Sock_Filter_Array (1 .. 9)
     := ((16#30#, 0, 0, 16#00000009#),
         (16#15#, 0, 6, 16#00000011#),
         (16#28#, 0, 0, 16#00000006#),
         (16#45#, 4, 0, 16#00001fff#),
         (16#b1#, 0, 0, 16#00000000#),
         (16#48#, 0, 0, 16#00000002#),
         (16#15#, 0, 1, 16#00000043#),
         (16#06#, 0, 0, 16#ffffffff#),
         (16#06#, 0, 0, 16#00000000#));

end Anet.Sockets.Filters;

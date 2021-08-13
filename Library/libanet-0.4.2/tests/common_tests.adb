--
--  Copyright (C) 2014 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2014 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Ada.Text_IO;

with Ahven.Text_Runner;

with Type_Tests;
with OS_Tests;
with Util_Tests;
with Socket_Tests.IP;
with Socket_Tests.Unix;
with ARP_Tests;
with UDP_Tests;
with IP_Tests;
with Stream_Tests;
with Net_Ifaces_Tests;

with Test_Utils;

package body Common_Tests is

   use Ahven.Framework;

   -------------------------------------------------------------------------

   procedure Add (Suite : Test_Suite_Access)
   is
   begin
      Add_Test (Suite => Suite.all,
                T     => new Type_Tests.Testcase);
      Add_Test (Suite => Suite.all,
                T     => new OS_Tests.Testcase);
      Add_Test (Suite => Suite.all,
                T     => new Util_Tests.Testcase);
      Add_Test (Suite => Suite.all,
                T     => new Socket_Tests.IP.Testcase);
      Add_Test (Suite => Suite.all,
                T     => new Socket_Tests.Unix.Testcase);
      Add_Test (Suite => Suite.all,
                T     => new ARP_Tests.Testcase);
      Add_Test (Suite => Suite.all,
                T     => new UDP_Tests.Testcase);
      Add_Test (Suite => Suite.all,
                T     => new IP_Tests.Testcase);
      Add_Test (Suite => Suite.all,
                T     => new Stream_Tests.Testcase);
      Add_Test (Suite => Suite.all,
                T     => new Net_Ifaces_Tests.Testcase);
   end Add;

   -------------------------------------------------------------------------

   procedure Run (Suite : Ahven.Framework.Test_Suite_Access)
   is
      function C_Getuid return Integer;
      pragma Import (C, C_Getuid, "getuid");
   begin
      if C_Getuid = 0 then
         Test_Utils.Has_Root_Perms := True;
      end if;

      Ada.Text_IO.Put_Line
        ("Running " & Suite.all.Get_Name & " (" & Test_Utils.OS'Img
         & ") ... please wait");

      Ahven.Text_Runner.Run (Suite => Suite);
      Release_Suite (T => Suite);
   end Run;

end Common_Tests;

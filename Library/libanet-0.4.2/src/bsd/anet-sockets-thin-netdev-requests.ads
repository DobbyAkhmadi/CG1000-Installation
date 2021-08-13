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

package Anet.Sockets.Thin.Netdev.Requests is

   SIOCGIFADDR   : constant := 16#c0206921#; --  Get address
   SIOCGIFFLAGS  : constant := 16#c0206911#; --  Get flags
   SIOCSIFFLAGS  : constant := 16#80206910#; --  Set flags
   SIOCGIFHWADDR : constant := 16#ffffffff#; --  Get hardware address
   SIOCGIFINDEX  : constant := 16#c0206920#; --  Name -> if_index mapping

   Get_Requests : constant array (Netdev_Request_Name) of
     Interfaces.C.unsigned_long
       := (If_Addr   => SIOCGIFADDR,
           If_Flags  => SIOCGIFFLAGS,
           If_Hwaddr => SIOCGIFHWADDR,
           If_Index  => SIOCGIFINDEX);
   --  Currently supported netdevice ioctl get requests.

   Set_Requests : constant array (Netdev_Request_Name) of
     Interfaces.C.unsigned_long
       := (If_Flags => SIOCSIFFLAGS,
           others   => Interfaces.C.unsigned_long (16#ffffffff#));
   --  Currently supported netdevice ioctl set requests.

   function C_Ioctl
     (S   : Interfaces.C.int;
      Req : Interfaces.C.unsigned_long;
      Arg : access If_Req_Type)
      return Interfaces.C.int;
   pragma Import (C, C_Ioctl, "ioctl");

end Anet.Sockets.Thin.Netdev.Requests;

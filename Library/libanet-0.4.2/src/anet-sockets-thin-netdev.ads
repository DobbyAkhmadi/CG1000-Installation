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

with Anet.Sockets.Thin.Sockaddr;

package Anet.Sockets.Thin.Netdev is

   type Netdev_Request_Name is
     (If_Addr,
      If_Flags,
      If_Hwaddr,
      If_Index);
   --  Supported netdevice requests.

   type If_Req_Type (Name : Netdev_Request_Name := If_Index) is record
      Ifr_Name : Interfaces.C.char_array
        (1 .. Constants.IFNAMSIZ) := (others => Interfaces.C.nul);

      case Name is
         when If_Addr   =>
            Ifr_Addr    : Sockaddr.Sockaddr_Type;
         when If_Hwaddr =>
            Ifr_Hwaddr  : Sockaddr.Sockaddr_Type;
         when If_Index  =>
            Ifr_Ifindex : Interfaces.C.int   := 0;
         when If_Flags  =>
            Ifr_Flags   : Interfaces.C.short := 0;
      end case;
   end record;
   pragma Unchecked_Union (If_Req_Type);
   pragma Convention (C, If_Req_Type);
   --  Interface request structure (struct ifreq).

end Anet.Sockets.Thin.Netdev;

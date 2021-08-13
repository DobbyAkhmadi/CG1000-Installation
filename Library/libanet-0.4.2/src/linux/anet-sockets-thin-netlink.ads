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

with Anet.OS_Constants;

package Anet.Sockets.Thin.Netlink is

   type Sockaddr_Nl_Type is record
      Nl_Family : Interfaces.C.unsigned_short := OS_Constants.AF_NETLINK;
      --  Address family (always AF_NETLINK)
      Nl_Pad    : Interfaces.C.unsigned_short := 0;
      --  Zero
      Nl_Pid    : Interfaces.Unsigned_32      := 0;
      --  Port PID
      Nl_Groups : Interfaces.Unsigned_32      := 0;
      --  Multicast groups mask
   end record;
   pragma Convention (C, Sockaddr_Nl_Type);
   --  Netlink address

end Anet.Sockets.Thin.Netlink;

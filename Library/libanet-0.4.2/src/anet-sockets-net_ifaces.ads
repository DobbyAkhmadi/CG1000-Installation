--
--  Copyright (C) 2012 secunet Security Networks AG
--  Copyright (C) 2012 Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2012 Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with Anet.Types;

package Anet.Sockets.Net_Ifaces is

   function Get_Iface_Index (Name : Types.Iface_Name_Type) return Positive;
   --  Get interface index of interface given by name.

   function Get_Iface_Mac
     (Name : Types.Iface_Name_Type)
      return Hardware_Addr_Type;
   --  Get hardware address of interface given by name.

   function Get_Iface_IP
     (Name : Types.Iface_Name_Type)
      return IPv4_Addr_Type;
   --  Get IP address of interface given by name. If given interface has no
   --  assigned IP an exception is raised.

   function Is_Iface_Up (Name : Types.Iface_Name_Type) return Boolean;
   --  Check if interface given by name is up. True is returned if the
   --  interface is up.

   procedure Set_Iface_State
     (Name  : Types.Iface_Name_Type;
      State : Boolean);
   --  Set state of interface given by name. If state is True the interface is
   --  brought up.

end Anet.Sockets.Net_Ifaces;

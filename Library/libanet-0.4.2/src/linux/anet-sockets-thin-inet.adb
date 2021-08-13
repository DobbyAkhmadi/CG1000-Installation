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

with Anet.Byte_Swapping;
with Anet.Socket_Families;

package body Anet.Sockets.Thin.Inet is

   -------------------------------------------------------------------------

   function Create_Inet4
     (Address : IPv4_Addr_Type;
      Port    : Port_Type)
      return Thin.Inet.Sockaddr_In_Type
   is
   begin
      return (Family     => Socket_Families.Family_Inet,
              Sin_Family => Constants.Sys.AF_INET,
              Sin_Port   => Interfaces.C.unsigned_short
                (Byte_Swapping.Host_To_Network (Input => Port)),
              Sin_Addr   => Address,
              Sin_Zero   => <>);
   end Create_Inet4;

   -------------------------------------------------------------------------

   function Create_Inet6
     (Address : IPv6_Addr_Type;
      Port    : Port_Type)
      return Thin.Inet.Sockaddr_In_Type
   is
   begin
      return (Family     => Socket_Families.Family_Inet6,
              Sin_Family => Constants.Sys.AF_INET6,
              Sin_Port   => Interfaces.C.unsigned_short
                (Byte_Swapping.Host_To_Network (Input => Port)),
              Sin6_Addr  => Address,
              others     => 0);
   end Create_Inet6;

end Anet.Sockets.Thin.Inet;

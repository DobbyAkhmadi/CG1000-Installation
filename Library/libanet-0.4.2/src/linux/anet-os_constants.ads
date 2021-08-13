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

package Anet.OS_Constants is

   AF_NETLINK          : constant := 16;   --  Netlink family
   AF_PACKET           : constant := 17;   --  Packet family

   IPV6_MULTICAST_IF   : constant := 17;   --  Sending interface
   IPV6_ADD_MEMBERSHIP : constant := 20;   --  Join multicast group (IPv6)
   IPV6_V6ONLY         : constant := 26;   --  Set IPv6 socket to V6 only

   NETLINK_ROUTE       : constant := 0;    --  Routing/device hook
   NETLINK_FIREWALL    : constant := 3;    --  Firewalling hook
   NETLINK_INET_DIAG   : constant := 4;    --  INET socket monitoring
   NETLINK_NFLOG       : constant := 5;    --  netfilter/iptables ULOG
   NETLINK_XFRM        : constant := 6;    --  ipsec
   NETLINK_SELINUX     : constant := 7;    --  SELinux event notifications
   NETLINK_AUDIT       : constant := 9;    --  auditing;
   NETLINK_NETFILTER   : constant := 12;   --  netfilter subsystem
   NETLINK_CRYPTO      : constant := 21;   --  Crypto layer

   O_NONBLOCK          : constant := 4000; --  Non-blocking sockets

end Anet.OS_Constants;

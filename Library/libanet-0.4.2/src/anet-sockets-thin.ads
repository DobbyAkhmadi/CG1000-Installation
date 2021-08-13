--
--  Copyright (C) 2011, 2012 secunet Security Networks AG
--  Copyright (C) 2011-2016  Reto Buerki <reet@codelabs.ch>
--  Copyright (C) 2011-2016  Adrian-Ken Rueegsegger <ken@codelabs.ch>
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

with System;

package Anet.Sockets.Thin is

   type IPv4_Mreq_Type is record
      Imr_Multiaddr : IPv4_Addr_Type;
      Imr_Interface : IPv4_Addr_Type;
   end record;
   pragma Convention (C, IPv4_Mreq_Type);
   --  struct ip_mreq (netinet/in.h).

   type IPv6_Mreq_Type is record
      IPv6mr_Multiaddr : IPv6_Addr_Type;
      IPv6mr_Interface : Interfaces.C.unsigned;
   end record;
   pragma Convention (C, IPv6_Mreq_Type);
   --  struct ipv6_mreq (netinet/in.h).

   -------------
   -- Imports --
   -------------

   function C_Socket
     (Domain   : Interfaces.C.int;
      Typ      : Interfaces.C.int;
      Protocol : Interfaces.C.int)
      return Interfaces.C.int;
   pragma Import (C, C_Socket, "socket");

   function C_Bind
     (S       : Interfaces.C.int;
      Name    : System.Address;
      Namelen : Interfaces.C.unsigned_long)
      return Interfaces.C.int;
   pragma Import (C, C_Bind, "bind");

   function C_Connect
     (S       : Interfaces.C.int;
      Name    : System.Address;
      Namelen : Interfaces.C.unsigned_long)
      return Interfaces.C.int;
   pragma Import (C, C_Connect, "connect");

   function C_Recv
     (S     : Interfaces.C.int;
      Msg   : System.Address;
      Len   : Interfaces.C.size_t;
      Flags : Interfaces.C.int)
      return Interfaces.C.long;
   pragma Import (C, C_Recv, "recv");

   function C_Recvfrom
     (S       : Interfaces.C.int;
      Msg     : System.Address;
      Len     : Interfaces.C.size_t;
      Flags   : Interfaces.C.int;
      From    : System.Address;
      Fromlen : not null access Interfaces.C.int)
      return Interfaces.C.long;
   pragma Import (C, C_Recvfrom, "recvfrom");

   function C_Send
     (S     : Interfaces.C.int;
      Buf   : System.Address;
      Len   : Interfaces.C.size_t;
      Flags : Interfaces.C.int)
      return Interfaces.C.long;
   pragma Import (C, C_Send, "send");

   function C_Sendto
     (S     : Interfaces.C.int;
      Buf   : System.Address;
      Len   : Interfaces.C.size_t;
      Flags : Interfaces.C.int;
      To    : System.Address;
      Tolen : Interfaces.C.unsigned_long)
      return Interfaces.C.long;
   pragma Import (C, C_Sendto, "sendto");

   function C_Setsockopt
     (S       : Interfaces.C.int;
      Level   : Interfaces.C.int;
      Optname : Interfaces.C.int;
      Optval  : System.Address;
      Optlen  : Interfaces.C.unsigned_long)
      return Interfaces.C.int;
   pragma Import (C, C_Setsockopt, "setsockopt");

   function C_Accept
     (S       : Interfaces.C.int;
      Name    : System.Address;
      Namelen : not null access Interfaces.C.int)
      return Interfaces.C.int;
   pragma Import (C, C_Accept, "accept");

   function C_Listen
     (Socket  : Interfaces.C.int;
      Backlog : Interfaces.C.int)
      return Interfaces.C.int;
   pragma Import (C, C_Listen, "listen");

   function C_Close (Fd : Interfaces.C.int) return Interfaces.C.int;
   pragma Import (C, C_Close, "close");

   function C_Fcntl
     (Fd  : Interfaces.C.int;
      Cmd : Interfaces.C.int;
      Arg : Interfaces.C.int)
      return Interfaces.C.int;
   pragma Import (C, C_Fcntl, "fcntl");

   function C_Shutdown
     (S   : Interfaces.C.int;
      How : Interfaces.C.int)
      return Interfaces.C.int;
   pragma Import (C, C_Shutdown, "shutdown");

end Anet.Sockets.Thin;

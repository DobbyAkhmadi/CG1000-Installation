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

package Anet.Sockets.Netlink is

   subtype Netlink_Addr_Type is Natural;
   --  Netlink address.

   type Protocol_Type is
     (Proto_Netlink_Route,
      Proto_Netlink_Firewall,
      Proto_Netlink_Inet_Diag,
      Proto_Netlink_Nflog,
      Proto_Netlink_Xfrm,
      Proto_Netlink_Selinux,
      Proto_Netlink_Audit,
      Proto_Netlink_Netfilter,
      Proto_Netlink_Crypto);
   --  Netlink protocols.

   type Group_Type is
     (Group_Xfrm_None,
      Group_Xfrm_Acquire,
      Group_Xfrm_Expire,
      Group_Xfrm_Sa,
      Group_Xfrm_Policy,
      Group_Xfrm_Aevents,
      Group_Xfrm_Report,
      Group_Xfrm_Migrate,
      Group_Xfrm_Mapping);
   --  Supported Netlink multicast groups.

   type Group_Array is array (Positive range <>) of Group_Type;
   --  Array of Netlink multicast groups.

   No_Groups : constant Group_Array;

   type Netlink_Socket_Type is abstract new Socket_Type with private;
   --  Netlink socket.

   procedure Bind
     (Socket  : in out Netlink_Socket_Type;
      Address :        Netlink_Addr_Type;
      Groups  :        Group_Array := No_Groups);
   --  Bind given Netlink socket to the specified Netlink address (which is
   --  normally the pid of the application) and optional Netlink multicast
   --  groups (requires root permissions).

   procedure Send
     (Socket : Netlink_Socket_Type;
      Item   : Ada.Streams.Stream_Element_Array;
      To     : Netlink_Addr_Type);
   --  Send data over a Netlink socket to the given Netlink address.

   procedure Receive
     (Socket :     Netlink_Socket_Type;
      Src    : out Netlink_Addr_Type;
      Item   : out Ada.Streams.Stream_Element_Array;
      Last   : out Ada.Streams.Stream_Element_Offset);
   --  Receive data from given Netlink socket. Last is the index value which
   --  designates the last stream element in data. The source Netlink address
   --  specifies the sender of the Netlink message.

   type Raw_Socket_Type is new Netlink_Socket_Type
     and Dgram_Socket_Type with private;
   --  Raw/Netlink socket. It extends the datagram socket type because (1)
   --  Netlink is a datagram-oriented service and (2) because it also behaves
   --  like a datagram socket from an interface perspective. This allows to use
   --  the Raw/Netlink socket with a datagram receiver instance.

   procedure Init
     (Socket   : in out Raw_Socket_Type;
      Protocol :        Protocol_Type);
   --  Initialize Raw/Netlink socket using the specified protocol.

private

   No_Groups : constant Group_Array (1 .. 1) := (1 => Group_Xfrm_None);

   type Netlink_Socket_Type is abstract new Socket_Type with null record;

   type Raw_Socket_Type is new Netlink_Socket_Type
     and Dgram_Socket_Type with null record;

end Anet.Sockets.Netlink;

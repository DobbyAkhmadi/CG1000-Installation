# CG1000-Installation

Program CG1000 Installation

# Software And Library Test
 - Operating System Debian 10 https://www.debian.org/
 - MYSQL Mariadb 10 https://mariadb.org/
 - Ada GNAT Networking Version 0.4.2
 - Ada GNAT Utility Version 2.4.
 - Ada GNAT Ado Database Version 2.2.0
 - OPCUA Protocol Version 1.2.2
 - IEC 61850 Version 1.5.0
====================================================================
                        REQUIRED INSTALLING
====================================================================

1. Edit Files
nano /etc/sudoers
2. Tambahkan baris berikut ini (setelah baris root ALL=(ALL) ALL):
scada ALL=(ALL) ALL

On GNAT installer input password sudo 'scada'

====================================================================
                        AFTER INSTALLING
====================================================================

Check Webserver CG1000 192.168.1.1:12381
# CG1000-Installation

Program CG1000 Installation

# Software And Library Test
 - Operating System Debian 9 https://www.debian.org/
 - MYSQL Mariadb 10 https://mariadb.org/
 - Ada GNAT Networking Version 0.4.2
 - Ada GNAT Utility Version 2.4.
 - Ada GNAT Ado Database Version 2.0
 - OPCUA Protocol Version 1.2.2
 - IEC 61850 Version 1.5.0
 - Modbus TCP Version 3.08
 - PHP 7.3
====================================================================
                        REQUIRED INSTALLING
====================================================================

1. Install Program
change to directory installation and type ./install.sh on terminal

====================================================================
                        AFTER INSTALLING
====================================================================
check service main CG               = systemctl status ProgramCG1000
check service rendundancy CG        = systemctl status RendundancyCG1000
check service webserver CG          = systemctl status WebCG1000

you can Check Webserver CG1000 on IP: 192.168.1.1:12381


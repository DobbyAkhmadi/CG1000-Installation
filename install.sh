#!/bin/bash

red=`tput setaf 1`

green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`

SoftwareVersion="${red}SiLVue CG1000 Len Version 0.1 Beta Install"

echo "${SoftwareVersion} | ${green}==>Checking APT Packages Online .. ${reset}"

sudo apt update

echo "${SoftwareVersion} | ${green}==>Upgrade APT Packages .. ${reset}"

sudo apt-get update && apt-get upgrade

echo "${SoftwareVersion} | ${green}==>Install Required System Dependency Packages .. ${reset}"

echo "${SoftwareVersion} | ${green}==>Installing Cmake Packages .. ${reset}"

sudo apt-get --assume-yes install  cmake

echo "${SoftwareVersion} | ${green}==>Installing Networking Tools Packages .. ${reset}"

sudo apt --assume-yes install net-tools

sudo apt-get --assume-yes install libmbedtls-dev
sudo apt-get --assume-yes install liburcu-dev
sudo apt-get --assume-yes install check
sudo apt-get --assume-yes install keepalived
sudo apt-get --assume-yes install curl
sudo apt-get --assume-yes install aria2

echo "${SoftwareVersion} | ${green}==>Instaling Apache2 WebServer Packages .. ${reset}"

sudo apt-get --assume-yes install apache2

echo "${SoftwareVersion} | ${green}==>Installing PHP Library Version 7.3 .. ${reset}"

sudo apt-get --assume-yes install php7.3

sudo apt install --assume-yes wget php7.3 php7.3-cli php7.3-common php7.3-curl php7.3-mbstring php7.3-mysql php7.3-xml php-zip unzip

echo "${SoftwareVersion} | ${green}==>Installing Composer For Laravel library latest Version .. ${reset}"

wget -O composer-setup.php https://getcomposer.org/installer

sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer

sudo composer self-update

echo "${SoftwareVersion} | ${green}==>Creating Software Directory CG1000 on /OPT/CG1000/ .. ${reset}"
mkdir -p /opt/SILVUECG1000/
mkdir -p /opt/SILVUECG1000/Database/
mkdir -p /opt/SILVUECG1000/Config/
mkdir -p /opt/SILVUECG1000/Database/
mkdir -p /opt/SILVUECG1000/Library/
mkdir -p /opt/SILVUECG1000/ProgramCG1000/
mkdir -p /opt/SILVUECG1000/install/
DIR1="/opt/SILVUECG1000/"
DIR2="/opt/SILVUECG1000/Database/"
DIR3="/opt/SILVUECG1000/Config/"
DIR4="/opt/SILVUECG1000/Library/"
DIR5="/opt/SILVUECG1000/ProgramCG1000/"
DIR6="/opt/SILVUECG1000/install/"
[ -d "$DIR1" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000${green} Succesfully"
[ -d "$DIR2" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000/Database${green} Succesfully"
[ -d "$DIR3" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000/Config ${green} Succesfully"
[ -d "$DIR4" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000/Library ${green} Succesfully"
[ -d "$DIR5" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000/ProgramCG1000 ${green} uccesfully"
[ -d "$DIR6" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory Install Succesfully"

echo "${SoftwareVersion} | ${green}==>Creating PATH and Copying Files Directory CG1000 on /OPT/CG1000/ .. ${reset}"
sudo chmod -R 777 *
cp -R /Library/ /opt/SILVUECG1000/Library/

echo "${SoftwareVersion} | ${green}==>Installing Mariadb Database Latest Version .. ${reset}"

sudo apt-get --assume-yes install mariadb-server

echo "${SoftwareVersion} | ${green}==>Installing Database .. ${reset}"

DBNAME="SILVUECG1000"
DBEXISTS=$(mysql --batch --skip-column-names -e "SHOW DATABASES LIKE '"$DBNAME"';" | grep "$DBNAME" > /dev/null; echo "$?")
if [ $DBEXISTS -eq 0 ];then
echo "${green}Creating Database $DBNAME Succesfully.${reset}"
else
mysql --execute="CREATE DATABASE SILVUECG1000;"
mysql SILVUECG1000 < Database/SILVUECG1000.sql
fi

echo "${SoftwareVersion} | ${green}==>Creating Users Database .. ${reset}"
RESULT_VARIABLE="$( mysql -sse "SELECT EXISTS(SELECT 1 FROM mysql.user WHERE user = 'CG1000')")"

if [ "$RESULT_VARIABLE" = 1 ]; then
echo "${green}Creating User Succesfully .. ${reset}"
else
mysql <<EOF
CREATE USER 'CG1000'@'localhost' IDENTIFIED BY 'cg1000';
GRANT ALL PRIVILEGES ON SILVUECG1000.* TO 'CG1000'@'localhost';
FLUSH PRIVILEGES;
EOF
fi

echo "${SoftwareVersion} | ${green}==>Installing Ada GNAT Compiler 2019 .. ${reset}"
echo "${green}Downloading Files GNAT 2019! .. ${reset}"
sudo aria2c --auto-file-renaming=false -d , --dir=/opt/SILVUECG1000/install/ "https://community.download.adacore.com/v1/0cd3e2a668332613b522d9612ffa27ef3eb0815b?filename=gnat-community-2019-20190517-x86_64-linux-bin&rand=433"

echo "${green}Executing GNAT 2019 installer! .. ${reset}"
sudo chmod -R 777 ./
sudo chmod u+x ./opt/SILVUECG1000/install/gnat-community-2019-20190517-x86_64-linux-bin

echo "${SoftwareVersion} | ${green}==>Installing Ada GNAT Networking Version 0.4.2 ${reset}"
cd /Library/libanet-0.4.2/
sudo make
sudo make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Ada GNAT Utility Version 2.4.1  ${reset}"
cd /Library/ada-util-2.4.1/
./configure
sudo make
sudo make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Ada GNAT Ado Database Version 2.2.0 ${reset}"
cd /Library/ada-ado-2.2.0/
./configure
sudo make
sudo make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Library OPCUA Protocol Version 1.2.2 ${reset}"
cd /Library/open62541-1.2.2/
mkdir build
cd build
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DUA_NAMESPACE_ZERO=MINIMAL -DUA_DEBUG=0  -DUA_LOGLEVEL=650  ..
sudo make -j4
sudo make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Library Modbus OPC Version 3.1.6 ${reset}"
cd /Library/libmodbus-3.1.6/
./configure
sudo make
sudo make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Library IEC 61850 Version 1.5.0  ${reset}"
cd /Library/libiec61850-1.5.0/
./configure
sudo make
sudo make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Main Program SiLVue CG1000 .. ${reset}"
yes | cp -rf ProgramCG1000/ /opt/SILVUECG1000/
yes | cp -rf Services/ProgramCG1000.service /etc/systemd/system/ProgramCG1000.service
yes | cp -rf Services/redundancyCG1000.service /etc/systemd/system/redundancyCG1000.service

echo "${SoftwareVersion} | ${green}==>Installing WebService SiLVue CG1000 .. ${reset}"
yes | cp -rf apache2/apache2.conf /etc/apache2/apache2.conf
yes | cp -rf apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
git clone https://github.com/lenfep/CG1000.git

echo "${SoftwareVersion}| ${green}==>Finishing Installation SilVue CG1000 And Default Configuration .. ${reset}"

systemctl enable ProgramCG1000
systemctl start redundancyCG1000

cd /var/www/html/CG1000
chgrp -R www-data storage bootstrap/cache
chmod -R ug+rwx storage bootstrap/cache
a2enmod rewrite
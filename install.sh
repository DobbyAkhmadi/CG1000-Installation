#!/bin/bash

red=`tput setaf 1`
green=`tput setaf 2`
blue=`tput setaf 4`
reset=`tput sgr0`
SoftwareVersion="${red}SiLVue CG1000 Len Ver 1.0"

echo "${SoftwareVersion} | ${green}==>CHECKING OPERATING SYSTEM !${reset}"
hostnamectl
echo "${SoftwareVersion} | ${green}==>RUNNING INSTALLER SILVUE CG1000 Packages .. ${reset}"
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
sudo apt-get --assume-yes install libncurses5
sudo apt-get --assume-yes install git


echo "${SoftwareVersion} | ${green}==>Installing PHP Library Version 7.3 .. ${reset}"

sudo apt-get --assume-yes install php7.3

sudo apt install --assume-yes wget php7.3 php7.3-cli php7.3-common php7.3-curl php7.3-mbstring php7.3-mysql php7.3-xml php-zip unzip
sed -i 's/^upload_max_filesize.*/upload_max_filesize = 100M/' /etc/php/7.3/fpm/php.ini
sed -i 's/^post_max_size.*/post_max_size = 100M/' /etc/php/7.3/fpm/php.ini

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
mkdir -p /opt/SILVUECG1000/Services/
mkdir -p /opt/SILVUECG1000/ProgramCG1000/
mkdir -p /opt/SILVUECG1000/install/
DIR1="/opt/SILVUECG1000/"
DIR2="/opt/SILVUECG1000/Database/"
DIR3="/opt/SILVUECG1000/Config/"
DIR4="/opt/SILVUECG1000/Library/"
DIR4="/opt/SILVUECG1000/Services/"
DIR5="/opt/SILVUECG1000/ProgramCG1000/"
DIR6="/opt/SILVUECG1000/install/"
[ -d "$DIR1" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000${green} Succesfully"
[ -d "$DIR2" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000/Database${green} Succesfully"
[ -d "$DIR3" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000/Config ${green} Succesfully"
[ -d "$DIR4" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000/Services ${green} Succesfully"
[ -d "$DIR4" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000/Library ${green} Succesfully"
[ -d "$DIR5" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory ${red}SILVUECG1000/ProgramCG1000 ${green} uccesfully"
[ -d "$DIR6" ] && echo "${SoftwareVersion} | ${green}==>Creating Directory Install Succesfully"

echo "${SoftwareVersion} | ${green}==>Creating PATH and Copying Files Directory CG1000 on /OPT/CG1000/ .. ${reset}"
sudo chmod -R 777 *
cd Library
chmod -R 777 /opt/SILVUECG1000/Library/
sudo cp -r * /opt/SILVUECG1000/Library/ 
cd ..

cd Database
chmod -R 777 /opt/SILVUECG1000/Database/
sudo cp -r * /opt/SILVUECG1000/Database/ 
cd ..

cd Config
chmod -R 777 /opt/SILVUECG1000/Config/
sudo cp -r * /opt/SILVUECG1000/Config/ 
cd ..

cd Services
chmod -R 777 /opt/SILVUECG1000/Services/
sudo cp -r * /opt/SILVUECG1000/Services/ 
cd ..

cd ProgramCG1000
chmod -R 777 /opt/SILVUECG1000/ProgramCG1000/
sudo cp -r * /opt/SILVUECG1000/ProgramCG1000/ 
chmod -R 777 /opt/SILVUECG1000/
cd ..

echo "${SoftwareVersion} | ${green}==>Adding PATH Environtment Variable GNAT 2019 ! ${reset}"

sed -i '1s/.*/export PATH=$PATH:\/opt\/GNAT\/2019\/bin/' ~/.bashrc
sed -i '2s/.*/export PATH=$PATH:\/opt\/gps\/bin/' ~/.bashrc
sed -i '3s/.*/export PATH=$PATH:\/usr\/local/' ~/.bashrc
source ~/.bashrc


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
cd /opt/SILVUECG1000/install/
chmod -R 777 *
DIR="/opt/GNAT/2019/"
if [ -d "$DIR" ]; then
echo "${green}GNAT 2019 Has Been Installed! .. ${reset}"
else
sudo -uscada ./gnat-community-2019-20190517-x86_64-linux-bin
fi
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Ada GNAT Networking Version 0.4.2 ${reset}"
cd /opt/SILVUECG1000/Library/libanet-0.4.2/
chmod -R 777 *
make
make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Ada GNAT Utility Version 2.4.1  ${reset}"
cd /opt/SILVUECG1000/Library/ada-util-2.4.1/
chmod -R 777 *
./configure
make
make install prefix=/opt/GNAT/2019/
cd ..
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Ada GNAT Ado Database Version 2.2.0 ${reset}"
cd /opt/SILVUECG1000/Library/ada-ado-2.2.0/
chmod -R 777 *
./configure
make
make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Library OPCUA Protocol Version 1.2.2 ${reset}"
cd /opt/SILVUECG1000/Library/open62541-1.2.2/
chmod -R 777 *
mkdir build
cd build
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DUA_NAMESPACE_ZERO=MINIMAL -DUA_DEBUG=0  -DUA_LOGLEVEL=650  ..
make -j4
make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Library Modbus OPC Version 3.1.6 ${reset}"
cd /opt/SILVUECG1000/Library/libmodbus-3.1.6/
chmod -R 777 *
./configure
make
make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Library IEC 61850 Version 1.5.0  ${reset}"
cd /opt/SILVUECG1000/Library/libiec61850-1.5.0/
chmod -R 777 *
./configure
make
make install prefix=/opt/GNAT/2019/
cd ..

echo "${SoftwareVersion} | ${green}==>Installing Main Program Services SiLVue CG1000 .. ${reset}"
cd /opt/SILVUECG1000/Services/
sudo cp -r * /etc/systemd/system/
cd ..
echo "${SoftwareVersion} | ${green}==>Installing WebService SiLVue CG1000 .. ${reset}"

cd /var/www/html/

DIR="/var/www/html/"
if [ -d "$DIR" ]; then
echo "${green}Web Server Has Installed! .. ${reset}"
else
git clone https://DobbyAkhmadi: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@github.com/lenfep/CG1000.git
fi

cd /var/www/html/CG1000/
chmod -R 777 *
echo "${SoftwareVersion}| ${green}==>Finishing Installation And Run Program SilVue CG1000 ${reset}"

systemctl restart mariadb

systemctl enable ProgramCG1000
systemctl enable redundancyCG1000
systemctl enable WebCG1000

systemctl restart ProgramCG1000
systemctl restart redundancyCG1000
systemctl restart WebCG1000

systemctl daemon-reload

echo "${SoftwareVersion}| ${green}==>The Installation is Finished! Thank You ! ${reset}"

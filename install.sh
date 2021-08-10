l#!/bin/bash

apt-get update
sed -i '1s/.*/export PATH=$PATH:\/opt\/GNAT\/2019\/bin/' ~/.bashrc
sed -i '2s/.*/export PATH=$PATH:\/opt\/gps\/bin/' ~/.bashrc
sed -i '3s/.*/export PATH=$PATH:\/usr\/local/' ~/.bashrc
source ~/.bashrc
apt-get --assume-yes install cmake
apt --assume-yes install net-tools

echo "Installation MariaDB ( Internet Connection Required )"
apt update
apt get --assume-yes install mariadb-server

echo "Database Configuration"
mysql --execute="CREATE DATABASE DBCG1000;"
mysql DBCG1000 < Database/SQLDBCG1000.sql
mysql <<EOF
CREATE USER 'FEP'@'%' IDENTIFIED BY 'fep';
GRANT ALL PRIVILEGES ON DBCG1000.* TO 'FEP'@'%';
FLUSH PRIVILEGES;
EOF

echo "Installation GNAT 2019 Compiler"
apt-get --assume-yes install libmbedtls-dev
apt-get --assume-yes install liburcu-dev
apt-get --assume-yes install check
apt update
apt-get --assume-yes install keepalived
apt-get --assume-yes install mariadb-client libmariadb-client-lgpl-dev
chmod -R 777 *
./Library/gnat-community-2019-20190517-x86_64-linux-bin

echo "Installation Ada Utility library"
cd Library/ada-util-master
./configure
make
make install prefix=/opt/GNAT/2019

echo "Installation Ada Ado Database library"
cd ..
cd Library/ada-ado
chmod 777 configure
./configure
make
make install prefix=/opt/GNAT/2019

echo "Installation OPCUA Library"
cd ..
cd Library/open62541
mkdir build
cd build
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DUA_NAMESPACE_ZERO=MINIMAL -DUA_DEBUG=0  -DUA_LOGLEVEL=650  ..
make -j4
make install
cd ..
cd ..
cd ..

echo "Installation Modbus TCP Protocol"
apt-get update
apt-get --assume-yes install libmodbus-dev

echo "Installation IEC61850 Protocol"
cd ..
cd Library/libiec61850
mkdir build
cd build


echo "Installing Main Program CG1000 wait a minute"
yes | cp -rf ProgramCG1000/ /opt/ProgramCG1000/
yes | cp -rf Config/apache2.conf /etc/apache2/apache2.conf
yes | cp -rf Config/000-default.conf /etc/apache2/sites-available/000-default.conf
service apache2 reload
echo "Creating Service Main Program CG1000"
yes | cp -rf Services/ProgramCG1000.service /etc/systemd/system/ProgramCG1000.service
yes | cp -rf Services/redundancy.service /etc/systemd/system/redundancy.service
echo "Enabling Main Program CG1000"
systemctl enable ProgramCG1000
echo "Starting Main Program CG1000"
systemctl start ProgramCG1000

echo "Installation PHP 7.3 Library ( Internet Connection Required )"
apt update
apt upgrade

apt --assume-yes install ca-certificates apt-transport-https 
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list
apt update
apt --assume-yes install php7.3
apt --assume-yes install php7.3-cli php7.3-common php7.3-curl php7.3-mbstring php7.3-mysql php7.3-xml

echo "Installation CG1000 From Main repository ( Internet Connection Required )"
cd /var/www/html/
git clone https://github.com/lenfep/CG1000.git

echo "Configure CG1000 Webservice Writing Permission"
cd /var/www/html/CG1000
chgrp -R www-data storage bootstrap/cache
chmod -R ug+rwx storage bootstrap/cache
a2enmod rewrite

systemctl restart apache2
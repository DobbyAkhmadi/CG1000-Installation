#!/bin/bash

yes | cp -rf instalasi/sources.list /etc/apt/sources.list
apt-get update
sed -i '1s/.*/export PATH=$PATH:\/opt\/GNAT\/2019\/bin/' ~/.bashrc
sed -i '2s/.*/export PATH=$PATH:\/opt\/gps\/bin/' ~/.bashrc
sed -i '3s/.*/export PATH=$PATH:\/usr\/local/' ~/.bashrc
source ~/.bashrc
apt-get --assume-yes install cmake
apt --assume-yes install net-tools
dpkg -i instalasi/mysql-apt-config_0.8.10-1_all.deb
apt-get --assume-yes install git build-essential gcc pkg-config cmake python python-six
apt-get --assume-yes install zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
cd instalasi/
tar -xf Python-3.8.2.tar.xz
cd Python-3.8.2
./configure --enable-optimizations
make -j 4
sudo make altinstall
pip3 install requests
pip3 install schedule
pip3 install mysql-connector-python-rf
cd ..
cd ..
apt-get --assume-yes install libmbedtls-dev
apt-get --assume-yes install liburcu-dev
apt-get --assume-yes install check
apt update
apt-get --assume-yes install keepalived
apt --assume-yes install mysql-server
apt-get --assume-yes install mariadb-client libmariadb-client-lgpl-dev
chmod -R 777 *
./gnat-community-2019-20190517-x86_64-linux-bin
cd instalasi/ada-util-master
./configure
make
make install prefix=/opt/GNAT/2019

cd ..
cd ada-ado
chmod 777 configure
./configure
make
make install prefix=/opt/GNAT/2019


cd ..
cd open62541-pack-master
mkdir build
cd build
cmake  -DCMAKE_BUILD_TYPE=MinSizeRel -DUA_NAMESPACE_ZERO=MINIMAL -DUA_DEBUG=0  -DUA_LOGLEVEL=650  ..
make -j4
make install
cd ..
cd ..
cd ..
mysql --execute="CREATE DATABASE tmis;"
mysql tmis < mysql/SQLTM1000.sql
mysql <<EOF
CREATE USER 'silvue'@localhost IDENTIFIED BY 'silvuetm1000';
GRANT ALL PRIVILEGES ON tmis.* TO 'silvue'@localhost;
FLUSH PRIVILEGES;
EOF


echo "copy file configuration, wait a minute"
yes | cp -rf Program/ADAProgram/ /opt/ADAProgram/
yes | cp -rf Program/TMIS/ /var/www/html/TMIS/
yes | cp -rf Program/operator/ /var/www/html/operator/
yes | cp -rf apache2/apache2.conf /etc/apache2/apache2.conf
yes | cp -rf apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
service apache2 reload
yes | cp -rf systemd/backupprogram.service /etc/systemd/system/backupprogram.service
yes | cp -rf systemd/browseserver.service /etc/systemd/system/browseserver.service
yes | cp -rf systemd/conflict.service /etc/systemd/system/conflict.service
yes | cp -rf systemd/controlpanel.service /etc/systemd/system/controlpanel.service
yes | cp -rf systemd/fullreplikasi.service /etc/systemd/system/fullreplikasi.service
yes | cp -rf systemd/opcdatachange.service /etc/systemd/system/opcdatachange.service
yes | cp -rf systemd/opcserver.service /etc/systemd/system/opcserver.service
yes | cp -rf systemd/redundancy.service /etc/systemd/system/redundancy.service
yes | cp -rf systemd/redundancyreceive.service /etc/systemd/system/redundancyreceive.service
yes | cp -rf systemd/tdspanel.service /etc/systemd/system/tdspanel.service
yes | cp -rf systemd/tdsserver.service /etc/systemd/system/tdsserver.service
yes | cp -rf keepalived/keepalivedtmp.conf /etc/keepalived/keepalivedtmp.conf
yes | cp -rf mysql/libmariadb/ /usr/local/include/libmariadb/

systemctl enable backupprogram
systemctl enable browseserver
systemctl enable conflict
systemctl enable controlpanel
systemctl enable opcdatachange
systemctl enable opcserver
systemctl enable redundancy
systemctl enable redundancyreceive
systemctl enable tdspanel

systemctl start browseserver
systemctl start conflict
systemctl start controlpanel
systemctl start opcdatachange
systemctl start opcserver
systemctl start redundancy
systemctl start redundancyreceive
systemctl start tdspanel

apt update
apt upgrade

apt --assume-yes install ca-certificates apt-transport-https 
wget -q https://packages.sury.org/php/apt.gpg -O- | apt-key add -
echo "deb https://packages.sury.org/php/ stretch main" | tee /etc/apt/sources.list.d/php.list
apt update
apt --assume-yes install php7.3
apt --assume-yes install php7.3-cli php7.3-common php7.3-curl php7.3-mbstring php7.3-mysql php7.3-xml

systemctl restart apache2

cd /var/www/html/TMIS
chgrp -R www-data storage bootstrap/cache
chmod -R ug+rwx storage bootstrap/cache
a2enmod rewrite
cd /var/www/html/operator
chgrp -R www-data storage bootstrap/cache
chmod -R ug+rwx storage bootstrap/cache
a2enmod rewrite

systemctl restart apache2

#!/bin/bash
mysql -u FEP -pfep -h 127.0.0.1 -P 3306 FEP<<EOFMYSQL
UPDATE REDUNDANCY_STATE SET VALUE=1 WHERE ITEM = 'Main_Flag';
UPDATE REDUNDANCY_STATE SET VALUE=0 WHERE ITEM = 'Backup_Flag';
UPDATE REDUNDANCY_STATE SET VALUE=0 WHERE ITEM = 'Fault_Flag';
EOFMYSQL
systemctl restart redundancy

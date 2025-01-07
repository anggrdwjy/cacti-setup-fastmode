#!/bin/bash
#===============================================================#
# Script Name   : cacti-ubuntu-install                          #
# Description   : Script Install Cacti on Ubuntu	              #
# Author        : Anggarda Saputra Wijaya                       #
# Github        : https://github.com/anggrdwjy.                 #
#===============================================================#
again='y'
while [[ $again == 'Y' ]] || [[ $again == 'y' ]] ; do
clear   
echo "      _____         __  _   ____                                     ";
echo "     / ___/__ _____/ /_(_) / __/__ _____  _____ ____                 "; 
echo "    / /__/ _  / __/ __/ / _\ \/ -_) __/ |/ / -_) __/                 ";
echo "    \___/\_,_/\__/\__/_/ /___/\__/_/  |___/\__/_/                    ";                      
echo "      ____    __              ____        __                __       ";
echo "     / __/__ / /___ _____    / __/__ ____/ /___ _  ___  ___/ /__     ";  
echo "    _\ \/ -_) __/ // / _ \  / _// _ ( _-< __/    \/ _ \/ _  / -_)    ";
echo "   /___/\__/\__/\_,_/ .__/ /_/  \_,_/___|__/_/_/_/\___/\_,_/\__/     ";
echo "                   /_/                                               ";
echo "												                                 ";
echo "   Version: 1.0.3 - 06/01/2025                            	         ";
echo "   Developer: https://github.com/anggrdwjy              	            ";
echo "   Support OS : Ubuntu 24.04 - 24.10                      	         ";
echo "                                                        	            ";
echo "   __________________________________________________	";                                                            
echo "                                                	   ";
echo "   Options List :                                		";
echo "   1) Install Cacti Server 1.2.28 Fastmode     		   ";
echo "   2) Install Cacti Plugins Weathermap 1.3.0 	      ";
echo "   3) Install Cacti Spine 1.2.20 		               ";
echo "   4) Reboot Server	                   		";
echo "   5) Exit         	                   		";
echo "   __________________________________________________ ";
echo "                                                      ";
read -p "   Enter a number the options listed: " choice;
echo "                                                    	";
case $choice in              

1) read -p "   Install Cacti Fastmode ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   sudo apt update
   sudo timedatectl set-timezone Asia/Jakarta
   sudo timedatectl set-ntp on
   sudo apt install unzip fping apache2 -y
   mv /var/www/html/index.html /var/www/html/index.html.bak
   cp support/html-index.html /var/www/html/index.html
   systemctl --now enable apache2
   sudo apt install php php-{mysql,curl,net-socket,gd,intl,pear,imap,memcache,pspell,tidy,xmlrpc,snmp,mbstring,gmp,json,xml,common,ldap} -y
   sudo apt install libapache2-mod-php
   mv /etc/php/8.3/apache2/php.ini /etc/php/8.3/apache2/php.ini.bak
   cp support/apache2-php.ini /etc/php/8.3/apache2/php.ini
   mv /etc/php/8.3/cli/php.ini /etc/php/8.3/cli/php.ini.bak
   cp support/cli-php.ini /etc/php/8.3/cli/php.ini
   sudo apt install mariadb-server mariadb-client-compat -y
   systemctl enable --now mariadb
   mysql -e "CREATE DATABASE cacti DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"            
   mysql -e "GRANT ALL PRIVILEGES ON cacti.* TO 'cacti'@'localhost' IDENTIFIED BY 'baseball';"
   mysql -e "GRANT SELECT ON mysql.time_zone_name TO cacti@localhost;"
   mysql -e "ALTER DATABASE cacti CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
   mysql -e "FLUSH PRIVILEGES;"
   mv /etc/mysql/mariadb.conf.d/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf.bak
   cp support/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
   mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
   sudo apt install snmp snmpd rrdtool -y
   unzip support/cacti-release-1.2.28.zip
   mv cacti-release-1.2.28/ /var/www/html/cacti/
   chmod -R 777 /var/www/html/
   mysql -u root cacti < /var/www/html/cacti/cacti.sql
   cp support/include-config.php /var/www/html/cacti/include/config.php
   chown -R www-data:www-data /var/www/html/cacti
   cp support/cactid.service /etc/systemd/system/cactid.service
   touch /etc/default/cactid
   systemctl --now enable cactid
   systemctl restart cactid
   systemctl daemon-reload
   echo "                                                  ";
   echo "   ======== Cacti Success Installing Done ======== 	   ";
   echo "                                                  ";
   fi
   ;;
   
2) read -p "   Install Plugin Weathermap 1.3.0 ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   sudo apt update
   unzip support/plugin_weathermap-1.3.zip
   mv plugin_weathermap-1.3/ /var/www/html/cacti/plugins/weathermap/
   chmod -R 777 /var/www/html/cacti/plugins/
   systemctl restart cactid
   cp support/weathermap-config.php /var/www/html/cacti/plugins/weathermap/config.php
   chown -R www-data:www-data /var/www/html/cacti/plugins/weathermap/configs
   systemctl restart cactid
   echo "                                                  ";
   echo "   ======== Plugin Weathermap Done Integration ========	   ";
   echo "                                                  ";
   fi
   ;;

3) read -p "   Install Spine 1.2.20 ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   sudo apt update
   sudo apt install build-essential autoconf automake dos2unix gzip help2man m4 make wget libtool libsnmp-dev libmariadb-dev libmariadb-dev -y
   unzip support/spine-release-1.2.20.zip
   cd spine-release-1.2.20
   sudo ./bootstrap
   sudo ./configure
   sudo make
   sudo make install
   sudo ./configure --prefix=/opt/spine
   cd ..
   cp support/etc-spine.conf /usr/local/spine/etc/spine.conf
   chown root:root /usr/local/spine/bin/spine
   chmod +s /usr/local/spine/bin/spine
   echo "                                                  ";
   echo "   ======== Spine Done Integration ========	   ";
   echo "                                                  ";
   fi
   ;;
   
4) read -p "   Reboot Your Server ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   reboot
   fi
   ;;
   
5) exit
   ;;

*)    echo "Sorry, Your Choice Not Available"
esac
echo "                                                  ";
echo -n "Back to Menu? [y/n]: ";
echo "                                                  ";
read again;
while [[ $again != 'Y' ]] && [[ $again != 'y' ]] && [[ $again != 'N' ]] && [[ $again != 'n' ]];
do
echo " Variable Not Available in Menu ";
echo "                                                  ";
echo -n "Back to Menu? [y/n]: ";
echo "                                                  ";
read again;
done
done 


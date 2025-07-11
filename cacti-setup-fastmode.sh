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
echo "   Version: 1.0.4 - 13/04/2025                            	         ";
echo "   Developer: https://github.com/anggrdwjy              	            ";
echo "   Support OS : Ubuntu 24.04 - 24.10                      	         ";
echo "                                                        	            ";
echo "   __________________________________________________	";                                                            
echo "                                                	   ";
echo "   Options List :                                		";
echo "   1) Install Cacti 1.2.28 Fastmode     		         ";
echo "   2) Install Cacti Plugins Weathermap 1.3.0 	      ";
echo "   3) Install Cacti Spine 1.2.20 		               ";
echo "   4) Reboot Server	                   		         ";
echo "   5) Exit         	                   		         ";
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
   apt update -y
   timedatectl set-timezone Asia/Jakarta
   timedatectl set-ntp on
   apt install software-properties-common
   apt install unzip fping apache2 mariadb-server mariadb-client mariadb-client-compat snmp snmpd rrdtool -y
   apt install php libapache2-mod-php php-{mysql,curl,net-socket,gd,intl,pear,imap,memcache,pspell,tidy,xmlrpc,snmp,mbstring,gmp,json,xml,common,ldap} -y
   apt install build-essential autoconf automake dos2unix gzip help2man m4 make wget libtool libsnmp-dev libmariadb-dev libmariadb-dev -y
   systemctl enable --now mariadb
   mysql -e "CREATE DATABASE cacti DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci;"            
   mysql -e "GRANT ALL PRIVILEGES ON cacti.* TO 'cacti'@'localhost' IDENTIFIED BY 'baseball';"
   mysql -e "GRANT SELECT ON mysql.time_zone_name TO cacti@localhost;"
   mysql -e "ALTER DATABASE cacti CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;"
   mysql -e "FLUSH PRIVILEGES;"
   wget https://github.com/Cacti/cacti/archive/refs/tags/release/1.2.28.zip
   unzip 1.2.28.zip
   mv cacti-release-1.2.28 /var/www/html/cacti
   rm 1.2.28.zip
   chown -R www-data:www-data /var/www/html/cacti
   chmod -R 777 /var/www/html/cacti
   mv /etc/php/8.3/apache2/php.ini /home/apache2-php.ini
   mv /etc/php/8.3/cli/php.ini /home/cli-php.ini
   mv /etc/mysql/mariadb.conf.d/50-server.cnf /home/mariadb-50server.cnf
   cp support/apache2-php.ini /etc/php/8.3/apache2/php.ini
   cp support/cli-php.ini /etc/php/8.3/cli/php.ini
   cp support/include-config.php /var/www/html/cacti/include/config.php
   cp support/mariadb-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
   cp support/system-cactid.service /etc/systemd/system/cactid.service
   touch /etc/default/cactid
   systemctl enable --now cactid
   systemctl restart cactid
   systemctl daemon-reload
   systemctl restart mariadb
   systemctl restart apache2
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
   wget https://github.com/Cacti/plugin_weathermap/archive/refs/tags/v1.3.zip
   unzip v1.3.zip
   mv plugin_weathermap-1.3 /var/www/html/cacti/plugins/weathermap 
   rm v1.3.zip
   chown -R www-data:www-data /var/www/html/cacti/plugins/weathermap
   chmod -R 777 /var/www/html/cacti/plugins/weathermap
   cp support/weathermap-config.php /var/www/html/cacti/plugins/weathermap/config.php
   systemctl restart cactid
   echo "                                                  ";
   echo "   ======== Plugin Weathermap Done Integration ========	   ";
   echo "   ======== Enable Plugin (Configuration -> Plugin -> Enable Weathermap) ========	   ";
   echo "                                                  ";
   fi
   ;;

3) read -p "   Install Spine 1.2.20 ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   wget https://github.com/Cacti/spine/archive/refs/tags/release/1.2.20.zip
   unzip 1.2.20.zip
   cd spine-release-1.2.20
   ./bootstrap
   ./configure
   make
   make install
   ./configure --prefix=/opt/spine
   cd ..
   rm 1.2.20.zip | rm -r spine-release-1.2.20
   mv /usr/local/spine/etc/spine.conf /home/etc-spine.conf
   cp support/etc-spine.conf /usr/local/spine/etc/spine.conf
   chown -R root:root /usr/local/spine/bin/spine
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


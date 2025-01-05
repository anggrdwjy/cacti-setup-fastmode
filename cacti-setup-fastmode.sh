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
echo "                                                                                                ";
echo "      ______           __  _    _       __           __  __                                     ";
echo "     / ____/___ ______/ /_(_)  | |     / /__  ____ _/ /_/ /_  ___  _________ ___  ____ _____    ";
echo "    / /   / __  / ___/ __/ /   | | /| / / _ \/ __  / __/ __ \/ _ \/ ___/ __  __ \/ __  / __ \   ";
echo "   / /___/ /_/ / /__/ /_/ /    | |/ |/ /  __/ /_/ / /_/ / / /  __/ /  / / / / / / /_/ / /_/ /   ";
echo "   \____/\__,_/\___/\__/_/     |__/|__/\___/\__,_/\__/_/ /_/\___/_/  /_/ /_/ /_/\__,_/ .___/    ";
echo "                                                                                    /_/         ";
echo "       ______           __                      __        ____           __        ____            ";
echo "      / ____/___ ______/ /_____ ___  ____  ____/ /__     /  _/___  _____/ /_____ _/ / /__  _____   ";
echo "     / /_  / __  / ___/ __/ __  __ \/ __ \/ __  / _ \    / // __ \/ ___/ __/ __  / / / _ \/ ___/   ";
echo "    / __/ / /_/ (__  ) /_/ / / / / / /_/ / /_/ /  __/  _/ // / / (__  ) /_/ /_/ / / /  __/ /       ";
echo "   /_/    \__,_/____/\__/_/ /_/ /_/\____/\__,_/\___/  /___/_/ /_/____/\__/\__,_/_/_/\___/_/        ";
echo "												                                 ";
echo "												                                 ";
echo "   Version: 1.0.1 - 04/01/2025                            	            ";
echo "   Developer: https://github.com/anggrdwjy              	            ";
echo "   Support OS : Ubuntu 24.04 - 24.10                      	         ";
echo "                                                        	            ";
echo "   __________________________________________________	";                                                            
echo "                                                	      	";
echo "   Options List :                                		";
echo "   1) Install Cacti Server Fastmode      		";
echo "   2) Install Cacti Plugins Weathermap   		";
echo "   3) Reboot Server	                   		";
echo "   4) Exit         	                   		";
echo "   __________________________________________________   	 ";
echo "                                                          ";
read -p "   Enter a number the options listed: " choice;
echo "                                                        	";
case $choice in              

1) read -p "   Install Cacti Fastmode ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   sudo apt update
   sudo apt install unzip fping apache2 -y
   systemctl enable --now apache2
   mv /var/www/html/index.html /var/www/html/index.html.bak
   cp support/html-index.html /var/www/html/index.html
   systemctl restart apache2
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
   systemctl restart apache2
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
   systemctl restart apache2
   systemctl restart mariadb
   systemctl restart cactid
   systemctl daemon-reload
   echo "                                                  ";
   echo "   ======== Cacti Success Installing Done ======== 	   ";
   echo "                                                  ";
   fi
   ;;
   
2) read -p "   Install Cacti Weathermap ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   sudo apt update
   cp support/plugin_weathermap-1.3.zip /var/www/html/cacti/plugins/plugin_weathermap-1.3.zip
   unzip /var/www/html/cacti/plugins/plugin_weathermap-1.3.zip
   mv /var/www/html/cacti/plugins/plugin_weathermap-1.3 /var/www/html/cacti/plugins/weathermap
   chmod -R 777 /var/www/html/cacti/plugins/
   systemctl restart cactid
   cp support/weathermap-config.php /var/www/html/cacti/plugins/weathermap/config.php
   chown -R www-data:www-data /var/www/html/cacti/plugins/weathermap/configs
   echo "                                                  ";
   echo "   ======== Weathermap Done Integration ========	   ";
   echo "                                                  ";
   fi
   ;;

3) read -p "   Reboot Your Server ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   reboot
   fi
   ;;
   
4) exit
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


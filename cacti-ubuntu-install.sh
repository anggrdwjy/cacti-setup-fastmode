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
echo "   __________________________________________________	";                                                            
echo "                                                	      	";
echo "   Options List :                                		";
echo "   1) Install Apache2 and PHP        			";
echo "   2) Install MariaDB Server        			";
echo "   3) Create MariaDB Database                   		";
echo "   4) Install Cacti Server                      		";
echo "   5) Reboot Server	                   		";
echo "   6) Exit		                      		";
echo "   __________________________________________________   	";
echo "                                                          ";
read -p "   Enter a number the options listed: " choice;
echo "                                                        	";
case $choice in              

1) read -p "   Install Apache2 and PHP ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   apt-get update
   apt-get install software-properties-common -y
   apt-get install apache2 -y
   apt-get install php php-mysql php-snmp php-gd php-xml php-curl php-mbstring php-gmp php-intl php-json -y
   systemctl --now enable apache2
   systemctl status apache2
   echo "                                                  ";
   echo "   ======== Apache2 and PHP Done ======== 	   ";
   echo "                                                  ";
   fi
   ;;

2) read -p "   Install MariaDB Server ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   apt-get install mariadb-server -y
   systemctl --now enable mariadb
   systemctl restart apache2
   echo "                                                  ";
   echo "   ======== MariaDB Installing Done ========	   ";
   echo "                                                  ";
   fi
   ;;

3) read -p "   Create Database MariaDB ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   mysql -u root
   CREATE DATABASE cacti;
   CREATE USER 'cacti'@'localhost' IDENTIFIED BY 'baseball'; 
   GRANT ALL PRIVILEGES ON cacti.* TO 'cacti'@'localhost';
   FLUSH PRIVILEGES;
   EXIT;
   echo "                                                  ";
   echo "   ======== Database Create Done ========	   ";
   echo "                                                  ";
   fi
   ;;

4) read -p "   Install Cacti Server ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   apt update
   apt install cacti cacti-spine -y
   mv /etc/apache2/conf-available/cacti.conf /etc/apache2/conf-available/cacti.conf.bak
   cp support/cacti.conf /etc/apache2/conf-available/cacti.conf
   a2enconf cacti
   mv /etc/cron.d/cacti /etc/cron.d/cacti.bak
   cp support/cacti /etc/cron.d/cacti
   mv /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/000-default.conf.bak
   cp support/000-default.conf /etc/apache2/sites-available/000-default.conf
   chown -R www-data:www-data /usr/share/cacti/site/rra /usr/share/cacti/site/log
   systemctl restart apache2
   echo "                                                  ";
   echo "   ======== Cacti Installing Done ========	   ";
   echo "                                                  ";
   fi
   ;;

5) read -p "   Reboot Your Server ? y/n :" -n 1 -r
   echo "                                                  ";
   echo "                                                  ";
   if [[ ! $REPLY =~ ^[Nn]$ ]] 
   then
   reboot
   fi
   ;;
   
6) exit
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


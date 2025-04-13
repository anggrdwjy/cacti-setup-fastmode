## This Tools Fastmode Setup Cacti Server With Spine and Plugins Weathermap

## Information

Before using this program, make sure to update the repository `sudo apt update` and install git `sudo apt install git -y` to maximize the running of the program. I am not responsible for any consequences caused by this program. It is recommended to use this script when a new server is installed with a minimum of 2CPUs. 4GB RAM and 20GB Disk. The program has been tested on Ubuntu 24.04 - 24.10.

## Features
* Setup Apache2 Web Server, PHP and MariaDB
* Cacti 1.2.28
* Cacti Spine 1.2.20
* Plugins Cacti Weathermap 1.3.0

## Support OS
* Ubuntu 24.04
* Ubuntu 24.10

## Edit Username and Password

nano cacti-setup-fastmode.sh
```
mysql -e "GRANT ALL PRIVILEGES ON cacti.* TO 'cacti'@'localhost' IDENTIFIED BY 'baseball';"      //Edit Username `cacti` and Password `baseball`//
```
nano /var/www/html/cacti/include/config.php
```
$database_type        = 'mysql';
$database_default     = 'cacti';
$database_hostname    = 'localhost';
$database_username    = 'cacti';      //Edit Username//
$database_password    = 'baseball';   //Edit Password//
$database_port        = '3306';
$database_retries     = 5;
$database_ssl         = false;
$database_ssl_key     = '';
$database_ssl_cert    = '';
$database_ssl_ca      = '';
$database_ssl_capath  = '';
$database_ssl_verify_server_cert = true;
$database_persist     = false;
```
nano /usr/local/spine/etc/spine.conf
```
DB_Host       localhost
DB_Database   cacti     
DB_User       cacti       //Edit Username//
DB_Pass       baseball    //Edit Password//
DB_Port       3306
```

## Installing Program
```
git clone https://github.com/anggrdwjy/cacti-setup-fastmode.git
```
```
cd cacti-setup-fastmode
```
```
chmod -R 777 *
```

## Running Program
```
./cacti-setup-fastmode.sh
```

## Default Access Web Server Cacti

Username : `admin` | Password : `admin`
```
http://ip-address/cacti
```

## NTP Clock Adjustment
```
sudo timedatectl list-timezones             //Search Timezone//
sudo timedatectl set-timezone Asia/Jakarta 
sudo timedatectl set-ntp on
```

## Support

* [:octocat: Follow me on GitHub](https://github.com/anggrdwjy)
* [🔔 Subscribe me on Youtube](https://www.youtube.com/@anggarda.wijaya)

## References

* https://github.com/Cacti/cacti.git
* https://github.com/Cacti/plugin_weathermap.git
* https://github.com/Cacti/spine

## Bugs

Please open an issue on GitHub with as much information as possible if you found a bug.
* Your Distro Version
* All the logs and message outputted
* etc

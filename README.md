## This Tools Fastmode Setup Cacti Graphing Monitoring with Cacti Weathermap Plugins

```                                                                                                   
      _____         __  _   ____                                     
     / ___/__ _____/ /_(_) / __/__ _____  _____ ____                  
    / /__/ _  / __/ __/ / _\ \/ -_) __/ |/ / -_) __/                 
    \___/\_,_/\__/\__/_/ /___/\__/_/  |___/\__/_/                                          
      ____    __              ____        __                __       
     / __/__ / /___ _____    / __/__ ____/ /___ _  ___  ___/ /__       
    _\ \/ -_) __/ // / _ \  / _// _ ( _-< __/    \/ _ \/ _  / -_)    
   /___/\__/\__/\_,_/ .__/ /_/  \_,_/___|__/_/_/_/\___/\_,_/\__/     
                   /_/

      Version: 1.0.3 - 06/01/2025                            	        
      Developer: https://github.com/anggrdwjy              	            
      Support OS : Ubuntu 24.04 - 24.10                      	         "
                                                                                           
```

## Information

Before using this program, make sure to install `git` to maximize the program. I am not responsible for any consequences caused by this program. It is recommended to use this script when the new server is installed with minimal 2CPU. RAM 4GB and Disk 20GB. This program has been tested on Ubuntu 24.04 - 24.10.

## Features
* Setup Fastmode
* Web Server Apache2
* Database MariaDB 11.4
* PHP Language 8.3
* Cacti Server 1.2.28
* Cacti Spine 1.2.20
* Plugins Cacti Weathermap 1.3.0

## Support OS
* Ubuntu 24.04
* Ubuntu 24.10

## Edit Username and Password

nano cacti-setup-fastmode.sh
```
mysql -e "GRANT ALL PRIVILEGES ON cacti.* TO 'cacti'@'localhost' IDENTIFIED BY 'baseball';"      //Edit Username 'cacti' and Password 'baseball'//
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

## Access Cacti Server [Non-SSL]
```
http://ip-address/cacti
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

## This Tools Fastmode Setup Cacti Graphing Monitoring with Cacti Weathermap Plugins

```                                                                                                   
      ______           __  _    _       __           __  __                                     
     / ____/___ ______/ /_(_)  | |     / /__  ____ _/ /_/ /_  ___  _________ ___  ____ _____    
    / /   / __  / ___/ __/ /   | | /| / / _ \/ __  / __/ __ \/ _ \/ ___/ __  __ \/ __  / __ \   
   / /___/ /_/ / /__/ /_/ /    | |/ |/ /  __/ /_/ / /_/ / / /  __/ /  / / / / / / /_/ / /_/ /   
   \____/\__,_/\___/\__/_/     |__/|__/\___/\__,_/\__/_/ /_/\___/_/  /_/ /_/ /_/\__,_/ .___/    
                                                                                    /_/         
       ______           __                      __        ____           __        ____            
      / ____/___ ______/ /_____ ___  ____  ____/ /__     /  _/___  _____/ /_____ _/ / /__  _____   
     / /_  / __  / ___/ __/ __  __ \/ __ \/ __  / _ \    / // __ \/ ___/ __/ __  / / / _ \/ ___/   
    / __/ / /_/ (__  ) /_/ / / / / / /_/ / /_/ /  __/  _/ // / / (__  ) /_/ /_/ / / /  __/ /       
   /_/    \__,_/____/\__/_/ /_/ /_/\____/\__,_/\___/  /___/_/ /_/____/\__/\__,_/_/_/\___/_/        
                                           /_/                   

   Version: 1.0 - 03/01/2025                            	            
   Developer: https://github.com/anggrdwjy              	            
   Support OS : Ubuntu 24.04 - 24.10
                                                                                           
```

## Information

Before using this program, make sure to install `git` to maximize the program. I am not responsible for any consequences caused by this program. It is recommended to use this script when the new server is installed with minimal 2CPU. RAM 4GB and Disk 20GB. This program has been tested on Ubuntu 24.04 - 24.10.

## Features
* Fastmode Installer
* Apache2
* MariaDB 11.4.x
* PHP Language 8.3
* Cacti Server 1.3.x
* Plugins Cacti Weathermap 1.2.x

## Support OS
* Ubuntu 24.04
* Ubuntu 24.10

## Edit Username and Password

nano cacti-setup-fastmode.sh
```
mysql -e "GRANT ALL PRIVILEGES ON cacti.* TO 'cacti'@'localhost' IDENTIFIED BY 'baseball';"
```
nano /var/www/html/cacti/include/config.php
```
$database_type        = 'mysql';
$database_default     = 'cacti';
$database_hostname    = 'localhost';
$database_username    = 'cacti';
$database_password    = 'baseball';
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

## Support

* [:octocat: Follow me on GitHub](https://github.com/anggrdwjy)
* [🔔 Subscribe me on Youtube](https://www.youtube.com/@anggarda.wijaya)

## References

* https://github.com/Cacti/cacti.git
* https://github.com/Cacti/plugin_weathermap.git

## Bugs

Please open an issue on GitHub with as much information as possible if you found a bug.
* Your Distro Version
* All the logs and message outputted
* etc

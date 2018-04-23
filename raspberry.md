#Installation of a Minecraft Raspberry Server

## Raspberry Pi Model
It is recommended we use Raspberry 3 with its 1Gigabyte of RAM and a quad core ARM cpu.n\This version does not need overclocking configurations.
We can download the OS for installation on your raspberry usb micro sd [here](https://www.raspberrypi.org/downloads/raspbian/). 
Using [etch]()we can make our micro sd card bootable. The Rasbian Stretch version is preferable and you can decide between the Lite or Desktop images.

## Why Raspberry Pi
We will use a raspberry Pi for test purposes and to start a small minecraft server for a lan server.
The tested environment shall be transferable into a dedicated server provided. This dedicated server shall have its server.properties file reconfigured to accomodate the bigger server on a dedicated Linux hardware with Intel/AMD processors. In addition, since Rasbian is a debian distribution, all configurations and instructions would work on Debian servers.
## Login to your Pi
 Via using your console
 Via using ssh: ssh pi@address 
## Download Java
Minecraft requires Java to run. We will download the latest Oracle Java.
We will change to the /opt directory, use wget to download and accept Oracle agreements and then extract contents to the opt folder. The following command will help us;
- cd /opt
- sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-arm32-vfp-hflt.tar.gz
- sudo tar -zxvf jdk-8u161-linux-arm32-vfp-hflt.tar.gz
## COnfiguration of Java
We will configure the Java environment to permit our our system access the java binary and compiler necessary in building our minecraft server.
We will use the following commands;
- sudo update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_161/bin/java 1
- sudo update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_161/bin/javac 1 
We will then set this java version as the default versions. Select the right version option.
- sudo update-alternatives --config java
- sudo update-alternatives --config javac

We will then check our java version
- java -version
- javac -version

## Setting Up Minecraft environment

Lets update and upgrade our system
- sudo apt-get update && sudo apt-get -y upgrade
Install git
- sudo apt-get install git

Lets install screen to assist us run the minecraft server console while logged out of pi.
- sudo apt-get install screen
## Installing Minecraft
We will install the [Spigot Minecraft Server build](https://www.spigotmc.org).
lets create a folder
cd /home/pi
mkdir codeblockers
cd codeblockers

We will download the buildtools
- wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
Then build our server. This compilation process takes close to an hour on a Pi 3 system.
- sudo java -jar BuildTools.jar --rev 1.12.2
## Configuring the Spigot server
Once the compilation is completewe should ensure we are in the codeblockers directory and run the server for the first time.
- sudo java -Xms512M -Xmx1008M -jar /home/pi/codeblockers/spigot-1.12.2.jar nogui
We will then accept the EULA agreement after the server stops running.
- sudo nano eula.txt
Inside the eula.txt, change the line _eula=false_ to _eula=true_

Let us now change the server properties
- sudo nano server.properties

The following properties are recommended for a start, but you can change server.properties following its Wiki.
#Minecraft server properties
spawn-protection=16
generator-settings=
force-gamemode=true
allow-nether=true
gamemode=0
enable-query=false
player-idle-timeout=0
difficulty=2
spawn-monsters=true
op-permission-level=4
announce-player-achievements=true
pvp=true
snooper-enabled=true
level-type=DEFAULT
hardcore=false
enable-command-block=false
max-players=10
network-compression-threshold=256
resource-pack-sha1=
max-world-size=29999984
server-port=25565
debug=false
server-ip=
spawn-npcs=true
allow-flight=false
level-name=world
view-distance=10
resource-pack=
spawn-animals=true
white-list=false
generate-structures=true
online-mode=true
max-build-height=256
level-seed=
prevent-proxy-connections=false
use-native-transport=true
motd=My Minecraft Server
enable-rcon=false

Now lets rerun our server
sudo java -Xms512M -Xmx1008M -jar /home/pi/codeblockers/spigot-1.12.2.jar nogui


## Script to Run server
Lets make the minecraft server to run from a script.
 - mkdir /home/pi/startup
   - cd /home/pi/startup
   - nano minecraft.sh
Inside our minecraft.sh, we will add the following scripts.
#!/bin/bash
    cd /home/pi/codeblockers/ && java -Xms512M -Xmx1008M -jar /home/pi/codeblockers/spigot-1.12.2.jar nogui

We will save the file and make it executable
- chmod u+x minecraft.sh
Lets start the server
- screen   <---hit enter at the message that appears.
- sudo /home/pi/startup/minecraft.sh
To exit the screen session hit _CTRL AD_
## Configure Minecraft to start on bootup
We will edit the /etc/rc.local file
- sudo nano /etc/rc.local
Insert the following before the last line _exit 0_
- screen -dm -S minecraft /home/pi/startup/minecraft.sh
## After bootup the following can be run
- sudo screen -r minecraft

## Creating Backup
This will permit restoring the minecraft server
- cd ~
- tar -zcvf codeblockers_backup.tar.gz codeblockers
We can now copy this zip file to a safe location or server. Restoration should be done regularly considering we have to entertain others and their achievements. This is this area which needs technical support in great details.

 


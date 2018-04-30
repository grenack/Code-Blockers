#!/bin/sh
# Installing on x64 platform,Linux server
echo "we will be installing on a linux based distribution with this script."
sleep 5

echo "go to /opt directory"
cd /opt
echo "install oracle java  and accept agreement"
sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-x64.tar.gz

echo "complile into a zip file"
tar -zxvf jdk-8u161-linux-x64.tar.gz
echo"configure java environment" 
sudo update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_161/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_161/bin/javac 1

echo "set java version and compiler as default"
sleep 1
echo "ensure you select the right option downloaded"
sudo update-alternatives --config java
sudo update-alternatives --config javac

echo "check java version"
sudo java -version
sleep 2
sudo javac -version
sleep 2
echo "update and upgrade"
sudo apt-get update && sudo apt-get -y upgrade
echo "install git"
echo "install screen to help run minecraft server console"
sudo apt-get install screen
echo "create a folder"
cd /opt
    sudo mkdir minecraft
    cd minecraft
sleep 1
echo "download buildtools"
sudo wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

echo "build the server"
sudo java -jar BuildTools.jar --rev 1.12.2
echo "lets run our server"
sudo java -Xms1024M -Xmx2048M -jar /opt/minecraft/spigot-1.12.2.jar nogui
echo "accept eula agreement"
sudo nano eula.txt
echo "configure server.properties"
sudo nano server.properties
echo "rerun our minecraft server"
sudo java -Xms1024M -Xmx2048M -jar /opt/minecraft/spigot-1.12.2.jar nogui
echo "bootup server automatically with a script"
cd /opt && sudo mkdir scripts
    cd scripts
    sudo nano codebminecraft.sh
echo "insert the command to run the server in the bash script you create"
echo  " cd /opt/minecraft/ && java -Xms1024M -Xmx2048M -jar /opt/minecraft/spigot-1.12.2.jar nogui"

sleep 5
echo "make the script executable"
sudo chmod u+x codebminecraft.sh
echo "lets start the server"
sudo screen
./opt/scripts/codebminecraft.sh
echo "to exit screen use CTRL AD"
sleep 1
echo "lets save our working serving"
cd /opt
tar -zcvf codebminecraft_backup.tar.gz minecfraft
echo "lets harden our firewall"
sudo iptables -A INPUT -p tcp --dport 25565 -m state --state NEW -j ACCEPT
echo "lets make the script to start on bootup"
sudo nano /etc/rc.local
echo "add the foolowing into the line before exit 0... screen -dm -S minecraft /opt/scripts/codebminecraft.sh"

echo "end of script"

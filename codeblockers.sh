#!/bin/sh
echo "go to /opt directory"
cd /opt
echo "install oracle java  and accept agreement"
sudo wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u161-b12/2f38c3b165be4555a1fa6e98c45e0808/jdk-8u161-linux-arm32-vfp-hflt.tar.gz
echo "complile into a zip file"
sudo tar -zxvf jdk-8u161-linux-arm32-vfp-hflt.tar.gz
echo"configure java environment" 
sudo update-alternatives --install /usr/bin/java java /opt/jdk1.8.0_161/bin/java 1
sudo update-alternatives --install /usr/bin/javac javac /opt/jdk1.8.0_161/bin/javac 1
echo "set java version and compiler as default"
sleep 1
echo "ensure you select the right option downloaded"
sudo update-alternatives --config java
sudo update-alternatives --config javac

echo "check java version"
java -version
sleep 2
javac -version
sleep 2
echo "update and upgrade"
sudo apt-get update && sudo apt-get -y upgrade
echo "install git"
echo "install screen to help run minecraft server console"
sudo apt-get install screen
echo "create a folder"
cd ~
mkdir codeblockers
cd codeblockers
sleep 1
echo "download buildtools"
wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
echo "build the server"
sudo java -jar BuildTools.jar --rev 1.12.2
echo "lets run our server"
sudo java -Xms512M -Xmx1008M -jar ~/codeblockers/spigot-1.12.2.jar nogui
echo "accept eula agreement"
sudo nano eula.txt
echo "configure server.properties"
sudo nano server.properties
echo "rerun our minecraft server"
sudo java -Xms512M -Xmx1008M -jar ~/codeblockers/spigot-1.12.2.jar nogui
echo "bootup server automatically with a script"
mkdir ~/startup
cd ~/startup
nano codebminecraft.sh
echo "insert the command to run the server in the bash script you create"
sleep 2
echo "make the script executable"
chmod u+x codebminecraft.sh
echo "lets start the server"
screen
sudo ~/startup/minecraft.sh
echo "to exit screen use CTRL AD"
sleep 1
echo "lets save our working serving"
cd ~
tar -zcvf codebminecraft_backup.tar.gz codeblockers

echo "end of script"

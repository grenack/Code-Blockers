# Installation Procedure
Install the raspberry pi using the Rasbian version of linux.
This permits us to configure our raspberry. We will configure our Raspberry to operate in command line mode. Then we will enable SSH by using the following command to assist us.
#sudo raspi-config
this command was not used as I deployed on sootsplash.csci2461.com


The hostname of our server is necessary so we use for configurations of our DNS
#sudo hostname -I

Now we create a directory where all our installation files and downloads will be hosted.
#sudo mkdir /home/minecraft1
now let's download the Minecraft server. We will retrieve using wget.
#sudo wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar

In using the spigot version we need java tools to suthe java build tools file to create the server. We will need the latest version available.
#sudo java -jar Buildtools.jar --rev latest  
This command failed when it was launched, saying java; not found
so I used the the following
#sudo apt-get install git openjdk-8-jre-headless
it took 1minutes installing
Check the java version with the following command
#java -version
check the firewall if you are using IP tables to add an exception to iptables rules
#sudo iptables -A INPUT -p tcp --dport 25565 -j ACCEPT
We will be using tcp port 25565


lets create a minecraft user
#sudo adduser mincraft
#sudo su - minecraft
#mkdir build
#cd build
#wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar
#java -jar BuildTools.jar
This will take about 10 minutes
The following installation summary was made after the installation
[INFO] Reactor Summary:
[INFO] 
[INFO] Spigot-API ......................................... SUCCESS [ 13.257 s]
[INFO] Spigot-Parent ...................................... SUCCESS [  0.261 s]
[INFO] Spigot ............................................. SUCCESS [ 57.322 s]
[INFO] ------------------------------------------------------------------------
[INFO] BUILD SUCCESS
[INFO] ------------------------------------------------------------------------
[INFO] Total time: 01:11 min
[INFO] Finished at: 2018-04-12T01:15:36Z
[INFO] Final Memory: 30M/454M
[INFO] ------------------------------------------------------------------------
 

We will move the resulting **.jar** file to a folder
#mkdir ../server
#cd ../server
#mv ../build/spigot-1.*.jar spigot.jar

now let us create a script to boot
names wrapper.sh
using the following commands
#!/bin/bash
#cd /home/mincraft/server
#java -XX:MaxPermSize=1024M -Xms512M -Xmx1536M -jar spigot.jar

This file permission can be changed according to our diskspace
lets the file executable 
#chmod +x /home/minecraft/server/wrapper.sh

Now let's start spigot
#java -Xms512M -Xmx900M -jar spigot.jar

It will say the following;
Loading libraries, please wait...
[01:27:31 INFO]: Starting minecraft server version 1.12.2
[01:27:31 INFO]: Loading properties
[01:27:31 WARN]: server.properties does not exist
[01:27:31 INFO]: Generating new properties file
[01:27:31 WARN]: Failed to load eula.txt
[01:27:31 INFO]: You need to agree to the EULA in order to run the server. Go to eula.txt for more info.
[01:27:31 INFO]: Stopping server


We will have to accept the eula agreement by using the following
nano eula.txt
and editing the **line 3** from _eula=false_ to **_eula=TRUE_**

now lets exit the minecraft user
Using the root user account _nano /etc/rc.local_ and add  
#su -l minecraft -c "screen -dmS minecraft /home/minecraft/server/wrapper.sh"
Add the above before the _exit 0_


to manually start the service
#sudo su -l minecraft -c "screen -dmS minecraft /home/minecraft/server/wrapper.sh"


The following error was noticed;
OpenJDK 64-Bit Server VM warning: ignoring option MaxPermSize=1024M; support was removed in 8.0
Loading libraries, please wait...
2018-04-12 01:59:31,751 main ERROR Cannot access RandomAccessFile java.io.FileNotFoundException: logs/latest.log (Permission denied) java.io.FileNotFoundException: logs/latest.log (Permission denied)
	
	

	

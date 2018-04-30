# CSCI2461-71.... 
# FINAL PROJECT
# TEAM; CODE BLOCKERS
##### 1. Adam T (Testing) - [Github](https://github.com/Add-man)

##### 2. Fongoh LOKNJINU (Research) - [Github](https://github.com/loknjinu13)

##### 3. Vangx033 (Testing) -[Github](https://github.com/vangx033)

##### 4. Glanel Houenouvi (Documentation) - [Github](https://github.com/grenack)

##### 5. Kasia Lor (Support) - [Github](https://github.com/klor0610)



<div></div>

# Table of contents
1. [Introduction](#Introduction)
2. [Shortcomings](#Shortcomings)
3. [Hardware Platforms](#Hardware)
4. [Protocols & Firewall](#Protocols)
5. [Raspberry Installation](#Rasberry)
6. [SootSplash Installation](#SootSplash)
7. [Difficulties Encountered](#Difficulties)
8. [Screen](#Screen)
9. [Deployment Success](#Deployment)
10. [Updating Server](#Updating)
11. [Recovering Server](#Recovering)
12. [Backing Up Server](#Backing)
13. [Conclusions](#Conclusions)

## Introduction <a name="Introduction"></a>
A Minecraft Server is what our group deployed for our final project in the Networking 3 - Linux class.
There are five members in the group and each one has a special role to work with.
Check out our Github accounts to find out more and see the documentation that goes along with our project.


## Shortcomings <a name="Shortcomings"></a>
	- Mostly online interactions.
	- Some team members dropped.
	- No prior knowledge of the game by remaining team.

## Hardware Platforms <a name="Hardware"></a>
	a. Raspberry Pi 3(Manual steps Installation)
	b. Raspberry Pi 3(Script Assisted Installation)
	c. SootSplash Server 

## Protocols & Firewall <a name="Protocols"></a>
 a. Minecraft is compiled using Java. It will use the Transmission Control Protocol(TCP) of the Internet protocol suite.
This permits the connection between users while playing the game.
The following characteristics describe the TCP;
 + Connection oriented
 + Guaranteed reliable
 + 3-way handshake
 + Connection established between two neighbors
 + A send SYN to B
 + B send SYN ACK to A
 + A send ACK to B

  TCP will use Port 25565 in order to establish connection with users from the server.
 b. SSH : Secure Shell is the protocol used to access any of the servers

 c. Firewall: The server needs to be protected from external access. The following will be added in the iptables.
**`-A INPUT -p tcp -m state --state NEW --dport 25565 -j ACCEPT`**


## Raspberry Installation <a name="Raspberry"></a>


## SootSplash Installation <a name="SootSplash"></a>


## Difficulties Encountered <a name="Difficulties"></a>

When we issued the java build command we encountered this error when the script ran;

_/usr/bin/java: 1: /usr/bin/java: Syntax error: word unexpected (expecting ")")_

**To solve the above we used the open jdk environment as our installation was based on Oracle Java**
To install open jdk the following commands should be used;

`sudo add-apt-repository ppa:openjdk-r/ppa`  
`sudo apt-get update`   
`sudo apt-get install openjdk-8-jdk`

This defines the “PPA for OpenJDK uploads (restricted)” as an additional package repositiory, updates your information, and installs the package with its dependencies (from that repository). 
It should be noted that each time you write a command which has to alter system files **_sudo_** must be used as this is a secured server. This is different from your local server.

 When we ran our server it could not bind to port 25565 as another instance was running
so we did the following;

_`sudo lsof -n -i`_

To kill the process and finally make the server start.
_`sudo fuser -k 25565/tcp`_

This helped me to restart the server. But during class discussions, we noticed we had to work with firewalls.
The _iptables_ proofed that the tcp port 25565 was not listed and had to be added.
The following commands were used;
We applied this rule;
 _`sudo /sbin/iptables -A INPUT -p tcp --dport 25565 -m state --state NEW -j ACCEPT`_

While in class the following command was utilised.

`sudo iptables -A INPUT -p tcp --dport 25565 -m state --state NEW -j ACCEPT`

But there was an additional configuration which was issued and I will present it in my next updates. 

The current issue we face is the fact that once there is a broken pipe, our server cannot restart. This we have to figure out. Likewise i changed the rc.local to launch the minecraft server from startup if the main server reboots. I have not tested this yet!!
I also made installation scripts for [Raspberry](https://github.com/loknjinu13/week14/blob/master/codeblockers.sh) and [Linux](https://github.com/loknjinu13/week14/blob/master/codeblockers1.sh) platforms as there is a hardware difference. 


## Screen <a name="Screen"></a>
#### How we used Screen in our Minecraft Server.
Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.
When a program terminates, _screen_ kills the window that contained it. 

**TMUX** is another full-screen window manager with capabilities like _screen_ and is being developed.
These softwares permit us to continue from wherever we stopped in our terminals.
We installed screen to assist us control our Minecraft Server from its terminal. 
This is why we include screen in the automatic script to run the server once Ubuntu server boots. This permits the Administrator to run the saerver session.
The following command in our _codebminecraft.sh script_ explains it better;
When editing the rc.local file

`sudo nano /etc/rc.local`
add the following into the line before exit 0...

 `screen -dm -S minecraft /opt/scripts/codebminecraft.sh`

Whenever the server is running and you closed the terminal before and will want to check the server,
just run the following command in your session;
`_screen -r_`


## Deployment Success <a name="Deployment"></a>
It has been an educative ride for our team. Doing research and testing was fun but getting into difficulties was more educative as it opened up more venues for research.
** Launch Server**

|Platform	|Boot Directory		|Boot Command			|
|---------------|-----------------------|-------------------------------|
|Rasbian	|cd Startup		|sudo ./minecraft.sh		|
|Ubuntu Server	|cd /opt/scripts	|sudo ./codebminecraft.sh	|

It is essential you create automatic backups. Ensure the location is able to store such backups.
Lets use our installed server as an example. In order to play on this Minecraft server, everyone will need a Mojang account to LOGIN. To obtain an account click [Here](https://minecraft.net/en-us/store/minecraft/#register). Now you have an account... You need the _Minecraft Client_ software to access!!! In your Mojang account, there are links to download for Windows, Linux and MAC users. Choose the client software that matches up with your Operating System.

Once your Client software is launched, Choose **Multiplayer**.
This will lead you to insert the name of the server preferably **Code_B_Minecraft**. 
The server address will be _`167.99.232.136`_.
 **Join The Server** and I will be on alert to Welcome you OnBoard. 
To **_chat_** while in the server, just type **T** on your keyboard.

That's it!

These are pictures of our installation and servers functioning:

Active Servers:

![Active servers](pic/active_servers_userlimit.png)


Pi Server:

![logged_in_pi](pic/logged_in_pi.png)


Pi Server:

![logging_pi](pic/logging_pi.png)


Pi Server:

![disconect_pi](pic/disconect_pi.png)


SootSplash Server:

![logged_in_sootsplash](pic/logged_in_sootsplash.png)


SootSplash Server:

![logged_sootsplash](pic/logged_sootsplash.png)


SootSplash Server:

![Disconnected Sootsplash](pic/disconnect_sootsplash.png)

Both Servers:

![Pi_n_SootSplash](pic/Pi_n_Sootsplash_minecraft.png)

## Updating Server <a name="Updating"></a>

Mojang releases new versions of minecraft server. It is necessary to upgrade the server when necessary.
The following process ;
Login to the server and stop the minecraft server. In the minecraft console type `stop` and hit _enter_.
`cd /opt`
`tar -zcvf minecraft_backup.tar.gz minecraft`
`cd /opt/minecraft`
`wget https://hub.spigotmc.org/jenkins/job/BuildTools/lastSuccessfulBuild/artifact/target/BuildTools.jar -O BuildTools.jar`

Then we rebuild the new  spigot server.
`sudo java -jar Buildtools.jar --rev 1.12.2`

Then update the _minecraft.sh_ startup script to use the latest jar file.
`cd /opt/scripts
`nano minecraft.sh`

Update the command to start the new jar file.
`cd /opt/minecraft/ && java -Xms1024M -Xmx2048M -jar /opt/minecraft/spigot-1.~~12.2~~.jar nogui

Save the file.
Restart the server.

## Recovering Server <a name="Recovering"></a>

It is important to regularly backup your Minecraft server. At times exception errors occur when you log into your minecraft server.
Or many things disappear from the world. The world may have been corrupted for any number of issues such as software problems or disk errors.

With backups available, restore the previous backup with the following;
Delete the existing minecraft folder you created
`cd /opt`
`sudo rm -r -f minecraft`

Copy the previously saved minecraft.tar.gz file to your /opt folder.
Restore your minecraft world by
`tar -zxvf minecraft.tar.gz`

Restart the server and the minecraft server will be successfully restored.

## Backing Up Server <a name="Backing"></a>

To Backup the server, do the following;
login to the server
`cd /opt`
`tar -zcvf minecraft_backup.tar.gz minecraft`
Copy the **minecraft_backup.tar.gz** to a safe location. This file will be used to restore your world when needed.
Do this frequently or use the `cron scheduler` to automate the process at a specified time each day.



## Conclusions <a name="Conclusions"></a>


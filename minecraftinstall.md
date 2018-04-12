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
	at java.io.RandomAccessFile.open0(Native Method)
	at java.io.RandomAccessFile.open(RandomAccessFile.java:316)
	at java.io.RandomAccessFile.<init>(RandomAccessFile.java:243)
	at java.io.RandomAccessFile.<init>(RandomAccessFile.java:124)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$RollingRandomAccessFileManagerFactory.createManager(RollingRandomAccessFileManager.java:180)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$RollingRandomAccessFileManagerFactory.createManager(RollingRandomAccessFileManager.java:156)
	at org.apache.logging.log4j.core.appender.AbstractManager.getManager(AbstractManager.java:112)
	at org.apache.logging.log4j.core.appender.OutputStreamManager.getManager(OutputStreamManager.java:114)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager.getRollingRandomAccessFileManager(RollingRandomAccessFileManager.java:87)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:115)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:52)
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.build(PluginBuilder.java:122)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createPluginObject(AbstractConfiguration.java:952)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:892)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.doConfigure(AbstractConfiguration.java:508)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:232)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:244)
	at org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:545)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:617)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:634)
	at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:229)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:152)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	at org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:551)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:537)
	at net.minecraft.server.v1_12_R1.MinecraftServer.<clinit>(MinecraftServer.java:56)
	at org.bukkit.craftbukkit.Main.main(Main.java:194)

2018-04-12 01:59:31,763 main ERROR Unable to inject fields into builder class for plugin type class org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender, element RollingRandomAccessFile. java.lang.IllegalStateException: ManagerFactory [org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$RollingRandomAccessFileManagerFactory@2362f559] unable to create manager for [logs/latest.log] with data [org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$FactoryData@b2c9a9c]
	at org.apache.logging.log4j.core.appender.AbstractManager.getManager(AbstractManager.java:114)
	at org.apache.logging.log4j.core.appender.OutputStreamManager.getManager(OutputStreamManager.java:114)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager.getRollingRandomAccessFileManager(RollingRandomAccessFileManager.java:87)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:115)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:52)
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.build(PluginBuilder.java:122)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createPluginObject(AbstractConfiguration.java:952)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:892)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.doConfigure(AbstractConfiguration.java:508)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:232)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:244)
	at org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:545)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:617)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:634)
	at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:229)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:152)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	at org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:551)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:537)
	at net.minecraft.server.v1_12_R1.MinecraftServer.<clinit>(MinecraftServer.java:56)
	at org.bukkit.craftbukkit.Main.main(Main.java:194)

2018-04-12 01:59:31,769 main ERROR Unable to invoke factory method in class class org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender for element RollingRandomAccessFile. java.lang.IllegalStateException: No factory method found for class org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.findFactoryMethod(PluginBuilder.java:224)
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.build(PluginBuilder.java:130)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createPluginObject(AbstractConfiguration.java:952)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:892)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.doConfigure(AbstractConfiguration.java:508)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:232)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:244)
	at org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:545)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:617)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:634)
	at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:229)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:152)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	at org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:551)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:537)
	at net.minecraft.server.v1_12_R1.MinecraftServer.<clinit>(MinecraftServer.java:56)
	at org.bukkit.craftbukkit.Main.main(Main.java:194)

2018-04-12 01:59:31,774 main ERROR Null object returned for RollingRandomAccessFile in Appenders.
2018-04-12 01:59:31,782 main ERROR Unable to locate appender "File" for logger config "root"
[01:59:34 INFO]: Starting minecraft server version 1.12.2
[01:59:34 INFO]: Loading properties
[01:59:34 INFO]: Default game type: SURVIVAL
[01:59:34 INFO]: This server is running CraftBukkit version git-Spigot-b6ecf3b-9060bfa (MC: 1.12.2) (Implementing API version 1.12.2-R0.1-SNAPSHOT)
[01:59:34 ERROR]: Could not save bukkit.yml
java.io.FileNotFoundException: bukkit.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.saveConfig(CraftServer.java:285) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.<init>(CraftServer.java:221) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.PlayerList.<init>(PlayerList.java:78) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:14) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 ERROR]: Could not save commands.yml
java.io.FileNotFoundException: commands.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.saveCommandsConfig(CraftServer.java:293) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.<init>(CraftServer.java:228) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.PlayerList.<init>(PlayerList.java:78) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:14) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 ERROR]: Could not save commands.yml
java.io.FileNotFoundException: commands.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.saveCommandsConfig(CraftServer.java:293) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.<init>(CraftServer.java:248) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.PlayerList.<init>(PlayerList.java:78) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:14) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 WARN]: Failed to save user banlist: 
java.io.FileNotFoundException: banned-players.json (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at com.google.common.io.Files.newWriter(Files.java:98) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.JsonList.save(JsonList.java:159) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.y(SourceFile:83) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:26) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 WARN]: Failed to save ip banlist: 
java.io.FileNotFoundException: banned-ips.json (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at com.google.common.io.Files.newWriter(Files.java:98) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.JsonList.save(JsonList.java:159) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.x(SourceFile:75) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:28) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 WARN]: Failed to save operators list: 
java.io.FileNotFoundException: ops.json (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at com.google.common.io.Files.newWriter(Files.java:98) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.JsonList.save(JsonList.java:159) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.C(SourceFile:115) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:31) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 INFO]: Server Ping Player Sample Count: 12
[01:59:34 INFO]: Using 4 threads for Netty based IO
[01:59:34 INFO]: Debug logging is disabled
[01:59:34 ERROR]: Could not save spigot.yml
java.io.FileNotFoundException: spigot.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.spigotmc.SpigotConfig.readOpenJDK 64-Bit Server VM warning: ignoring option MaxPermSize=1024M; support was removed in 8.0
Loading libraries, please wait...
2018-04-12 01:59:31,751 main ERROR Cannot access RandomAccessFile java.io.FileNotFoundException: logs/latest.log (Permission denied) java.io.FileNotFoundException: logs/latest.log (Permission denied)
	at java.io.RandomAccessFile.open0(Native Method)
	at java.io.RandomAccessFile.open(RandomAccessFile.java:316)
	at java.io.RandomAccessFile.<init>(RandomAccessFile.java:243)
	at java.io.RandomAccessFile.<init>(RandomAccessFile.java:124)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$RollingRandomAccessFileManagerFactory.createManager(RollingRandomAccessFileManager.java:180)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$RollingRandomAccessFileManagerFactory.createManager(RollingRandomAccessFileManager.java:156)
	at org.apache.logging.log4j.core.appender.AbstractManager.getManager(AbstractManager.java:112)
	at org.apache.logging.log4j.core.appender.OutputStreamManager.getManager(OutputStreamManager.java:114)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager.getRollingRandomAccessFileManager(RollingRandomAccessFileManager.java:87)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:115)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:52)
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.build(PluginBuilder.java:122)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createPluginObject(AbstractConfiguration.java:952)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:892)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.doConfigure(AbstractConfiguration.java:508)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:232)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:244)
	at org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:545)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:617)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:634)
	at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:229)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:152)
	at org.apache.logging.log4j.corOpenJDK 64-Bit Server VM warning: ignoring option MaxPermSize=1024M; support was removed in 8.0
Loading libraries, please wait...
2018-04-12 01:59:31,751 main ERROR Cannot access RandomAccessFile java.io.FileNotFoundException: logs/latest.log (Permission denied) java.io.FileNotFoundException: logs/latest.log (Permission denied)
	at java.io.RandomAccessFile.open0(Native Method)
	at java.io.RandomAccessFile.open(RandomAccessFile.java:316)
	at java.io.RandomAccessFile.<init>(RandomAccessFile.java:243)
	at java.io.RandomAccessFile.<init>(RandomAccessFile.java:124)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$RollingRandomAccessFileManagerFactory.createManager(RollingRandomAccessFileManager.java:180)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$RollingRandomAccessFileManagerFactory.createManager(RollingRandomAccessFileManager.java:156)
	at org.apache.logging.log4j.core.appender.AbstractManager.getManager(AbstractManager.java:112)
	at org.apache.logging.log4j.core.appender.OutputStreamManager.getManager(OutputStreamManager.java:114)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager.getRollingRandomAccessFileManager(RollingRandomAccessFileManager.java:87)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:115)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:52)
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.build(PluginBuilder.java:122)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createPluginObject(AbstractConfiguration.java:952)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:892)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.doConfigure(AbstractConfiguration.java:508)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:232)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:244)
	at org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:545)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:617)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:634)
	at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:229)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:152)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	at org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:551)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:537)
	at net.minecraft.server.v1_12_R1.MinecraftServer.<clinit>(MinecraftServer.java:56)
	at org.bukkit.craftbukkit.Main.main(Main.java:194)

2018-04-12 01:59:31,763 main ERROR Unable to inject fields into builder class for plugin type class org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender, element RollingRandomAccessFile. java.lang.IllegalStateException: ManagerFactory [org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$RollingRandomAccessFileManagerFactory@2362f559] unable to create manager for [logs/latest.log] with data [org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$FactoryData@b2c9a9c]
	at org.apache.logging.log4j.core.appender.AbstractManager.getManager(AbstractManager.java:114)
	at org.apache.logging.log4j.core.appender.OutputStreamManager.getManager(OutputStreamManager.java:114)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager.getRollingRandomAccessFileManager(RollingRandomAccessFileManager.java:87)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:115)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:52)
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.build(PluginBuilder.java:122)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createPluginObject(AbstractConfiguration.java:952)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:892)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.doConfigure(AbstractConfiguration.java:508)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:232)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:244)
	at org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:545)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:617)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:634)
	at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:229)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:152)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	at org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:551)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:537)
	at net.minecraft.server.v1_12_R1.MinecraftServer.<clinit>(MinecraftServer.java:56)
	at org.bukkit.craftbukkit.Main.main(Main.java:194)

2018-04-12 01:59:31,769 main ERROR Unable to invoke factory method in class class org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender for element RollingRandomAccessFile. java.lang.IllegalStateException: No factory method found for class org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.findFactoryMethod(PluginBuilder.java:224)
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.build(PluginBuilder.java:130)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createPluginObject(AbstractConfiguration.java:952)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:892)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.doConfigure(AbstractConfiguration.java:508)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:232)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:244)
	at org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:545)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:617)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:634)
	at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:229)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:152)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	at org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:551)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:537)
	at net.minecraft.server.v1_12_R1.MinecraftServer.<clinit>(MinecraftServer.java:56)
	at org.bukkit.craftbukkit.Main.main(Main.java:194)

2018-04-12 01:59:31,774 main ERROR Null object returned for RollingRandomAccessFile in Appenders.
2018-04-12 01:59:31,782 main ERROR Unable to locate appender "File" for logger config "root"
[01:59:34 INFO]: Starting minecraft server version 1.12.2
[01:59:34 INFO]: Loading properties
[01:59:34 INFO]: Default game type: SURVIVAL
[01:59:34 INFO]: This server is running CraftBukkit version git-Spigot-b6ecf3b-9060bfa (MC: 1.12.2) (Implementing API version 1.12.2-R0.1-SNAPSHOT)
[01:59:34 ERROR]: Could not save bukkit.yml
java.io.FileNotFoundException: bukkit.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.saveConfig(CraftServer.java:285) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.<init>(CraftServer.java:221) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.PlayerList.<init>(PlayerList.java:78) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:14) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 ERROR]: Could not save commands.yml
java.io.FileNotFoundException: commands.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.saveCommandsConfig(CraftServer.java:293) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.<init>(CraftServer.java:228) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.PlayerList.<init>(PlayerList.java:78) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:14) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 ERROR]: Could not save commands.yml
java.io.FileNotFoundException: commands.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.saveCommandsConfig(CraftServer.java:293) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.<init>(CraftServer.java:248) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.PlayerList.<init>(PlayerList.java:78) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:14) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 WARN]: Failed to save user banlist: 
java.io.FileNotFoundException: banned-players.json (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at com.google.common.io.Files.newWriter(Files.java:98) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.JsonList.save(JsonList.java:159) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.y(SourceFile:83) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:26) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 WARN]: Failed to save ip banlist: 
java.io.FileNotFoundException: banned-ips.json (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at com.google.common.io.Files.newWriter(Files.java:98) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.JsonList.save(JsonList.java:159) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.x(SourceFile:75) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:28) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 WARN]: Failed to save operators list: 
java.io.FileNotFoundException: ops.json (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at com.google.common.io.Files.newWriter(Files.java:98) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.JsonList.save(JsonList.java:159) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.C(SourceFile:115) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:31) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 INFO]: Server Ping Player Sample Count: 12
[01:59:34 INFO]: Using 4 threads for Netty based IO
[01:59:34 INFO]: Debug logging is disabled
[01:59:34 ERROR]: Could not save spigot.yml
java.io.FileNotFoundException: spigot.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.spigotmc.SpigotConfig.readConfig(SpigotConfig.java:124) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.spigotmc.SpigotConfig.init(SpigotConfig.java:76) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:184) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 INFO]: Generating keypair
[01:59:35 INFO]: Starting Minecraft server on *:25565
[01:59:35 INFO]: Using epoll channel type
[01:59:35 WARN]: **** FAILED TO BIND TO PORT!
[01:59:35 WARN]: The exception was: io.netty.channel.unix.Errors$NativeIoException: bind(..) failed: Address already in use
[01:59:35 WARN]: Perhaps a server is already running on that port?
[01:59:35 INFO]: Stopping server
[01:59:35 INFO]: Saving players
e.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	at org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:551)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:537)
	at net.minecraft.server.v1_12_R1.MinecraftServer.<clinit>(MinecraftServer.java:56)
	at org.bukkit.craftbukkit.Main.main(Main.java:194)

2018-04-12 01:59:31,763 main ERROR Unable to inject fields into builder class for plugin type class org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender, element RollingRandomAccessFile. java.lang.IllegalStateException: ManagerFactory [org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$RollingRandomAccessFileManagerFactory@2362f559] unable to create manager for [logs/latest.log] with data [org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager$FactoryData@b2c9a9c]
	at org.apache.logging.log4j.core.appender.AbstractManager.getManager(AbstractManager.java:114)
	at org.apache.logging.log4j.core.appender.OutputStreamManager.getManager(OutputStreamManager.java:114)
	at org.apache.logging.log4j.core.appender.rolling.RollingRandomAccessFileManager.getRollingRandomAccessFileManager(RollingRandomAccessFileManager.java:87)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:115)
	at org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender$Builder.build(RollingRandomAccessFileAppender.java:52)
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.build(PluginBuilder.java:122)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createPluginObject(AbstractConfiguration.java:952)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:892)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.doConfigure(AbstractConfiguration.java:508)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:232)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:244)
	at org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:545)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:617)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:634)
	at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:229)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:152)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	at org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:551)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:537)
	at net.minecraft.server.v1_12_R1.MinecraftServer.<clinit>(MinecraftServer.java:56)
	at org.bukkit.craftbukkit.Main.main(Main.java:194)

2018-04-12 01:59:31,769 main ERROR Unable to invoke factory method in class class org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender for element RollingRandomAccessFile. java.lang.IllegalStateException: No factory method found for class org.apache.logging.log4j.core.appender.RollingRandomAccessFileAppender
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.findFactoryMethod(PluginBuilder.java:224)
	at org.apache.logging.log4j.core.config.plugins.util.PluginBuilder.build(PluginBuilder.java:130)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createPluginObject(AbstractConfiguration.java:952)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:892)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.createConfiguration(AbstractConfiguration.java:884)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.doConfigure(AbstractConfiguration.java:508)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.initialize(AbstractConfiguration.java:232)
	at org.apache.logging.log4j.core.config.AbstractConfiguration.start(AbstractConfiguration.java:244)
	at org.apache.logging.log4j.core.LoggerContext.setConfiguration(LoggerContext.java:545)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:617)
	at org.apache.logging.log4j.core.LoggerContext.reconfigure(LoggerContext.java:634)
	at org.apache.logging.log4j.core.LoggerContext.start(LoggerContext.java:229)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:152)
	at org.apache.logging.log4j.core.impl.Log4jContextFactory.getContext(Log4jContextFactory.java:45)
	at org.apache.logging.log4j.LogManager.getContext(LogManager.java:194)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:551)
	at org.apache.logging.log4j.LogManager.getLogger(LogManager.java:537)
	at net.minecraft.server.v1_12_R1.MinecraftServer.<clinit>(MinecraftServer.java:56)
	at org.bukkit.craftbukkit.Main.main(Main.java:194)

2018-04-12 01:59:31,774 main ERROR Null object returned for RollingRandomAccessFile in Appenders.
2018-04-12 01:59:31,782 main ERROR Unable to locate appender "File" for logger config "root"
[01:59:34 INFO]: Starting minecraft server version 1.12.2
[01:59:34 INFO]: Loading properties
[01:59:34 INFO]: Default game type: SURVIVAL
[01:59:34 INFO]: This server is running CraftBukkit version git-Spigot-b6ecf3b-9060bfa (MC: 1.12.2) (Implementing API version 1.12.2-R0.1-SNAPSHOT)
[01:59:34 ERROR]: Could not save bukkit.yml
java.io.FileNotFoundException: bukkit.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.saveConfig(CraftServer.java:285) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.<init>(CraftServer.java:221) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.PlayerList.<init>(PlayerList.java:78) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:14) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 ERROR]: Could not save commands.yml
java.io.FileNotFoundException: commands.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.saveCommandsConfig(CraftServer.java:293) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.<init>(CraftServer.java:228) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.PlayerList.<init>(PlayerList.java:78) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:14) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 ERROR]: Could not save commands.yml
java.io.FileNotFoundException: commands.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.saveCommandsConfig(CraftServer.java:293) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.bukkit.craftbukkit.v1_12_R1.CraftServer.<init>(CraftServer.java:248) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.PlayerList.<init>(PlayerList.java:78) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:14) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 WARN]: Failed to save user banlist: 
java.io.FileNotFoundException: banned-players.json (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at com.google.common.io.Files.newWriter(Files.java:98) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.JsonList.save(JsonList.java:159) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.y(SourceFile:83) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:26) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 WARN]: Failed to save ip banlist: 
java.io.FileNotFoundException: banned-ips.json (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at com.google.common.io.Files.newWriter(Files.java:98) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.JsonList.save(JsonList.java:159) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.x(SourceFile:75) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:28) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 WARN]: Failed to save operators list: 
java.io.FileNotFoundException: ops.json (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at com.google.common.io.Files.newWriter(Files.java:98) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.JsonList.save(JsonList.java:159) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.C(SourceFile:115) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedPlayerList.<init>(SourceFile:31) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:183) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 INFO]: Server Ping Player Sample Count: 12
[01:59:34 INFO]: Using 4 threads for Netty based IO
[01:59:34 INFO]: Debug logging is disabled
[01:59:34 ERROR]: Could not save spigot.yml
java.io.FileNotFoundException: spigot.yml (Permission denied)
	at java.io.FileOutputStream.open0(Native Method) ~[?:1.8.0_162]
	at java.io.FileOutputStream.open(FileOutputStream.java:270) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:213) ~[?:1.8.0_162]
	at java.io.FileOutputStream.<init>(FileOutputStream.java:162) ~[?:1.8.0_162]
	at org.bukkit.configuration.file.FileConfiguration.save(FileConfiguration.java:70) ~[spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.spigotmc.SpigotConfig.readConfig(SpigotConfig.java:124) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.spigotmc.SpigotConfig.init(SpigotConfig.java:76) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:184) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 INFO]: Generating keypair
[01:59:35 INFO]: Starting Minecraft server on *:25565
[01:59:35 INFO]: Using epoll channel type
[01:59:35 WARN]: **** FAILED TO BIND TO PORT!
[01:59:35 WARN]: The exception was: io.netty.channel.unix.Errors$NativeIoException: bind(..) failed: Address already in use
[01:59:35 WARN]: Perhaps a server is already running on that port?
[01:59:35 INFO]: Stopping server
[01:59:35 INFO]: Saving players
Config(SpigotConfig.java:124) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at org.spigotmc.SpigotConfig.init(SpigotConfig.java:76) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.DedicatedServer.init(DedicatedServer.java:184) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at net.minecraft.server.v1_12_R1.MinecraftServer.run(MinecraftServer.java:545) [spigot.jar:git-Spigot-b6ecf3b-9060bfa]
	at java.lang.Thread.run(Thread.java:748) [?:1.8.0_162]
[01:59:34 INFO]: Generating keypair
[01:59:35 INFO]: Starting Minecraft server on *:25565
[01:59:35 INFO]: Using epoll channel type
[01:59:35 WARN]: **** FAILED TO BIND TO PORT!
[01:59:35 WARN]: The exception was: io.netty.channel.unix.Errors$NativeIoException: bind(..) failed: Address already in use
[01:59:35 WARN]: Perhaps a server is already running on that port?
[01:59:35 INFO]: Stopping server
[01:59:35 INFO]: Saving players


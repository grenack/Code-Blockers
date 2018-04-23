# Team Contribution

 Our last deployment process was qausi successful as we got the minecraft server running.
Nevertheless, we could not access the server nor make the server boot on startup.

The following step by step process in installing the [raspberry](https://github.com/loknjinu13/week14/blob/master/raspberry.md) was created.

## Difficulties In Installation on Sootsplash
When i issued the java build command i encountered this error when my script ran;

_/usr/bin/java: 1: /usr/bin/java: Syntax error: word unexpected (expecting ")")_

**To solve the above i used the open jdk environmen as our installation was based on Oracle Java**

It should be noted that each time you write a command which has to alter system files _sudo_ must be used as this is a secured server. This is different from your local server.

 When i ran my server it could not bind to port 25565 as another instance was running
so i did the following;
_sudo lsof -n -i_

To kiil the process and finally make the server start.
_sudo fuser -k 25565/tcp_

This helped me to restart the server. But during class discussions, we noticed we had to work with firewalls.
The _iptables_ proofed that the tcp port 25565 was not listed and had to be added.
The following commands were used;
We applied this rule; _sudo /sbin/iptables -A INPUT -p tcp --dport 25565 -m state --state NEW -j ACCEPT_
While in class the following command was utilised.
sudo iptables -A INPUT -p tcp --dport 25565 -m state --state NEW -j ACCEPT
But there was an additional configuration which was issued and I will present it in my next updates. 

The current issue we face is the fact that once there is a broken pipe, our server cannot restart. This we have to figure out. Likewise i changed the rc.local to launch the minecraft server from startup if the main server reboots. I have not tested this yet!!
I also made installation scripts for [Raspberry](https://github.com/loknjinu13/week14/blob/master/codeblockers.sh) and [Linux](https://github.com/loknjinu13/week14/blob/master/codeblockers1.sh) platforms as there is a hardware difference. 

More updates will be made as i test other platforms and check out errors.

What needs to be done;
- Make our Server Known for others to use
- Give installation instructions or minecraft client software for use by others in both windows and linux platforms.
- Monitor the server while users are active.
- Check on how to resolve a crashed session.

Thanks!!! 

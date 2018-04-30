#Screen
## How we used Screen in our Minecraft Server.
Screen is a full-screen window manager that multiplexes a physical terminal between several processes, typically interactive shells.
When a program terminates, _screen_ kills teh window that contained it. 

**TMUX** is another full-screen window manager with capabilities like _screen_ and is being developed.
These softwares permit us to continue from wherever we stopped in our terminals.
We installed screen to assist us control our Minecraft Server from its terminal. 
This is why we include screen in the automatic script to run the server once Ubuntu server boots. This permits the Administrator to run the saerver session.
The following command in our _codebminecraft.sh script_explains it better;
When editing the rc.local file
sudo nano /etc/rc.local
add the foolowing into the line before exit 0...
 screen -dm -S minecraft /opt/scripts/codebminecraft.sh 

Whenever the server is running and you closed theterminal before and will want to check the server,
just run the following command in your session;
_screen -r_


 

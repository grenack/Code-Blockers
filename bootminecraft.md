#How to Restart Server
Hello Team CodeBlockers.
I realised the minecraft service fails after awhile, while we report tis to the ADMIN,
we should do the following to keep the service alive;
1. Login into your SootSplash account
2. sudo lsof -n -i
3. sudo fuser -k 25565/tcp
4. cd /opt
5. cd scripts
6. screen
WHEN SCREEN LAUNCES JUST ACCEPT BY USING THE _RETURN_. 
7. sudo ./codebminecraft.sh

Once the script is launched, the server will boot up

THANKS TEAM

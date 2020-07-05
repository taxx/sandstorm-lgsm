#!/bin/bash

if [ ! "$(id -u sandstorm)" -eq "$UID" ]; then 
	echo "Changing sandstorm uid to $UID."
	usermod -o -u "$UID" sandstorm ; 
fi
# Change gid if needed
if [ ! "$(id -g sandstorm)" -eq "$GID" ]; then 
	echo "Changing sandstorm gid to $GID."
	groupmod -o -g "$GID" sandstorm ; 
fi

# Put sandstorm owner of directories (if the uid changed, then it's needed)
chown -R sandstorm:sandstorm /sandstorm /home/sandstorm

# avoid error message when su -p (we need to read the /root/.bash_rc )
chmod -R 777 /root/

# Launch run.sh with user sandstorm (-p allow to keep env variables)
su -p sandstorm -c /home/sandstorm/run.sh
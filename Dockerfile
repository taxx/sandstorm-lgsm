FROM debian:buster-slim

LABEL maintainer taxx

# Server PORT (you can't remap with docker, it doesn't work)
ENV SERVERPORT 27015
# RCON PORT (you can't remap with docker, it doesn't work)
ENV QUERYPORT 27016
#ENV RCONPORT 32330
# Steam port (you can't remap with docker, it doesn't work)
#ENV STEAMPORT 7778

# UID of the user steam
ENV UID 1000
# GID of the user steam
ENV GID 1000

# Install dependencies 
RUN dpkg --add-architecture i386
RUN apt update && \ 
    apt install -y mailutils postfix curl wget file tar \
	bzip2 gzip unzip bsdmainutils python util-linux \
	ca-certificates binutils bc jq tmux netcat lib32gcc1 \
	lib32stdc++6 cron iproute2 procps
	# sudo

# Enable passwordless sudo for users under the "sudo" group
#RUN sed -i.bkp -e \
#	's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers \
#	/etc/sudoers

# Run commands as the steam user
RUN adduser \ 
	--disabled-login \ 
	--shell /bin/bash \ 
	--gecos "" \ 
	sandstorm
# Add to sudo group
#RUN usermod -a -G sudo sandstorm

# Copy & rights to folders
COPY run.sh /home/sandstorm/run.sh
COPY user.sh /home/sandstorm/user.sh
#COPY crontab /home/steam/crontab
#COPY arkmanager-user.cfg /home/steam/arkmanager.cfg

# Switch from windows to linux file line endings
RUN sed -i -e 's/\r$//' /home/sandstorm/*.sh
# && \
#    sed -i -e 's/\r$//' /home/steam/crontab && \
#    sed -i -e 's/\r$//' /home/steam/*.cfg
#
RUN touch /root/.bash_profile & \
    chmod 777 /home/sandstorm/run.sh & \
    mkdir /sandstorm

WORKDIR /sandstorm/
#USER sandstorm

# Switch from windows to linux file line endings
#RUN sed -i -e 's/\r$//' /etc/arkmanager/*.cfg
#RUN sed -i -e 's/\r$//' /etc/arkmanager/instances/*.cfg

#RUN chown steam -R /ark && chmod 755 -R /ark

#EXPOSE ${SERVERPORT} ${QUERYPORT} 
# Add UDP
EXPOSE ${SERVERPORT}/udp ${QUERYPORT}/udp

VOLUME  /sandstorm

# Change the working directory to /arkd
WORKDIR /sandstorm

# Update game launch the game.
ENTRYPOINT ["/home/sandstorm/user.sh"]

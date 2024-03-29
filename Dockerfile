FROM debian:bookworm-slim

LABEL maintainer taxx

# Server PORT (you can't remap with docker, it doesn't work)
ENV SERVERPORT 27015
# Query PORT (you can't remap with docker, it doesn't work)
ENV QUERYPORT 27016

# UID of the user steam
ENV UID 1000
# GID of the user steam
ENV GID 1000

# Install dependencies 
RUN dpkg --add-architecture i386 && \
    apt update && \ 
    apt install -y mailutils postfix curl wget file tar \
	bzip2 gzip unzip bsdmainutils python3 util-linux \
	ca-certificates binutils bc jq tmux \
	cron iproute2 procps \
	netcat-openbsd uuid-runtime \
	xz-utils distro-info \
	lib32gcc-s1 lib32stdc++6 libsdl2-2.0-0:i386 \
	netcat-openbsd uuid-runtime xz-utils

# Run commands as the steam user
RUN adduser \ 
	--disabled-login \ 
	--shell /bin/bash \ 
	--gecos "" \ 
	sandstorm

# Copy & rights to folders
COPY run.sh /home/sandstorm/run.sh
COPY user.sh /home/sandstorm/user.sh

# Set executable flags
RUN chmod +x /home/sandstorm/*.sh

# Switch from windows to linux file line endings
RUN sed -i -e 's/\r$//' /home/sandstorm/*.sh

RUN touch /root/.bash_profile & \
    chmod 777 /home/sandstorm/run.sh & \
    mkdir /sandstorm

WORKDIR /sandstorm/

EXPOSE ${SERVERPORT}/udp ${QUERYPORT}/udp

VOLUME  /sandstorm

# Change the working directory to /sandstorm
WORKDIR /sandstorm

ENTRYPOINT ["/home/sandstorm/user.sh"]

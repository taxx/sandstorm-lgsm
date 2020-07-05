#!/bin/bash
echo "###########################################################################"
echo "# Sandstorm Server - " `date`
echo "# UID $UID - GID $GID"
echo "###########################################################################"
[ -p /tmp/FIFO ] && rm /tmp/FIFO
mkfifo /tmp/FIFO

export TERM=linux

cd /sandstorm

if [ ! -f inssserver ]; then 
   # First launch
   wget -O linuxgsm.sh https://linuxgsm.sh && chmod +x linuxgsm.sh && bash linuxgsm.sh inssserver
   ./inssserver auto-install
else
   ./inssserver update-lgsm
   ./inssserver update
fi

./inssserver start

# Stop server in case of signal INT or TERM
echo "Waiting..."
trap stop INT
trap stop TERM

read < /tmp/FIFO &
wait
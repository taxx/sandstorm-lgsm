# Insurgency Sandstorm using LGSM - Docker
First start will take a while since it downloads LSGM and then the game files.  
Will check for updated versions of LSGM and game files at at every start.

### Some notes on networking
UDP ports are all that are used for game and query ports.  
It needs to be consistent all the way from docker container, config file (inssserver.cfg) to firewall openings/port forwards.  
_All samples are without RCON exposed externally._

## Volume redirection
Redirect whole folder to get persitance on game files + config files.  
Docker folder: /sandstorm  : Contains all config files and game binaries

## Files of interest
```bash
# Config file to specify name and ports etc.
/sandstorm/lgsm/config-lgsm/inssserver/inssserver.cfg

# Admin, bans and mapcycle
/sandstorm/serverfiles/Insurgency/Config/Server/
   (Admins.txt, Bans.json, MapCycle.txt)

# Server rules (Good place to start: https://github.com/zWolfi/INS_Sandstorm)
/sandstorm/serverfiles/Insurgency/Saved/Config/LinuxServer/
   (Game.ini, GameUserSettings.ini)
```

## Running live
See docker-compose.yml for Docker Compose sample:

Docker:
```bash
docker run -p 27103:27103/udp -p 27132:27132/udp \
      -e SERVERPORT=27103 \
      -e QUERYPORT=27132 \
      -v /my/local/path/to/sandstorm/:/sandstorm \
      --name sandstorm taxx/ark-server \
```

## Development / testing
```bash
# build image
docker build -t taxx/sandstorm-lgsm .

# run
docker run -p 27103:27103/udp -p 27132:27132/udp --name sandstorm taxx/sandstorm-lgsm
```

## Links
Please use [Github](https://github.com/taxx/sandstorm-lgsm) issue system.  
Link to image on [Docker hub](https://github.com/taxx/sandstorm-lgsm).


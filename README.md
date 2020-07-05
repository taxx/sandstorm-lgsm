# Insurgency Sandstorm using LGSM - Docker

First start will take a while since it downloads LSGM and then the game files.
Will check for updated versions of LSGM and game files at at every start.

## Development / testing
```bash
# build image
docker build -t taxx/sandstorm-lgsm .

# run
docker run -p 27015:27015/udp -p 27017:27017/udp -e SERVERPORT=27015 -e QUERYPORT=27017 --name sandstorm taxx/ark-server

# push image
docker push taxx/sandstorm-lgsm
```

## Volume redirection
Redirect whole folder to get persitance on game files + config files.
Docker folder: /sandstorm  : Contains all config files and game binaries

## Other files of interest
/sandstorm/lgsm/config-lgsm/inssserver/inssserver.cfg
/sandstorm/serverfiles/Insurgency/Config/Server/
   Admins.txt, Bans.json, MapCycle.txt
/sandstorm/serverfiles/Insurgency/Saved/Config/LinuxServer/
   Game.ini, GameUserSettings.ini

## Running live
See docker-compose.yml for Docker Compose sample:

Docker:
```bash
docker run -p 27015:27015/udp -p 27017:27017/udp -e SERVERPORT=27015 -e QUERYPORT=27017 \
       -v /my/local/path/to/sandstorm/:/sandstorm
       --name sandstorm taxx/ark-server
```
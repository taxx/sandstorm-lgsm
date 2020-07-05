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

### Interesting files to redirect
/lgsm/config-lgsm/inssserver/inssserver.cfg

### Folders
/sandstorm/serverfiles/Insurgency/Config/Server
(Files in this folder includes (for example): Admins.txt, Bans.json, MapCycle.txt))

/sandstorm/serverfiles/Insurgency/Saved/Config/LinuxServer/
(Game.ini, GameUserSettings.ini)

_(Redirect entire folders)_

## Running live
See docker-compose.yml for Docker Compose sample:

Docker:
```bash
docker run -p 27015:27015/udp -p 27017:27017/udp -e SERVERPORT=27015 -e QUERYPORT=27017 \
       -v /my/path/to/sandstorm/insserver.cfg:/lgsm/config-lgsm/inssserver/inssserver.cfg
       -v /my/path/to/sandstorm:/sandstorm/serverfiles/Insurgency/Saved/Config/LinuxServer
       -v /my/path/to/sandstorm:/sandstorm/serverfiles/Insurgency/Config/Server
       --name sandstorm taxx/ark-server
```


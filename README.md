# Based on [linuxserver/smokeping](https://github.com/linuxserver/docker-smokeping)

### docker create

* Replace SMOKEPINGHOSTNAME and SECRET with your own credentials for the master.
* Replace </path/to/smokeping> with the path to your cache,data, and config folders.
* You can optionally replace the container name in case you want to run multiple containers on the same system.

```
> mkdir -p </path/to/smokeping>/{cache,config,data}
> docker create \
    --name=smokeping-slave \
    -h SMOKEPINGHOSTNAME \
    -e SLAVE_SECRET=SECRET \
    -e MASTER_URL=https://smokeping.example.com/cgi-bin/smokeping.cgi \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=America/Chicago \
    -v </path/to/smokeping>/cache:/cache \
    -v </path/to/smokeping>/config:/config \
    -v </path/to/smokeping>/data:/data \
    --restart unless-stopped \
    cullorblind/smokeping-slave:latest
> docker start smokeping-slave
```

### docker-compose

* Replace SMOKEPINGHOSTNAME and SECRET with your own credentials for the master.
* Replace </path/to/smokeping> with the path to your cache,data, and config folders.
* You can optionally replace the container name in case you want to run multiple containers on the same system.

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  smokeping:
    image: cullorblind/smokeping-slave
    container_name: smokeping-slave
    hostname: SMOKEPINGHOSTNAME
    environment:
      - SLAVE_SECRET=SECRET
      - MASTER_URL=https://smokeping.example.com/cgi-bin/smokeping.cgi
      - PUID=1000
      - PGID=1000
      - TZ=America/Chicago
    volumes:
      - </path/to/smokeping>/cache:/cache
      - </path/to/smokeping>/config:/config
      - </path/to/smokeping>/data:/data
    restart: unless-stopped
```

## Support Info

* Shell access whilst the container is running: `docker exec -it smokeping /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f smokeping-slave`

## Updating Info

### Via Docker Run/Create
* Update the image: `docker pull cullorblind/smokeping-slave`
* Stop the running container: `docker stop smokeping-slave`
* Delete the container: `docker rm smokeping-slave`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start smokeping-slave`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull cullorblind/smokeping-slave`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d cullorblind/smokeping-slave`
* You can also remove the old dangling images: `docker image prune`
* You can stop/remove all related containers: `docker-compose down`

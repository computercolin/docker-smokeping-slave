# Based on [linuxserver/smokeping](https://github.com/linuxserver/docker-smokeping)

### docker create (replace NAME and SECRET with your own items)

```
> mkdir -p </path/to/smokeping>/{cache,config,data}
> docker create \
    --name=CONTAINERNAME \
    -h SMOKEHOSTNAME \
    -e SLAVE_SECRET=SECRET \
    -e MASTER_URL=https://smokeping.example.com/smokeping.cgi \
    -e PUID=1000 \
    -e PGID=1000 \
    -e TZ=America/Chicago \
    -v </path/to/smokeping>/cache:/cache \
    -v </path/to/smokeping>/config:/config \
    -v </path/to/smokeping>/data:/data \
    --restart unless-stopped \
    cullorblind/smokeping-slave:latest
> docker start CONTAINERNAME
```

### docker-compose

Compatible with docker-compose v2 schemas.

```
---
version: "2"
services:
  smokeping:
    image: cullorblind/smokeping-slave
    container_name: CONTAINERNAME
    hostname: SMOKEHOSTNAME
    environment:
      - SLAVE_SECRET=SECRET
      - MASTER_URL=https://smokeping.example.com/smokeping.cgi
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
* container version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' CONTAINERNAME`
* image version number
  * `docker inspect -f '{{ index .Config.Labels "build_version" }}' cullorblind/smokeping-slave`

## Updating Info

### Via Docker Run/Create
* Update the image: `docker pull cullorblind/smokeping-slave`
* Stop the running container: `docker stop CONTAINERNAME`
* Delete the container: `docker rm CONTAINERNAME`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start CONTAINERNAME`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull cullorblind/smokeping-slave`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d cullorblind/smokeping-slave`
* You can also remove the old dangling images: `docker image prune`

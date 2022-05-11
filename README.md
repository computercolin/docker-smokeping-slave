## Based on [cullorblind/smokeping](https://github.com/cullorblind/docker-smokeping-slave) based on [linuxserver/smokeping](https://github.com/linuxserver/docker-smokeping)

* Based on Smokeping 2.7.3
* Includes patch to Smokeping [PR-181](https://github.com/oetiker/SmokePing/pull/181) -- allows Slave to correctly poll targets after master targets config changes

### Build and run locally
You can use the below commands to run with docker / docker-compose, pulling from docker hub.
Or if you prefer, use the included `build.sh` script and run without pulling from docker hub.

### docker create

* Replace SMOKEPINGHOSTNAME and SECRET with your own credentials for the master.
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
    --restart unless-stopped \
    --log-driver local \
    --log-opt max-size=40m \
    --log-opt max-file=5 \
    computercolin/smokeping-slave:latest
> docker start smokeping-slave
```

### docker-compose

* `cp .env.example .env`
* Fill in HOSTNAME, SLAVE_SECRET, MASTER_URL, and TIMEZONE with your parameters
* `docker-compose up`
* Refer to included `docker-compose.yml` for more

## Support Info

* Shell access whilst the container is running: `docker exec -it smokeping-slave /bin/bash`
* To monitor the logs of the container in realtime: `docker logs -f smokeping-slave`

## Updating Info

### Via Docker Run/Create
* Update the image: `docker pull computercolin/smokeping-slave`
* Stop the running container: `docker stop smokeping-slave`
* Delete the container: `docker rm smokeping-slave`
* Recreate a new container with the same docker create parameters as instructed above (if mapped correctly to a host folder, your `/config` folder and settings will be preserved)
* Start the new container: `docker start smokeping-slave`
* You can also remove the old dangling images: `docker image prune`

### Via Docker Compose
* Update all images: `docker-compose pull`
  * or update a single image: `docker-compose pull computercolin/smokeping-slave`
* Let compose update all containers as necessary: `docker-compose up -d`
  * or update a single container: `docker-compose up -d computercolin/smokeping-slave`
* You can also remove the old dangling images: `docker image prune`
* You can stop/remove all related containers: `docker-compose down`

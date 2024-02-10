# FritzBox Internet Connectivity Monitor
Safeguard against FritzBox losing internet connectivity.
The container checks daily at 02:00 if api.ipify.org returns a valid public IP. If this is not the case, it will reboot the FritzBox to attempt to restore the connection.

**Note:** This project is mostly to play around with docker images on the DSM, a simple cron job would work just as well.

## Build status
  [![Docker](https://github.com/ChrisMKV/fritzboxmonitor/actions/workflows/docker-publish.yml/badge.svg)](https://github.com/ChrisMKV/fritzboxmonitor/actions/workflows/docker-publish.yml)

## How to build the image
**Work in progress:** Set up automatic build pipeline.

### Manual build steps
Upload these files to DSM into /volume2/docker/_build:
- Dockerfile
- fritzboxmonitor.sh

Then, ssh to `/volume2/docker/_build` and run:
```sh
docker build . -t chrismkv/fritzboxmonitor
```
The image *fritzboxmonitor* will be created.

### Automatic build & publish
(In progress)

On the Syno, register ghcr.io as repository (Only needed once, can't use the GUI in Container Manager):
````
export CR_PAT=(MyPAT)
echo $CR_PAT | docker login ghcr.io -u ChrisMKV --password-stdin
`````

Next, tag the image for upload to ghcr.io. If it was build manually before, it'll appear twice with the different tags.
````
docker tag chrismkv/fritzboxmonitor ghcr.io/chrismkv/fritzboxmonitor:latest
`````

Push the image to ghcr.io:
````
docker push ghcr.io/chrismkv/fritzboxmonitor:latest
`````

The package now appears on: https://github.com/ChrisMKV?tab=packages

By adding ````LABEL org.opencontainers.image.source https://github.com/ChrisMKV/fritzboxmonitor```` into the Dockerfile the package is automatically linked to the repo.

The image can now be manually pulled from the repo with ````docker pull ghcr.io/chrismkv/fritzboxmonitor:latest```` or automatically with the updated compose file.


## How to run the container
Use the *docker-compose.yml* file as a template for the DSM Docker Project. Update FritzBox details as required, then deploy the project.

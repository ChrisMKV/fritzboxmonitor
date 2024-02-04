# FritzBox Internet Connectivity Monitor
Safeguard against FritzBox losing internet connectivity.
The container checks daily at 02:00 if api.ipify.org returns a valid public IP. If this is not the case, it will reboot the FritzBox to attempt to restore the connection.

**Note:** This project is mostly to play around with docker images on the DSM, a simple cron job would work just as well.

## How to build the image
**To do:** Try to set up automated build locally on the syno.

Upload these files to DSM into /volume2/docker/_build:
- Dockerfile
- fritzboxmonitor.sh

Then, ssh to `/volume2/docker/_build` and run:
```sh
sudo docker build . -t chrismkv/fritzboxmonitor
```
The image *fritzboxmonitor* will be created.

## How to run the container
Use the *docker-compose.yml* file as a template for the DSM Docker Project. Update FritzBox details as required, then deploy the project.
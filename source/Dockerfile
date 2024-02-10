# Dockerfile to create image with cron services
FROM alpine:latest

# Link repository to package
LABEL org.opencontainers.image.source https://github.com/ChrisMKV/fritzboxmonitor
LABEL org.opencontainers.image.description For private use only.

# Set environment variables
ENV FRITZBOX_IP=192.168.0.1
ENV FRITZBOX_USER=FritzUserPlaceholder
ENV FRITZBOX_PASSWORD=FritzPassPlaceholder

# Add curl
RUN apk update \
	&& apk add curl

# Add the script to the Docker Image and grant exec rights
ADD fritzboxmonitor.sh /root/fritzboxmonitor.sh
RUN chmod 0644 /root/fritzboxmonitor.sh

# Generate crontab file (Daily 2 am)
RUN touch crontab.tmp \
    && echo '0 2 * * * sh /root/fritzboxmonitor.sh' > crontab.tmp \
    && crontab crontab.tmp \
    && rm -rf crontab.tmp

# Run cron in foreground and redirect output
CMD ["/usr/sbin/crond", "-f", "-L", "/dev/stdout"]

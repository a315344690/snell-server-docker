FROM debian:stable-slim

WORKDIR /root
COPY ./config.conf /root/congfig.conf
COPY ./snell-server /usr/bin/snell-server

RUN chmod +x /usr/bin/snell-server
    
# ENTRYPOINT ["/root/snell.sh"]

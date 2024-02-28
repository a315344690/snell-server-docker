FROM debian:stable-slim

WORKDIR /root
COPY ./snell.sh /root/snell.sh
COPY ./snell-server /usr/bin/snell-server

RUN chmod +x /root/snell.sh && \
    chmod +x /usr/bin/snell-server
    
ENTRYPOINT ["/root/snell.sh"]

ARG ARCH=

FROM ${ARCH}alpine:latest

WORKDIR /root
COPY ./snell.sh /root/snell.sh
COPY ./snell-server /usr/bin/snell-server

RUN apk update && apk gcc git libc-dev openssh-client && \
    chmod +x /root/snell.sh && \
    chmod +x /usr/bin/snell-server
    
ENTRYPOINT ["/root/snell.sh"]

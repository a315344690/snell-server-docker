FROM alpine

ARG TARGETPLATFORM
ARG SNELL_SERVER_VERSION=4.0.1

RUN apk add --no-cache wget unzip  && \
    echo 'https://storage.sev.monster/alpine/edge/testing' | tee -a /etc/apk/repositories && \
    wget https://storage.sev.monster/alpine/edge/testing/x86_64/sevmonster-keys-1-r0.apk && \
    apk add --allow-untrusted ./sevmonster-keys-1-r0.apk && \
    apk update && \
    apk add --no-cache gcompat libstdc++ && \
    rm /lib/ld-linux-x86-64.so.2 && \
    apk add --no-cache --force-overwrite glibc && \
    apk add --no-cache glibc-bin && \
    rm ./sevmonster-keys-1-r0.apk
    
WORKDIR /root
COPY ./config.conf /root/config.conf
COPY ./snell-server /usr/bin/snell-server

RUN chmod +x /usr/bin/snell-server
    
# ENTRYPOINT ["/root/snell.sh"]

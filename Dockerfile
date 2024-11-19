FROM alpine

ARG TARGETPLATFORM
ARG SNELL_SERVER_VERSION=4.0.1
ENV TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}
COPY entrypoint.sh /root/snell/
RUN apk add --no-cache wget unzip tini gcompat libstdc++ && \
    wget -q -O glibc.apk "https://repo.tlle.eu.org/alpine/v3.20/main/aarch64/glibc-2.35-r1.apk" && \
    wget -q -O glibc-bin.apk "https://repo.tlle.eu.org/alpine/v3.20/main/aarch64/glibc-bin-2.35-r1.apk" && \
    apk add --no-cache --allow-untrusted --force-overwrite glibc.apk glibc-bin.apk && \
    rm -f *.apk && \
    chmod +x /root/snell/entrypoint.sh
    
WORKDIR /root/snell

RUN wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v${SNELL_SERVER_VERSION}-linux-aarch64.zip"

RUN if [ -f snell.zip ]; then unzip snell.zip && rm -f snell.zip; fi && \
    chmod +x snell-server

ENTRYPOINT ["/sbin/tini", "--", "/root/snell/entrypoint.sh"]
    
# ENTRYPOINT ["/root/snell.sh"]

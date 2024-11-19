FROM alpine

ARG TARGETPLATFORM
ARG SNELL_SERVER_VERSION=4.0.1
ENV TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}

RUN apk add --no-cache wget unzip tini gcompat libstdc++ && \
    case "$TARGETPLATFORM" in \
    "linux/amd64") \
    GLIBC_URL="https://repo.tlle.eu.org/alpine/v3.20/main/x86_64/glibc-2.36-r1.apk"; \
    GLIBC_BIN_URL="https://repo.tlle.eu.org/alpine/v3.20/main/x86_64/glibc-bin-2.36-r1.apk"; \
    ;; \
    "linux/arm64") \
    GLIBC_URL="https://repo.tlle.eu.org/alpine/v3.20/main/aarch64/glibc-2.35-r1.apk"; \
    GLIBC_BIN_URL="https://repo.tlle.eu.org/alpine/v3.20/main/aarch64/glibc-bin-2.35-r1.apk"; \
    ;; \
    *) \
    echo "不支持的平台: $TARGETPLATFORM" && exit 1; \
    ;; \
    esac && \
    wget -q -O glibc.apk "$GLIBC_URL" && \
    wget -q -O glibc-bin.apk "$GLIBC_BIN_URL" && \
    apk add --no-cache --allow-untrusted --force-overwrite glibc.apk glibc-bin.apk && \
    rm -f *.apk && \
    chmod +x /root/snell/entrypoint.sh
    
WORKDIR /root/snell

RUN case "${TARGETPLATFORM}" in \
    "linux/amd64") wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v${SNELL_SERVER_VERSION}-linux-amd64.zip" ;; \
    "linux/arm64") wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v${SNELL_SERVER_VERSION}-linux-aarch64.zip" ;; \
    *) echo "unsupported platform: ${TARGETPLATFORM}"; exit 1 ;; \
    esac

RUN if [ -f snell.zip ]; then unzip snell.zip && rm -f snell.zip; fi && \
    chmod +x snell-server && \
    chmod +x entrypoint.sh

COPY entrypoint.sh /root/snell/

ENTRYPOINT ["/sbin/tini", "--", "/root/snell/entrypoint.sh"]
    
# ENTRYPOINT ["/root/snell.sh"]

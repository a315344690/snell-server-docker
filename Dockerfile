FROM --platform=$BUILDPLATFORM debian:sid-slim

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG SNELL_SERVER_VERSION=4.0.1

RUN apt-get update && \
    apt-get install -y --no-install-recommends wget unzip && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app/

RUN wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v${SNELL_SERVER_VERSION}-linux-aarch64.zip"

COPY entrypoint.sh /app/

RUN if [ -f snell.zip ]; then unzip snell.zip && rm -f snell.zip; fi && \
    chmod +x snell-server && \
    chmod +x entrypoint.sh

ENV LANG=C.UTF-8
ENV TZ=Asia/Shanghai
ENV PORT=6180
ENV IPV6=false
ENV PSK=

LABEL version="${SNELL_SERVER_VERSION}"

ENTRYPOINT ["/app/entrypoint.sh"]

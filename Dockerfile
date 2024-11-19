FROM --platform=$BUILDPLATFORM bitnami/minideb:bullseye AS build

ARG TARGETPLATFORM
ENV TARGETPLATFORM=${TARGETPLATFORM:-linux/amd64}
COPY entrypoint.sh /root/snell/
RUN install_packages wget unzip ca-certificates && \
    chmod +x /root/snell/entrypoint.sh
    
WORKDIR /root/snell

RUN wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v4.1.1-linux-aarch64.zip"

RUN if [ -f snell.zip ]; then unzip snell.zip && rm -f snell.zip; fi && \
    chmod +x snell-server

ENTRYPOINT ["/root/snell/entrypoint.sh"]
    
# ENTRYPOINT ["/root/snell.sh"]

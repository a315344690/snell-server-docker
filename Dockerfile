FROM ubuntu:24.04

COPY entrypoint.sh /root/snell/
RUN apt install wget unzip ca-certificates && \
    chmod +x /root/snell/entrypoint.sh
    
WORKDIR /root/snell

RUN wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v4.1.1-linux-amd64.zip"

RUN if [ -f snell.zip ]; then unzip snell.zip && rm -f snell.zip; fi && \
    chmod +x snell-server

ENTRYPOINT ["/root/snell/entrypoint.sh"]
    
# ENTRYPOINT ["/root/snell.sh"]

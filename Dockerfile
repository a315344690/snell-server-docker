FROM debian:stable-slim

ENV TZ=Asia/Shanghai

WORKDIR /root
COPY ./snell.sh /root/snell.sh

RUN apt update && apt install -y unzip wget && \
    apt clean && \
    apt autoclean && \
    rm -fr /var/lib/apt/lists/* && \
    chmod +x /root/snell.sh 

RUN wget --no-check-certificate -O snell.zip "https://dl.nssurge.com/snell/snell-server-v4.0.1-linux-aarch64.zip"

ENTRYPOINT ["/root/snell.sh"]

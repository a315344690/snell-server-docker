#!/bin/bash

set -e
random_port() {
    shuf -i 1024-65535 -n 1
}
random_psk() {
    tr -dc 'a-zA-Z0-9' </dev/urandom | fold -w 20 | head -n 1
}
generate_config() {
    PORT=${PORT:-$(random_port)}
    PSK=${PSK:-$(random_psk)}
    IPV6=${IPV6:-false}

    {
        echo "[snell-server]"
        echo "listen=:::$PORT"
        echo "psk=$PSK"
        echo "ipv6=$IPV6"
    } >/root/snell/snell.conf

    if [ -n "$DNS" ]; then
        echo "dns=$DNS" >>/root/snell/snell.conf
    fi
    if [ -n "$OBFS" ]; then
        echo "obfs=$OBFS" >>/root/snell/snell.conf
    fi
    if [ -n "$HOST" ]; then
        echo "obfs-host=$HOST" >>/root/snell/snell.conf
    fi
}

generate_config

[ -n "$PORT" ] && echo "PORT:$PORT" >/dev/null
[ -n "$PSK" ] && echo "PSK:$PSK" >/dev/null
[ -n "$VERSION" ] && echo "VERSION:$VERSION" >/dev/null
[ -n "$DNS" ] && echo "DNS:$DNS" >/dev/null
[ -n "$OBFS" ] && echo "OBFS:$OBFS" >/dev/null
[ -n "$HOST" ] && echo "HOST:$HOST" >/dev/null

exec /root/snell/snell-server -c /root/snell/snell.conf -l "${LOG:-notify}"


#!/bin/bash

set -e

# ایجاد کلید TLS
openssl req -x509 -newkey rsa:2048 -nodes -keyout key.pem -out cert.pem -days 365 \
  -subj "/C=US/ST=State/L=City/O=Org/CN=localhost"

# ساخت کانفیگ Hysteria
cat <<CONFIG > config.json
{
  "listen": ":443",
  "tls": {
    "cert": "cert.pem",
    "key": "key.pem"
  },
  "auth": {
    "type": "password",
    "password": "your-password"
  },
  "obfs": {
    "type": "none"
  }
}
CONFIG

# دانلود Hysteria
curl -L -o hysteria.tar.gz https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64.tar.gz
tar -xzf hysteria.tar.gz
chmod +x hysteria
./hysteria server --config config.json

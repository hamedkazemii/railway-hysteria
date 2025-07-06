#!/bin/bash
set -e

# ساخت گواهینامه TLS
openssl req -x509 -newkey rsa:2048 -nodes -keyout key.pem -out cert.pem -days 365 \
  -subj "/C=US/ST=State/L=City/O=Org/CN=localhost"

# ساخت فایل config.json بدون obfs
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
  }
}
CONFIG

# دانلود باینری Hysteria
curl -L -o hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64
chmod +x hysteria

# اجرای سرور
./hysteria server --config config.json

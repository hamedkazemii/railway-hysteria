#!/bin/bash

# نصب Hysteria 2 (Server)
curl -L -o hysteria https://github.com/apernet/hysteria/releases/latest/download/hysteria-linux-amd64
chmod +x hysteria

# ساخت فایل کانفیگ
cat > config.yaml <<EOF
listen: :443
obfs: "myobfs"  # تغییر بده برای امنیت بیشتر
auth:
  type: password
  password: "test1234"
tls:
  cert: cert.pem
  key: key.pem
  alpn:
    - h3
disable_udp: false
EOF

# ساخت گواهی TLS خودامضا (برای تست سریع؛ در حالت واقعی باید Let's Encrypt استفاده شه)
openssl req -x509 -newkey rsa:2048 -nodes -keyout key.pem -out cert.pem -days 365   -subj "/CN=railway-vpn.local"

# اجرای سرور
./hysteria server -c config.yaml

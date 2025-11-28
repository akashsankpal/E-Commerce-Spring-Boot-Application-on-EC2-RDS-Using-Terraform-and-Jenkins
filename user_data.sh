#!/bin/bash
set -e

# Install Java and Git (Amazon Linux 2 friendly)
if command -v yum >/dev/null 2>&1; then
  yum check-update || true
  yum install -y java-17-amazon-corretto git
else
  apt-get update -y
  apt-get install -y openjdk-17-jdk git
fi

# Create app user & dir
useradd -m -s /bin/bash appuser || true
mkdir -p /opt/ecommerce
chown appuser:appuser /opt/ecommerce

# Create systemd service (placeholder; ExecStart will run jar file)
cat > /etc/systemd/system/ecommerce.service <<'EOF'
[Unit]
Description=Ecommerce Spring Boot App
After=network.target

[Service]
User=appuser
WorkingDirectory=/opt/ecommerce
ExecStart=/usr/bin/java -jar /opt/ecommerce/ecommerce.jar
SuccessExitStatus=143
Restart=on-failure
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable ecommerce.service

# create log dir
mkdir -p /opt/ecommerce/logs
chown appuser:appuser /opt/ecommerce/logs

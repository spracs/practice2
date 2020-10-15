#!/bin/bash
set -e

APP_DIR=/home/${username}
git clone -b monolith https://github.com/express42/reddit.git $APP_DIR/reddit
cd $APP_DIR/reddit
bundle install

export DATABASE_URL=${db_server_ip}
echo "export DATABASE_URL=${db_server_ip}">>$APP_DIR/.profile
sudo mv /tmp/puma.service /etc/systemd/system/puma.service
sudo systemctl start puma
sudo systemctl enable puma
#!/bin/bash
git clone -b monolith https://github.com/express42/reddit.git
cd reddit && bundle install && puma -d
sudo mv /tmp/puma.service /lib/systemd/system/
sudo systemctl enable puma


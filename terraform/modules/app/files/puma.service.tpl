[Unit]
Description=Puma HTTP Server
After=network.target

[Service]
Type=simple
User=${username}
WorkingDirectory=/home/${username}/reddit
ExecStart=/bin/bash -lc 'puma'
Restart=always

[Install]
WantedBy=multi-user.target
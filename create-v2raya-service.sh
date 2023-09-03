#!/bin/bash

flatpak-spawn --host pkexec sh -c '

cat << EOF > /etc/systemd/system/v2raya-flatpak.service
[Unit]
Description=v2rayA Service
Documentation=https://github.com/v2rayA/v2rayA/wiki
After=network.target nss-lookup.target iptables.service ip6tables.service nftables.service
Wants=network.target

[Service]
Type=simple
User=root
LimitNPROC=500
LimitNOFILE=1000000
ExecStart=flatpak run io.github.glaumar.v2raya_flatpak
Restart=on-failure

[Install]
WantedBy=multi-user.target
EOF

systemctl enable --now v2raya-flatpak.service
'
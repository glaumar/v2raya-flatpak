#!/bin/bash

flatpak-spawn --host pkexec sh -c '

systemctl disable --now v2raya-flatpak.service
rm -rf /etc/systemd/system/v2raya-flatpak.service
'
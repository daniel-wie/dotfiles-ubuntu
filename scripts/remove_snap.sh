#!/bin/bash

# Remove and block snap from an ubuntu system
# https://itsfoss.com/remove-snap/

# Stop services
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service

# Uninstall
sudo apt-get remove --purge snapd
sudo apt-get autoremove --purge

# Remove stray files
if [ -d /var/cache/snapd ]; then
    sudo rm -rf /var/cache/snapd
fi

if [ -d ~/snap ]; then
    rm -rf ~/snap
fi

# Block re-entry of snap
sudo tee /etc/apt/preferences.d/nosnap > /dev/null << EOF
Package: snapd
Pin: release a=*
Pin-Priority: -10
EOF

# Update package list
sudo apt-get update

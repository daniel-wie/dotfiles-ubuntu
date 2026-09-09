#!/bin/bash

##### Firefox #####
# https://support.mozilla.org/en-US/kb/install-firefox-linux#w_install-firefox-deb-package-for-debian-based-and-ubuntu-based-distributions-recommended

# Create directory to store APT repository keys if it doesn't exist:
sudo install -d -m 0755 /etc/apt/keyrings

# Import the Mozilla APT repository signing key:
wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null

# Check fingerprint.
fingerprint=$(
    gpg --show-keys --with-colons /etc/apt/keyrings/packages.mozilla.org.asc \
        | awk -F: '/^fpr:/ {print $10; exit}'
)

if [ "$fingerprint" = "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3" ]; then
    echo "Mozilla APT repository fingerprint matches!"
else
    echo "Mozilla APT repository fingerprint mismatch!"
    exit 1
fi

sudo tee /etc/apt/sources.list.d/mozilla.sources > /dev/null << EOF
Types: deb
URIs: https://packages.mozilla.org/apt
Suites: mozilla
Components: main
Signed-By: /etc/apt/keyrings/packages.mozilla.org.asc
EOF

# Configure APT to prioritize packages from the Mozilla repository:
sudo tee /etc/apt/preferences.d/mozilla > /dev/null << EOF
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
EOF

sudo apt-get update

##### Zotero #####
# https://zotero.retorque.re/file/apt-package-archive/index.html

curl -sL https://raw.githubusercontent.com/retorquere/zotero-pkg/master/install.sh | sudo bash -s -- -m sources

sudo apt-get update

##### Teams #####
# https://ismaelmartinez.github.io/teams-for-linux/installation/

sudo wget -qO /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc

sudo tee /etc/apt/sources.list.d/teams-for-linux-packages.sources > /dev/null << EOF
Types: deb
URIs: https://repo.teamsforlinux.de/debian/
Suites: stable
Components: main
Signed-By: /etc/apt/keyrings/teams-for-linux.asc
Architectures: amd64
EOF

sudo apt-get update

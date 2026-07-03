# Exit on error
set -e

##### Remove snap #####
# https://itsfoss.com/remove-snap/

# Stop snapd services
sudo systemctl disable snapd.service
sudo systemctl disable snapd.socket
sudo systemctl disable snapd.seeded.service

# Uninstall
sudo apt-get remove --purge snapd

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

##### Add mozilla APT repository #####
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

# The fingerprint should be 35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3.
if [ "$fingerprint" = "35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3" ]; then
    echo "Mozilla APT repository fingerprint matches!"
else
    echo "Mozilla APT repository fingerprint mismatch!"
    exit 1
fi

# Next, add the Mozilla APT repository to your sources.list:
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

# Update your package list, and install firefox:
sudo apt-get update
sudo apt-get install firefox

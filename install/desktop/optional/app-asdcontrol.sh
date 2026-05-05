#!/bin/bash

# Install asdcontrol
ASDCONTROL_VERSION=$(curl -s https://api.github.com/repos/omakasui/asdcontrol/releases/latest | grep -Po '"tag_name": "v\K[^"]*')
wget -O asdcontrol.deb "https://github.com/omakasui/asdcontrol/releases/latest/download/asdcontrol_${ASDCONTROL_VERSION}_amd64.deb"
sudo apt install -y ./asdcontrol.deb
rm asdcontrol.deb
cd -

# Setup sudo-less controls
echo 'KERNEL=="hiddev*", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="9243", GROUP="users", OWNER="root", MODE="0660"' | sudo tee /etc/udev/rules.d/50-apple-xdr.rules >/dev/null
echo 'KERNEL=="hiddev*", ATTRS{idVendor}=="05ac", ATTRS{idProduct}=="1114", GROUP="users", OWNER="root", MODE="0660"' | sudo tee /etc/udev/rules.d/50-apple-studio.rules >/dev/null
sudo udevadm control --reload-rules

# Reboot to pickup changes
gum confirm "Ready to reboot for brightness controls to be available?" && sudo reboot

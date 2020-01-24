#!/bin/bash

# Install Script to setup Raspberry Pi with PiHole and PADD running on TFT Screen

PIHOLE_INTERFACE=""
PIHOLE_IP="192.168.1.2"
GATEWAY_IP="192.168.1.1"
TFT_DRIVER="MHS35"
TFT_ROTATION="180"
PIHOLE_USER="pihole"
PIHOLE_DIR="/home/${PIHOLE_USER}"

## Config Ethernet

# Find out how many interfaces are available to choose from
availableInterfaces=$(ip --oneline link show up | grep -v "lo" | awk '{print $2}' | cut -d':' -f1 | cut -d'@' -f1)
interfaceCount=$(wc -l <<< "${availableInterfaces}")

# If there is one interface,
if [[ "${interfaceCount}" -eq 1 ]]; then
  # Set it as the interface to use since there is no other option
  PIHOLE_INTERFACE="${availableInterfaces}"
# Otherwise,
else
  PIHOLE_INTERFACE="eth0"
  printf "  Unable to determine which interface to use automatically so setting to %s \\n  You may need to adjust /etc/dhcpcd.conf after the install is complete.\\n" "${PIHOLE_INTERFACE}"
fi

# check if the IP is already in the file
if grep -q "${PIHOLE_IP}" /etc/dhcpcd.conf; then
  echo "  Static IP already configured"
# If it's not,
else
  # we can append these lines to dhcpcd.conf to enable a static IP
  echo "interface ${PIHOLE_INTERFACE}
  static ip_address=${PIHOLE_IP}
  static routers=${GATEWAY_IP}
  static domain_name_servers=127.0.0.1" | tee -a /etc/dhcpcd.conf >/dev/null
  # Then use the ip command to immediately set the new address
  ip addr replace dev "${PIHOLE_INTERFACE}" "${PIHOLE_IP}"

  # Also give a warning that the user may need to reboot their system
  printf "  Set IP address to %s \\n  You may need to restart after the install is complete\\n" "${PIHOLE_IP%/*}"
fi

# Install PiHole - See details at https://pi-hole.net/
echo "Installing Pi-Hole..."
curl -sSL https://install.pi-hole.net | bash

# Install PADD - See details at https://github.com/jpmck/PADD
cd ${PIHOLE_DIR}
wget --output-document=~/padd.sh --quiet https://raw.githubusercontent.com/jpmck/PADD/master/padd.sh
sudo chmod +x ~/padd.sh

cd ${PIHOLE_DIR}
echo "
if [ \"\$TERM\" == \"linux\" ]; then
  while :
  do
    sudo con2fbmap 1 0
    ./padd.sh
    sleep 1
  done
fi" | tee ~/.bashrc -a
# To Update: cd ~ && wget -N https://raw.githubusercontent.com/jpmck/PADD/master/padd.sh


echo "About to run screen config.  Select Terminus font at 8x14"
echo "Follow these prompts and selections:"
echo "   UTF-8 > Guess optimal character set > Terminus > 8x14"
read -n 1 -s -r -p "Press any key to continue"
sudo dpkg-reconfigure console-setup

# Install TFT Driver - Note: This will cause a reboot so needs to be last.
echo "Installing Driver..."
cd ${PIHOLE_DIR}
sudo rm -rf LCD-show
git clone https://github.com/goodtft/LCD-show.git
chmod -R 755 LCD-show
cd LCD-show/
sudo ./${TFT_DRIVER}-show $TFT_ROTATION
#sudo ./rotate.sh 180

#!/bin/bash

# Install Script to setup Raspberry Pi
# Runs updates, fixes the Locale
# Changes keyboard to US Layout
# Sets Timezone

PIHOLE_USER="pihole"
HOSTNAME="${1:-PiHole}"
TMZ="${2:-America/Vancouver}"
LOCALE="en_US.UTF-8"

#Check if script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Configure Pi
echo "Change pi default password..."
sudo passwd pi

# TODOs: Add MOTD Scripts
# Setup ssh details.

wget --output-document=rpi_functions.sh --quiet https://raw.githubusercontent.com/rodneyshupe/RPi_Utilities/master/setup/rpi_functions.sh && source rpi_functions.sh

## Add new user and lock Pi User
rpi_enhance_prompt "/home/$PIHOLE_USER"
rpi_clone_user ${PIHOLE_USER}
rpi_updates
rpi_install_essentials
rpi_set_timezone "${TMZ}"
rpi_set_keyboard "us"
rpi_change_hostname "${HOSTNAME}"
rpi_install_login_notifications
rpi_set_locale "${LOCALE}"
rpi_set_autologin "$PIHOLE_USER"

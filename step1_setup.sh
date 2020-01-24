#!/bin/bash

# Install Script to setup Raspberry Pi
# Runs updates, fixes the Locale
# Changes keyboard to US Layout
# Sets Timezone

HOSTNAME="MilliwaysPiHole"
USERNAME="pihole"
TMZ="America/Vancouver"
LOCALE="en_US.UTF-8"

#Check if script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

# Configure Pi
cd ~

echo "Change pi default password..."
sudo passwd

curl -sSL https://raw.githubusercontent.com/rodneyshupe/RPi_Utilities/master/setup/rpi_functions.sh | source

## Add new user and lock Pi User
rpi_clone_user ${NEWUSER}
rpi_updates
rpi_set_timezone "${TMZ}"
rpi_set_keyboard "us"
rpi_change_hostname "${HOSTNAME}"
rpi_set_locale "${LOCALE}"

rpi_set_autologin "$NEWUSER"

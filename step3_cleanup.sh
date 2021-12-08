#!/bin/bash

#Check if script is being run as root
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

echo "Cleanup Step1..."
rm /home/pi/rpi_functions.sh
rm /home/pi/setup1_setup.sh

echo "Cleanup Step2..."
rm /home/pihole/setup2_install.sh

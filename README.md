# Raspberry Pi Pi-Hole server setup.

Setup Scripts for Pi-Hole server on my network

## SD Card Setup
Obtain latest version for Raspian and install on SD card.
Example instructions [here](https://github.com/rodneyshupe/RPi_PiHole_Setup/blob/master/sd_card_setup.md)

## Do Inital setup
Boot raspberry pi and login via SSH and run base setup.

```sh
wget https://raw.githubusercontent.com/rodneyshupe/RPi_PiHole_Setup/master/step1_setup.sh
chmod +x step1_setup.sh
sudo ./step1_setup.sh [HostName [TimeZone]]
```

Follow the prompts.

Log back in as user `pihole` and execute the software install.

```sh
wget https://raw.githubusercontent.com/rodneyshupe/RPi_PiHole_Setup/master/step2_install.sh
chmod +x step2_install.sh
sudo ./step2_install.sh
```

## TODOs:
* Unbound as a local recursive resolver.
* DoH or Dot clients so your DNS traffic between the Pi and upstream server is encrypted

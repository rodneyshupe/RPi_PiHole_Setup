# Raspberry Pi Pi-Hole server setup.

Setup Scripts for Pi-Hole server on my network

## SD Card Setup
Obtain latest version for Raspian and install on SD card.
Example instructions [here](https://github.com/rodneyshupe/RPi_PiHole_Setup/blob/master/sd_card_setup.md)

## Do Inital setup
Boot raspberry pi and login via SSH and run base setup.

```
curl -sSL https://raw.githubusercontent.com/rodneyshupe/RPi_PiHole_Setup/master/step1_setup.sh | sudo bash
```
Follow the prompts.

Log back in as user `pihole` and execute the software install.
```
curl -sSL https://raw.githubusercontent.com/rodneyshupe/RPi_PiHole_Setup/master/step2_install.sh | sudo bash
```

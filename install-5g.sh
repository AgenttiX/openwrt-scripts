#!/usr/bin/env sh
set -eu

# MODEL="$(< /tmp/sysinfo/model)"
# if [ "${MODEL}" = "Bananapi BPI-R4" ]; then

opkg update
# The mwan3 package is for load-balancing between multiple WAN connections.
# QMI is the default mode for Quectel RM520N-GL.
# For MBIM modems, please install luci-proto-mbim.
opkg install kmod-usb-serial kmod-usb-serial-option luci-app-mwan3 luci-proto-qmi sms-tool

# Add and configure IceG repository
grep -q IceG_repo /etc/opkg/customfeeds.conf || echo 'src/gz IceG_repo https://github.com/4IceG/Modem-extras/raw/main/myrepo' >> /etc/opkg/customfeeds.conf
wget "https://github.com/4IceG/Modem-extras/raw/main/myrepo/IceG-repo.pub" -O /tmp/IceG-repo.pub
opkg-key add /tmp/IceG-repo.pub
opkg update

# https://github.com/4IceG/luci-app-3ginfo-lite
opkg install luci-app-3ginfo-lite

echo "A reboot is required to enable the installed packages."

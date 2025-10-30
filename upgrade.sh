#!/usr/bin/env sh
set -eu

opkg update
opkg install owut

# The packages installed from outside the OpenWRT repositories cannot be included in the image.
if opkg list-installed | grep luci-app-3ginfo-lite; then
  owut upgrade --remove luci-app-3ginfo-lite
else
  owut upgrade
fi

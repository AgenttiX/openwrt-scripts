#!/usr/bin/env sh
set -eu

apk update
apk add git git-http librespeed-go luci luci-ssl luci-app-attendedsysupgrade luci-app-snmpd luci-proto-wireguard nano

# Enable the LibreSpeed service here
# nano /etc/config/librespeed-go

# Do this manually if everything is OK.
# reboot

#!/usr/bin/env sh
set -eu

opkg update
# For dev builds: luci luci-ssl
opkg install git git-http librespeed-go luci-app-attendedsysupgrade luci-app-snmpd luci-proto-wireguard mosh-server nano screen

# Enable the LibreSpeed service here, if not already enabled.
# The default port is 8989.
# nano /etc/config/librespeed-go

echo "A reboot is required to enable the installed packages."

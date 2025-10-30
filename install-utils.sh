#!/usr/bin/env sh
set -eu

opkg update
# For dev builds: luci luci-ssl
# bind-host and curl/wget are required for DDNS
opkg install bind-host curl git git-http librespeed-go luci-app-attendedsysupgrade luci-app-ddns luci-app-snmpd luci-proto-wireguard mosh-server nano owut screen

# Enable the LibreSpeed service here, if not already enabled.
# The default port is 8989.
# nano /etc/config/librespeed-go

# Allow ";" in the DDNS domain field for updating multiple domains at once.
# A similar issue:
# https://github.com/openwrt/packages/issues/11207
# DDNS_CONFIG="/usr/lib/ddns/dynamic_dns_functions.sh"
# if [ -f "${DDNS_CONFIG}" ]; then
#   sed -i 's/^DNS_CHARSET_DOMAIN="\[@a-zA-Z0-9\._\*-\]"/DNS_CHARSET_DOMAIN="\[@a-zA-Z0-9\._\*;-\]"/g' "${DDNS_CONFIG}"
# fi

echo "A reboot is required to enable the installed packages."

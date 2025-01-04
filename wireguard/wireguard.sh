#!/usr/bin/env sh
set -eu

# Based on:
# https://openwrt.org/docs/guide-user/services/vpn/wireguard/client

if command -v uci > /dev/null; then :; else
  echo "uci was not found. Are you running OpenWRT?"
fi
if command -v wg > /dev/null; then :; else
  echo "WireGuard was not found. Installing."
  echo "If you have the LuCI GUI installed, you may also want to install luci-proto-wireguard."
  if command -v apk > /dev/null; then :; else
    echo "apk was not found. Are you running OpenWRT?"
    exit 1
  fi
  apk update
  apk add wireguard-tools
fi

if [ ! -f "./wireguard-settings.env" ]; then
  echo "Please copy the template to \"wireguard-settins.env\" and run this script again."
fi
. "./wireguard-settings.env"

# Generate keys
umask go=
# if [ ! -f wgserver.pub ]; then
#   echo "Remote server key was not found. Please write it to wgserver.pub and run this script again."
#   exit 1
#   # echo "Remote server key was not found. Generating."
#   # wg genkey | tee wgserver.key | wg pubkey > wgserver.pub
# fi
if [ ! -f wgclient.key ]; then
  echo "Client key was not found. Generating."
  wg genkey | tee wgclient.key | wg pubkey > wgclient.pub
fi
if [ ! -f wgclient.psk ]; then
  echo "Pre-shared key was not found. Generating."
  wg genpsk > wgclient.psk
fi

# Client private key
VPN_KEY="$(cat wgclient.key)"
# Pre-shared key
VPN_PSK="$(cat wgclient.psk)"
# Server public key
# VPN_PUB="$(cat wgserver.pub)"

echo "Public key: ${VPN_PUB}"
echo "PSK: ${VPN_PSK}"

echo "Configuring firewall."
uci rename firewall.@zone[0]="lan"
uci rename firewall.@zone[1]="wan"
uci del_list firewall.wan.network="${VPN_IF}"
uci add_list firewall.wan.network="${VPN_IF}"
uci commit firewall
service firewall restart

echo "Configuring network."
uci -q delete network.${VPN_IF}
uci set network.${VPN_IF}="interface"
uci set network.${VPN_IF}.proto="wireguard"
uci set network.${VPN_IF}.private_key="${VPN_KEY}"
uci add_list network.${VPN_IF}.addresses="${VPN_ADDR}"
# uci add_list network.${VPN_IF}.addresses="${VPN_ADDR6}"

echo "Configuring VPN peers."
uci -q delete network.wgserver
uci set network.wgserver="wireguard_${VPN_IF}"
uci set network.wgserver.public_key="${VPN_PUB}"
uci set network.wgserver.preshared_key="${VPN_PSK}"
uci set network.wgserver.endpoint_host="${VPN_SERV}"
uci set network.wgserver.endpoint_port="${VPN_PORT}"
uci set network.wgserver.persistent_keepalive="25"
uci set network.wgserver.route_allowed_ips="1"
uci add_list network.wgserver.allowed_ips="${VPN_ALLOWED_IPS}"
# uci add_list network.wgserver.allowed_ips="${VPN_ALLOWED_IPS6"

uci commit network
service network restart

#!/usr/bin/env sh
set -eu

apk update
apk del wpad-basic-mbedtls
apk add wpad-mbedtls

# Do this manually if everything is OK.
# reboot

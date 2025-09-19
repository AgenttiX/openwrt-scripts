# OpenWRT scripts
[OpenWRT](https://openwrt.org/)
is a free and highly versatile router firmware.


## Devices
- Banana Pi BPI-R4: [wiki](https://wiki.banana-pi.org/Banana_Pi_BPI-R4),
  [docs](https://docs.banana-pi.org/en/BPI-R4/BananaPi_BPI-R4),
  [OpenWRT](https://openwrt.org/inbox/toh/sinovoip/bananapi_bpi-r4),
  [Amazon.de](https://www.amazon.de/-/en/gp/product/B0DFCTLXJC/),
  [Youyeetoo](https://www.youyeetoo.com/search/?Keyword=BPI-R4)
  - My go-to device for OpenWRT
  - Wi-Fi 7 and WPA3 (over 1 Gbps Wi-Fi)
  - 2x 10 Gbps SFP+ ports
  - Can be powered over USB-c, so you can also use the device on the go.
  - Firmware is easy to install, as you can boot the device from an SD card.
  - M.2 slot for 5G modem. My recommendation is the
    [Quectel RM520N-GL](https://agx.fi/it/networking.html#quectel-rm520n-gl),
    which can be enabled with the `install-5g.sh` script of this repository.
  - Can be used as a NAS or a small general-purpose server thanks to its M.2 SSD slot and USB 3.0 port.
    (The M.2 SSD and 5G modem can be installed simultaneously.)
  - Serial console is easily accessible for debugging and initial installation of the firmware.

## Instructions for 5G connectivity
- [Reddit discussion on building a 5G modem/router with OpenWRT](https://www.reddit.com/r/openwrt/comments/1bsb1qw/crafting_the_perfect_5g_modemrouter_with_openwrt/)
- [OpenWRT documentation for QMI/MBIM modems](https://openwrt.org/docs/guide-user/network/wan/wwan/ltedongle)

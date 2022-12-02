#!/usr/bin/env bash
name=$(nmcli -t -f active,ssid dev wifi | grep '^yes' --color=never | sed 's/^yes://g')
if [[ "$name" == "" ]]; then
  nmcli con up ifname "$(/usr/bin/env ls /sys/class/ieee80211/*/device/net/)"
else
  wifiname=$(nmcli d | grep wifi | sed 's/^.*wifi.*connected//g' | xargs)
  nmcli con down id "${wifiname}"
fi

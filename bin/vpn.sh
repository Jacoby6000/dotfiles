#!/usr/bin/env zsh

# Read , separated list in to VPNS_DNS array
# (@s/,/)
VPN_DNS=("${(@s/,/)DISNEY_VPN_DNS}")

SUDO_PASS=""

cmd=$0
action=$1

function load_password {
    if [[ -z $SUDO_PASS ]]; then
        SUDO_PASS=$(bw get password 'db9b215b-8ee0-4ff3-a099-b0e00123d5b8')
    fi
}

function sudo_do() {
    load_password
    echo -n "$SUDO_PASS" | sudo -S true 
    sudo $@
}

NET_DEVICE=$(networksetup -listnetworkserviceorder | grep $(echo 'show State:/Network/Global/IPv4' | scutil | grep PrimaryInterface | cut -d: -f2 | xargs echo) | cut -d: -f2 | cut -d, -f1 | sed -E 's/^\s*//' | xargs echo)
case "$action" in
    up)
        echo "Enabling VPN on network device '$NET_DEVICE'"
        VPN_PASS=$(bw get password 'db9b215b-8ee0-4ff3-a099-b0e00123d5b8')
        echo "Logging in to VPN at '$DISNEY_VPN_ADDRESS' with user '$DISNEY_EMAIL' using DNS '${VPN_DNS[@]}'"
        sudo_do echo -n "$VPN_PASS" \
            | sudo openconnect --passwd-on-stdin -b -q --pid-file=/var/run/openconnect.pid -u "$DISNEY_EMAIL" "$DISNEY_VPN_ADDRESS" > /dev/null \
            && sudo_do networksetup -setdnsservers "$NET_DEVICE" ${VPN_DNS[@]}
        ;;
    down)
        echo "Disabling VPN on network device '$NET_DEVICE'"
        sudo_do networksetup -setdnsservers "$NET_DEVICE" Empty && sudo_do killall openconnect
        ;;
    status)
        if [[ -f /var/run/openconnect.pid ]] && ps -p `cat /var/run/openconnect.pid` > /dev/null; then
            echo "up"
        else
            echo "down"
        fi
        ;;
    *)
        echo "usage: $cmd [up|down]"
esac

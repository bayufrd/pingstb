#!/bin/bash

                                #VERSI PING#

#===========================================================================#
            # G A N T I - D E N G A N - M I L I K - K A L I A N #           #
#Wallet=D8QyZTdUo6jLpx3RVj6pwbCmgeVh6pC59m            #walletaddress        #
TOKEN=5006730939:AAGBZhLv31EWPAVKIADxxI_7wwnRhzqo5DY  #ChannelToken         #
CHAT_ID=(1546898379)                                  #ID UserTelegram      #
#node=20                                              #jumlah Miner kalian  #
#===========================================================================#


g='\e[1;32m'
r="tput sgr0"

echo -e "${g} _             ||~~\                                     "; $r
echo -e "${g}|_)  _.        ||__| o  _   _.    |_   _ _|_             "; $r
echo -e "${g}|_) (_| \/ |_| ||    | | ) (_| __ |_) (_) |_             "; $r
echo -e "${g}        /                  ._|                           "; $r
MSG_FILE="bayuPing.msg"
DATE=$(date +"%d-%m-%Y %H:%M:%S")
if [ -e $MSG_FILE ]
then
MESSAGE=`cat $MSG_FILE`
        URL="https://api.telegram.org/bot$TOKEN/sendMessage"
        for ID in "${CHAT_ID[@]}"
                do
                curl -s -X POST $URL -d chat_id=$ID -d text="$MESSAGE";
                echo -e "${g}\n===================="; $r
                echo -e "${g}SUCCESS.. DONE."; $r
                rm $MSG_FILE
                done
else
#=============json init================================#
echo -e "${g}Ping initialization"; $r
echo -e "${g}===================="; $r
function get_ip_addresses() {
        local ips=()
        for f in /sys/class/net/*; do
                local intf=$(basename $f)
                # match only interface names starting with e (Ethernet), br (bridge), w (wireless), r (some Ralink drivers use ra<number> format)
                if [[ $intf =~ $SHOW_IP_PATTERN ]]; then
                        local tmp=$(ip -4 addr show dev $intf | awk '/inet/ {print $2}' | cut -d'/' -f1)
                        # add both name and IP - can be informative but becomes ugly with long persistent/predictable device names
                        #[[ -n $tmp ]] && ips+=("$intf: $tmp")
                        # add IP only
                        [[ -n $tmp ]] && ips+=("$tmp")
                fi
        done
        echo "${ips[@]}"
} # get_ip_addresses
ip_address=$(get_ip_addresses &)

ping -c1 -i3 www.google.com > /dev/null
if [ $? -eq 0 ]
  then
                echo -e "${g}Aman Lur.."; $r
    exit 0
  else
echo -e "IP : "$ip_address >> $MSG_FILE
echo -e "Restart at: \n"$DATE >> $MSG_FILE
    sudo reboot -f now
fi
fi

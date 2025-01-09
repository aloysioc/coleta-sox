#!/bin/bash
ret=$(cat /etc/chrony.conf 2> /dev/null |wc -l)
if [[ "$ret" -eq 45 ]]; then
    echo "NTP/CHRONY CONFIGURADO............OK"
else 
    echo "NTP/CHRONY CONFIGURADO............NOK"
fi
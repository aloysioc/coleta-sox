#!/bin/bash
ret=$(cat /etc/ntp.conf 2> /dev/null |wc -l)
if [[ "$ret" -eq 8 ]]; then
    echo "NTP CONFIGURADO............OK"
else
    echo "NTP CONFIGURADO............NOK"
fi

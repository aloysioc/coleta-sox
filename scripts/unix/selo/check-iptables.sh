#!/bin/bash
ret=$(cat /etc/modprobe.d/iptables.conf 2> /dev/null |wc -l)
if [[ "$ret" -eq 12 ]]; then
     echo "IPTABLES CONFIGURADO............OK"
else 
     echo "IPTABLES CONFIGURADO............NOK"
fi
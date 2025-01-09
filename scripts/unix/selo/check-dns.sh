#!/bin/bash
ret=$(cat /etc/resolv.conf 2> /dev/null |wc -l)
if [[ "$ret" -eq 13 ]]; then
     echo "DNS CONFIGURADO............OK"
else 
     echo "DNS CONFIGURADO............NOK"
fi

#!/bin/bash
ret=$(cat /etc/kdump.conf 2> /dev/null |wc -l)
if [[ "$ret" -eq 189 ]]; then
     echo "KDUMP CONFIGURADO............OK"
else 
     echo "KDUMP CONFIGURADO............NOK"
fi
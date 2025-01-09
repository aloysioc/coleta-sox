#!/bin/bash
ret=$(cat /etc/logrotate.d/syslog 2> /dev/null |wc -l)
if [[ "$ret" -eq 16 ]]; then
     echo "SYSLOG CONFIGURADO............OK"
else 
     echo "SYSLOG CONFIGURADO............NOK"
fi
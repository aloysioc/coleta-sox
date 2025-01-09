#!/bin/bash
rpm -qa &> /dev/null |grep -i tzdata-2019b 
if [[ $? -eq 0 ]]; then
    echo "PACOTE TZDATA INSTALADO...........OK"
    echo -e "\n[LIST TZDATA]"
    rpm -qa |grep -i tzdata-2019b
else
    echo "PACOTE TZDATA INSTALADO...........NOK"
fi
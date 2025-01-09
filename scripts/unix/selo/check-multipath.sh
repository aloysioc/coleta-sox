#!/bin/bash
if [ -f /etc/multipath.conf ]; then
    echo "POSSUI MULTIPATH:.............SIM"
    echo -e "\n[LIST MULTIPATH]"
    sudo cat /etc/multipath.conf |grep -v ^$ |grep -v "#"
else 
     echo "POSSUI MULTIPATH:.............NAO"
fi
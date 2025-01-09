#!/bin/bash
ret=$( ls -l  /etc/sysconfig/network-scripts/ifcfg-bond* 2> /dev/null | wc -l)
if [[ "$ret" -gt 0 ]]; then
    echo "POSSUI INTERFACES BOND ?:.............SIM "
    echo -e "\n[LIST BONDS]"
    ls -l /etc/sysconfig/network-scripts/ifcfg-bond*
else 
     echo "POSSUI INTERFACES BOND ?:.............NAO "
fi
#!/bin/bash
for inet in $(ifconfig -a | sed 's/[ \t].*//;/^$/d')
do
echo "INTERFACE:  $inet"
ifconfig $inet
ethtool $inet

# echo " - cat /proc/net/bonding/$inet"
# cat /proc/net/bonding/$inet

# echo ' - cat /sys/class/net/$inet/bonding/active_slave'
# cat /sys/class/net/$inet/bonding/active_slave
done
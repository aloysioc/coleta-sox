#!/bin/bash
for inet in $(ifconfig -a | sed 's/[ \t].*//;/^$/d')
do
echo 'INTERFACE:  $inet'
ethtool -S $inet | egrep "err|crc"
done
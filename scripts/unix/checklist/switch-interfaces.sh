#!/bin/bash
for inet in $(ifconfig -a | sed 's/[ \t].*//;/^$/d')
do
echo 'INTERFACE:  $inet'
tcpdump -nn -vvv -i $inet -s 1500 -c 1 ether[20:2] == 0x2000
done
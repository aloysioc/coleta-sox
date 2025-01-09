#!/bin/bash
hba=`systool -c fc_host -v | grep " Class Device = " | awk -F"=" '{print $2}' | cut -c 3-8 | sed 's/\"//g'` ;
wwn=`systool -c fc_host -v | grep port_name | awk -F"=" '{print $2}' | cut -c 5-20` ;
state=`systool -c fc_host -v | grep port_state | awk -F"=" '{print $2}' | cut -c 3-20 | sed 's/\"//g'` ;
echo "$hba" > a ; 
echo "$wwn" > b ;
echo "$state" > c ;
paste -d"\t" a b c

#!/bin/bash
yum updateinfo list security installed &> /dev/null
if [[ $? -eq 0 ]]; then
    yum updateinfo list security installed 
else
     yum list-security --security
fi
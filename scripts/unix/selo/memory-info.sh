#!/bin/bash
free -h &> /dev/null
if [[ $? -eq 0 ]]; then
    free -h
else
    free -m
fi
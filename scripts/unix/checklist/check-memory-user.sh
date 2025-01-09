#!/bin/bash
ps -eo pid,user,ppid,cmd,%mem,%cpu --sort=-%cpu | head -20
awk '$3==""kB""{$2=$2/1024/1024;$3=""GB""} 1' /proc/meminfo | column -t
free -g

#!/bin/bash

# echo -e "[HOSTNAME]"
# hostname

# echo  -e "\n[CHECK BASICO DE LOAD]"
# echo " - UPTIME: "
# uptime
# echo " - TOP: "
# top -b -n 1

# echo  -e "\n[AVALIACAO DE CONSUMO DE CPU POR USUARIO]"
# ps -eo pid,user,ppid,cmd,%mem,%cpu --sort=-%cpu | head -20
# ps axo user,pcpu,pmem,rss --no-heading | awk '{pCPU[$1]+=$2; pMEM[$1]+=$3; sRSS[$1]+=$4} END {for (user in pCPU) if (pCPU[user]>0 || sRSS[user]>10240) printf "%s:@%.1f%% of total CPU,@%.1f%% of total MEM@(%.2f GiB used)\n", user, pCPU[user], pMEM[user], sRSS[user]/1024/1024}' | column -ts@ | sort -rnk2


# echo  -e "\n[AVALIACAO DE CONSUMO DE MEMORIA POR USUARIO]"
# ps -eo pid,user,ppid,cmd,%mem,%cpu --sort=-%cpu | head -20
# awk '$3==""kB""{$2=$2/1024/1024;$3=""GB""} 1' /proc/meminfo | column -t
# free -g

# echo  -e "\n[AVALIACAO DE CONSUMO DE ESPACO]"
# df -kh

# echo  -e "\n[VALIDACAO DO SINCRONISMO DO HORARIO]"
# timedatectl &> /dev/null
# if [[ $? -eq 0 ]]; then
#     timedatectl
# else
#     ntpstat
# fi

# echo  -e "\n[VALIDACAO DO OFFSET DE HORARIO]"
# ntpdate -q 127.0.0.1


# echo  -e '\n[VALIDACAO DE QUALQUER ERRO NA LOG DE SO]'
# cat /var/log/messages | egrep -v audit | egrep -i "err|fail"

# echo  -e '\n[VALIDACAO DE ERROS DE HARDWARE]'
# cat /var/log/messages | egrep "err|fail|hard"

# echo  -e '\n[AVALIAR STATUS POR DISCO]'	
# sar -d 

# echo  -e '\n[AVALIAR O IOWAIT DOS DISCOS]'
# sar

# echo  -e '\n[AVALIAR OS PATHS DE STORAGE]'
# systool -c fc_host -v | egrep "port_nameport_state|Class Device path"


echo  -e '\n[VALIDACAO DE STATUS E LINK]'
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


# echo  -e '\n[VALIDACAO DE ERROS E LINK]'
# for inet in $(ifconfig -a | sed 's/[ \t].*//;/^$/d')
# do
# echo 'INTERFACE:  $inet'
# ethtool -S $inet | egrep "err|crc"
# done

# echo  -e '\n[IDENTIFICACAO DE PORTAS DE SWITCH X INTERFACES]'
# for inet in $(ifconfig -a | sed 's/[ \t].*//;/^$/d')
# do
# echo 'INTERFACE:  $inet'
# tcpdump -nn -vvv -i $inet -s 1500 -c 1 ether[20:2] == 0x2000
# done


# echo  -e '\n[MONITORAMENTO DE PIDS VIA SAR]'
# sar -u -r -b 1 -X <pid> | grep -v Average

# echo  -e '\n[IDENTIFICAR O TIPO DE AMBIENTE (FISICO / VIRTUAL)]'
# dmidecode -t1

# echo  -e '\n[ANALISE DE EXECUCAO DO SERVICO DO PANDA EDR]'
# ps aux | grep -i panda

# echo  -e '\n[ANALISE / ACOES DE EXECUCAO DO SERVIÇO DO DEEP SECURITY]'
# service ds_agent status -b

# echo  -e '\n[ANALISE / ACOES DE EXECUCAO]'
# service gc-agent status -b

# # # echo  -e '\n[ERROS FREQUENTES (ENFORCEMENT)]'
# # # cat /var/log/messages | grep ENFORCEMENT
# # # cat /var/log/gc-enforcement-agent.log
# # # cat /var/log/gc-enforcement-driver.log
# # # cat /var/log/gc-guest-agent.log

# # # echo  -e '\n[AVALIAR A CAMADA DE ANALISE]'
# # # cat /etc/default/guardcore

# echo  -e '\n[IDENTIFICAÇÃO DE PROCESSOS POR PORTA / ESTADO]'
# lsof 
# netstat -anlp 
# netstat -tulpn

# echo  -e "\n[IDENTIFICACAO DOS REBOOTS DO SERVIDOR]"
# # last -1x reboot
# last -n2 -x shutdown reboot


# echo  -e '\n[IP CONSOLE]'
# ipmitool lan print

# echo  -e '\n[WWN]'
# hba=`systool -c fc_host -v | grep " Class Device = " | awk -F"=" '{print $2}' | cut -c 3-8 | sed 's/\"//g'` ; wwn=`systool -c fc_host -v | grep port_name | awk -F"=" '{print $2}' | cut -c 5-20` ; state=`systool -c fc_host -v | grep port_state | awk -F"=" '{print $2}' | cut -c 3-20 | sed 's/\"//g'` ; echo "$hba" > a ; echo "$wwn" > b ; echo "$state" > c ; paste -d"\t" a b c

# echo  -e '\n[CPU]'
# sar 5 5

# echo  -e '\n[TAREFAS]'
# for user in $(getent passwd | cut -f1 -d: ); do echo $user; crontab -u $user -l; done

# echo  -e '\n[USUARIOS]'
# last

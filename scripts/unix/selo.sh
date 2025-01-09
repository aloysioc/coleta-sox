#!/bin/bash
echo -e "[HOSTNAME]"
hostname

echo  -e "\n[HOST IP ADDRESSES]"
hostname --ip-address  | awk '{print $1}'

echo  -e "\n[GET USERS]"
cat /etc/passwd

echo  -e "\n[GET GROUPS]"
getent group

echo  -e "\n[OS INFO]"
uname --all
cat /etc/os-release
cat /etc/redhat-release 
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
 elif [ -f /etc/SuSe-release ]; then
     # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
     # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi
echo $OS
echo $VER


echo  -e "\n[CPU INFO]"
lscpu | egrep 'Model name|Socket|Thread|NUMA|CPU\(s\)'

echo  -e "\n[LIST MOUNT]"
mount | column -t

echo  -e "\n[LIST DISK FREE]"
df -H

echo  -e "\n[MEMORY INFO]"
free -h &> /dev/null
if [[ $? -eq 0 ]]; then
    free -h
else
    free -m
fi


echo  -e "\n[PYTHON VERSION]"
python -V &> /dev/null
if [[ $? -eq 0 ]]; then
    python -V
else
    echo "Python2 not installed."
fi

python3 -V &> /dev/null
if [[ $? -eq 0 ]]; then
    python3 -V
else
    echo "Python3 not installed."
fi


if [ -f /etc/redhat-release ]; then
#   yum updateinfo list updates security
    yum updateinfo list security installed &> /dev/null
    if [[ $? -eq 0 ]]; then
        echo -e "\n[INSTALLED SECURITY PATCHES]"
        yum updateinfo list security installed
    fi
fi

if [ -f /etc/lsb-release ]; then
  apt list --upgradable | grep "\-security"
fi

echo -e "\n[CHECK BOND]"
ret=$( ls -l  /etc/sysconfig/network-scripts/ifcfg-bond* 2> /dev/null | wc -l)
if [[ "$ret" -gt 0 ]]; then
    echo "POSSUI INTERFACES BOND ?:.............SIM "
    echo -e "\n[LIST BONDS]"
    ls -l /etc/sysconfig/network-scripts/ifcfg-bond*
else 
     echo "POSSUI INTERFACES BOND ?:.............NAO "
fi

echo -e "\n[CHECK MULTIPATH]"
if [ -f /etc/multipath.conf ]; then
    echo "POSSUI MULTIPATH:.............SIM"
    echo -e "\n[LIST MULTIPATH]"
    sudo cat /etc/multipath.conf |grep -v ^$ |grep -v "#"
else 
     echo "POSSUI MULTIPATH:.............NAO"
fi


echo -e "\n[CHECK TZDATA]"
rpm -qa &> /dev/null |grep -i tzdata-2019b 
if [[ $? -eq 0 ]]; then
    echo "PACOTE TZDATA INSTALADO...........OK"
    echo -e "\n[LIST TZDATA]"
    rpm -qa |grep -i tzdata-2019b
else
    echo "PACOTE TZDATA INSTALADO...........NOK"
fi

echo -e "\n[CHECK NTP]"
ret=$(cat /etc/ntp.conf 2> /dev/null |wc -l)
if [[ "$ret" -eq 8 ]]; then
    echo "NTP CONFIGURADO............OK"
else
    echo "NTP CONFIGURADO............NOK"
fi
echo -e "\n[LIST NTP]"
grep 'iburst' /etc/ntp.conf | awk '{ print $2 }'


echo -e "\n[CHECK CHRONY]"
ret=$(cat /etc/chrony.conf 2> /dev/null |wc -l)
if [[ "$ret" -eq 45 ]]; then
    echo "NTP/CHRONY CONFIGURADO............OK"
else 
    echo "NTP/CHRONY CONFIGURADO............NOK"
fi
echo -e "\n[LIST CHRONY]"
grep 'iburst' /etc/chrony.conf | awk '{ print $2 }'


echo -e "\n[CHECK DNS]"
ret=$(cat /etc/resolv.conf 2> /dev/null |wc -l)
if [[ "$ret" -eq 13 ]]; then
     echo "DNS CONFIGURADO............OK"
else 
     echo "DNS CONFIGURADO............NOK"
fi

echo -e "\n[LIST DNS]"
egrep "10.128.*|10.238.*|10.41.*" /etc/resolv.conf |awk '{ print $2 }'

echo -e "\n[CHECK IPTABLES]"
ret=$(cat /etc/modprobe.d/iptables.conf 2> /dev/null |wc -l)
if [[ "$ret" -eq 12 ]]; then
     echo "IPTABLES CONFIGURADO............OK"
else 
     echo "IPTABLES CONFIGURADO............NOK"
fi

echo -e "\n[LIST IPTABLES]"
cat /etc/modprobe.d/iptables.conf |grep -i alias |awk '{ print $2,$3 }'

echo -e "\n[CHECK KDUMP]"
ret=$(cat /etc/kdump.conf 2> /dev/null |wc -l)
if [[ "$ret" -eq 189 ]]; then
     echo "KDUMP CONFIGURADO............OK"
else 
     echo "KDUMP CONFIGURADO............NOK"
fi

echo -e "\n[LIST KDUMP]"
cat /etc/kdump.conf |grep -v ^$ |grep -v "#"


echo -e "\n[CHECK SYSLOG]"
ret=$(cat /etc/logrotate.d/syslog 2> /dev/null |wc -l)
if [[ "$ret" -eq 16 ]]; then
     echo "SYSLOG CONFIGURADO............OK"
else 
     echo "SYSLOG CONFIGURADO............NOK"
fi

echo -e "\n[LIST SYSLOG]"
cat /etc/logrotate.d/syslog


echo -e "\n[VALIDA REPO]"
grep -i serverURL=http /etc/sysconfig/rhn/up2date| wc -l| awk '{if($1>0){print "Repo CONFIGURADO............OK"}else{print "Repo CONFIGURADO............NOK"}}'


echo -e "\n[VALIDA LVM]"
grep -i Filter /etc/lvm/lvm.conf | grep -v '#'| wc -l| awk '{if($1>0){print "LVM  CONFIGURADO............OK"}else{print "LVM  CONFIGURADO............NOK"}}'

echo -e "\n[VALIDA SYSLOG]"
grep -i siem.redecorp.br /etc/rsyslog.conf | wc -l| awk '{if($1>0){print "RSYSLOG  CONFIGURADO............OK"}else{print "RSYSLOG  CONFIGURADO............NOK"}}'

echo -e "\n[COLETA INTERFACES]"
for i in $(ls -l /etc/sysconfig/network-scripts/ifcfg-* |awk '{ print $9 }'); do echo "###" $i "###" && cat $i && echo -e "##############################\n";done
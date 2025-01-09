#!/bin/bash
func_linux(){
cat /etc/passwd|awk -F: '{print $1}'|while read USER
do 
STATUS=`passwd -S $USER`
echo "$USER | $STATUS" 
done
}

func_aix(){
cat /etc/passwd|awk -F: '{print $1}'|while read USER
do
STATUS=`lsuser $USER|awk -F"account_locked" '{print $2}'|awk '{print $1}'`
echo "$USER | account_locked$STATUS" 
done
}

func_hpux(){
cat /etc/passwd|awk -F: '{print $1}'|while read USER
do
STATUS=`passwd -s $USER`
if [ $? != 0 ]; then 
	STATUS=`/bin/passwd -s $USER`
	echo "$USER | $STATUS" 
else
echo "$USER | $STATUS" 
fi
done
}

func_solaris(){
cat /etc/passwd|awk -F: '{print $1}'|while read USER
do
STATUS=`passwd -s $USER`
echo "$USER | $STATUS" 
done
}


 SO=`uname`
        case "$SO" in

        "Linux")
        func_linux
        ;;

        "SunOS")
        func_solaris
        ;;

        "HP-UX")
        func_hpux
        ;;

        "AIX")
        func_aix
        ;;

        esac




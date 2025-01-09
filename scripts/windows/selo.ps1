echo "`n[SCRIPT TYPE]"
echo "PowerShell"
echo ""

echo "`n[HOSTNAME]"
hostname
echo ""

echo  "`n[POWERSHELL VERSION]"
(Get-Host).Version

echo  "`n[HOST IP ADDRESSES]"
(Get-NetIPAddress -AddressFamily IPv4 -AddressState Preferred ).IPAddress
echo ""

echo  "`n[LIST DRIVES]"
wmic logicaldisk 
echo ""

echo  "`n[LIST SHARES]"
net share
echo ""

echo  "`n[LIST INSTALLED PATCHES]"
wmic qfe list
echo ""

echo  "`n[SYSTEM INFO]"
systeminfo


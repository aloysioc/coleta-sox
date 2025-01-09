echo  "`n[VALIDAR CONSUMO, NUMERO DE THREADS]"
PowerShell -Command  "ps | sort -des cpu | select  | ft -a;"


echo  "`n[VALIDAR CONSUMO, PAGEFILE"]
(typeperf "\Memory\Available MBytes"  -sc 1)[1,2]
(typeperf "\Memory\% Committed Bytes In Use"  -sc 1)[1,2]
(typeperf "\Memory\Free System Page Table Entries"  -sc 1)[1,2]


echo  "`n[VALIDAR CONSUMO, PERDA DE PACOTE E CONECTIVIDADE NA PORTA DA APLICACAO]"
Netstat -anobq

echo  "`n[VALIDAR OS IPS CONFIGURADOS COM OS DETALHES DE CONEXAO]"
ipconfig /all

echo  "`n[GET USERNAME]"
(WMIC  COMPUTERSYSTEM GET USERNAME)[2]


echo  "`n[UPTIME]"
(Get-CimInstance Win32_OperatingSystem).LastBootUpTime
(typeperf "\System\System Up Time"  -sc 1)[1,2]


# PowerShell -Command "Get-Process | Measure"

# PowerShell -Command "Get-Process | Select-Object -ExpandProperty Threads | Measure"

# PowerShell -Command "Get-Process | Select-Object -ExpandProperty Threads | Measure"

# Get-CimInstance Win32_PageFileSetting | fl *

# Get-WmiObject -Class Win32_LogicalDisk

# Get-WmiObject -Class Win32_LogicalDisk |
# Select-Object -Property DeviceID, VolumeName, @{Label='FreeSpace (Gb)'; expression={($_.FreeSpace/1GB).ToString('F2')}},
# @{Label='Total (Gb)'; expression={($_.Size/1GB).ToString('F2')}},
# @{label='FreePercent'; expression={[Math]::Round(($_.freespace / $_.size) * 100, 2)}}|ft



# query user /server:computername





# wmic computersystem list full /format:list







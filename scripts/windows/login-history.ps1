
$Computer = "localhost"
$MaxEvents = 1024
$LoginEvent = "SuccessfulLogin"
$StartDate = (Get-Date).AddDays(-30)
$Time = "{0:F0}" -f (New-TimeSpan -Start $StartDate -End (Get-Date) | Select -ExpandProperty TotalMilliseconds) -as [int64]
$EventID = 4624

    $EventData = "
        *[EventData[
                Data[@Name='TargetUserName'] != 'SYSTEM' and
                Data[@Name='TargetUserName'] != '$($Computer)$'
            ]
        ]
    "
#}

$Filter = @"
    <QueryList>
        <Query Id="0">
            <Select Path="Security">
            *[System[
                    Provider[@Name='Microsoft-Windows-Security-Auditing'] and
                    EventID=$EventID and
                    TimeCreated[timediff(@SystemTime) &lt;= $($Time)]
                ]
            ]
            and
                $EventData
            </Select>
        </Query>
    </QueryList>
"@

$EventLogList = Get-WinEvent -ComputerName $Computer -FilterXml $Filter -ErrorAction Stop

$Output = foreach ($Log in $EventLogList) {
    #Removing seconds and milliseconds from timestamp as this is allow duplicate entries to be displayed
    $TimeStamp = $Log.timeCReated.ToString('MM/dd/yyyy hh:mm tt') -as [DateTime]

    switch ($Log.Properties[8].Value) {
        2  {$LoginType = 'Interactive'}
        3  {$LoginType = 'Network'}
        4  {$LoginType = 'Batch'}
        5  {$LoginType = 'Service'}
        7  {$LoginType = 'Unlock'}
        8  {$LoginType = 'NetworkCleartext'}
        9  {$LoginType = 'NewCredentials'}
        10 {$LoginType = 'RemoteInteractive'}
        11 {$LoginType = 'CachedInteractive'}
    }

    if ($LoginEvent -eq 'FailedLogin') {
        $LoginType = 'FailedLogin'
    }

    if ($LoginEvent -eq 'DisconnectFromRDP') {
        $LoginType = 'DisconnectFromRDP'
    }

    if ($LoginEvent -eq 'Logoff') {
        $LoginType = 'Logoff'
        $UserName = $Log.Properties[1].Value.toLower()
    } else {
        $UserName = $Log.Properties[5].Value.toLower()
    }

    [PSCustomObject]@{
        ComputerName = $Computer
        TimeStamp    = $TimeStamp
        UserName     = $UserName
        LoginType    = $LoginType
    }
}

#Because of duplicate items, we'll append another select object to grab only unique objects
$Output | select ComputerName, TimeStamp, UserName, LoginType -Unique | select -First $MaxEvents

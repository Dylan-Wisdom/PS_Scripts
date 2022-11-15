# Developed by 

# soccer_dan / vsweeting 

 

$oFileName = (get-ciminstance win32_bios).SerialNumber + '_InfoQuery.txt' 

$OutFile = $PSScriptRoot + '' + '\' + $oFileName 

get-ciminstance win32_bios | Format-List Serialnumber, BIOSVersion| 

write-output >> $OutFile 

get-ciminstance Win32_ComputerSystem | format-list Model, PartofDomain, Domain, BootupState| 

write-output >> $OutFile 

get-ciminstance Win32_OperatingSystem | select-object Caption, BuildNumber, OSArchitecture, InstallDate, LastBootUpTime| 

write-output >> $OutFile 

$namespace = "ROOT\Intel\Thunderbolt" 

$classname = "TbtControllerDetails" 

$computer = $env:COMPUTERNAME 

$tb = Get-WmiObject -Class $classname -ComputerName $computer -Namespace $namespace -ErrorAction:ignore 

$TBSecLevel = '' 

if ( $tb ) { 

    switch ( $tb.SecurityLevel ) { 

        0 { $TBSecLevel = 'No Security' }     

        1 { $TBSecLevel = 'User Authorization' } 

        2 { $TBSecLevel = 'Secure Connect' } 

        3 { $TBSecLevel = 'DisplayPort and USB' } 

        default { $TBSecLevel = 'Unknown security setting' } 

    }  # switch () 

    Write-Output "ThunderBolt Detected: Gen $($tb.Generation), NVMVersion $($tb.NVMVersion), PDVersion $($tb.PDVersion),  

    Security Level: $($tb.SecurityLevel) ($TBSecLevel)`n" >> $OutFile 

} else { 

    write-output "ThunderBolt Controller not detected" >> $OutFile 

} 

write-output "Driver List (Press Ctrl+F to Search):" >> $OutFile 

Get-WmiObject Win32_PnPSignedDriver | Select-Object devicename, driverversion | Sort-Object devicename | 

Where-Object { 

$_.DeviceName -like "*Intel(R)*" -or 

$_.DeviceName -like "*AMD*" -or  

$_.DeviceName -like "*NVidia*" -or  

$_.DeviceName -like "*Dock*" -or  

$_.DeviceName -like "*Ethernet*" -or 

$_.DeviceName -like "*Thunder*" -or  

$_.DeviceName -like "*WAN*" -or 

$_.DeviceName -like "*LAN*" -or 

$_.DeviceName -like "*WLAN*" -or 

$_.DeviceName -like "*Audio*" -or 

$_.DeviceName -like "*Camera*" -or 

$_.DeviceName -like "*Bluetooth*" -or 

$_.DeviceName -like "*Synaptic*" -or 

$_.DeviceName -like "*Mouse*" -or 

$_.DeviceName -like "*Keyboard*" -or 

$_.DeviceName -like "*Track*" -or 

$_.DeviceName -like "*Thermal*" -or 

$_.DeviceName -like "*Chipset*" -or 

$_.DeviceName -like "*Display*" -or 

$_.DeviceName -like "*Graphic*" -or 

$_.DeviceName -like "*Sensor*" -or 

$_.DeviceName -like "*Firmware*" -or 

$_.DeviceName -like "*Speaker*" -or 

$_.DeviceName -like "*Power*" -or  

$_.DeviceName -like "*Card*" -or  

$_.DeviceName -like "*Reader*" -or  

$_.DeviceName -like "*Touch*" -or  

$_.DeviceName -like "*Pen*" -or  

$_.DeviceName -like "*Bio*" -or  

$_.DeviceName -like "*Finger*" -or  

$_.DeviceName -like "*Storage*" -or  

$_.DeviceName -like "*NVM*" -or  

$_.DeviceName -like "*SATA*" -or  

$_.DeviceName -like "*M.2*" -or  

$_.DeviceName -like "*Calib*" -or  

$_.DeviceName -like "*Micro*" -or  

$_.DeviceName -like "*Lenovo*" -or  

$_.DeviceName -like "*Trusted*" -or  

$_.DeviceName -like "*System Interface*" -or  

$_.DeviceName -like "*Fn and function*" -or  

$_.DeviceName -like "*Print*" } | 

Format-Table >> $OutFile 

set-location $PSScriptRoot 
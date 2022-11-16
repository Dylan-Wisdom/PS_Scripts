#Get system services
Get-Service | Sort-Object Status | Export-Csv -Path 'C:\Users\Dylanw\Desktop\DylanW_Services.csv'
#Get system drivers
Get-WmiObject Win32_PnPSignedDriver | Select-Object DeviceName, DriverVersion | Export-Csv -Path 'C:\Users\Dylanw\Desktop\DylanW_Drivers.csv'
#Set-ExecutionPolicy Unrestricted

ping.exe -t HOSTNAME|Foreach{"{0} - {1}" -f (Get-Date),$_} > C:\location.txt
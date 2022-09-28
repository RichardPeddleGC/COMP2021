#!/bin/bash

#Assigns hostname to ComputerName varible
ComputerName=$(hostname --short)
#Assign FQDN name to FQDNName Variable
FQDNName=$(hostname --fqdn)
#Searches for Operating System in hostnamectl, assigns to OperatingSys variable
OperatingSys=$(hostnamectl | grep "Operating")
#Searches for line that contains IP address, isolates IP address and assigns to variable
IpAddress=$(ip route | grep "link src" | awk '{print $9}')
#Searches for line that shows the space, isolates line to text containing free space, assigns to variable RootFileSpace
RootFileSpace=$(df -h / | grep -v "Avail" |  awk '{print $4}')

#Prints out the data in a report
cat <<EOF

	
Report for $ComputerName:
=========
FQDN: $FQDNName
$OperatingSys
IP Address: $IpAddress
Root Filesystem Free Space: $RootFileSpace

=========
EOF

#!/bin/bash

ComputerName=$(hostname --short)

FQDNName=$(hostname --fqdn)

OperatingSys=$(hostnamectl | grep "Operating")


IpAddress=$(ip route | grep "link src" | awk '{print $9}')

RootFileSpace=$(df -h / | awk '{print $4}' | grep -v "Avail")

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

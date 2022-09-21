#!/bin/bash

#Prints computers FQDN
echo 'Domain Name:'
hostname --fqdn

#Prints information about computer
echo 'Host Info:'
hostnamectl

#Prints every IP address except for IPs on the 127. network
echo 'IP Addresses:'
hostname -I | grep -v 127.*

#Prints disk space of Root
echo 'Root Filesystem Size:'
df -h /

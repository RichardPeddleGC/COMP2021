#!/bin/bash

echo 'Domain Name:'
hostname --fqdn

echo 'Host Info:'
hostnamectl

echo 'IP Addresses:'
hostname -I | grep -v 127.*

echo 'Root Filesystem Size:'
df -h /

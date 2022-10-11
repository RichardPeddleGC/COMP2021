#!/bin/bash

#Step 1: Installing lxd
#Check to see if lxd is currently installed 
which lxd >/dev/null
echo "Checking if lxd is currently installed on system."
if [ $? -ne 0 ]; then
#Install lxd if it is not found
	echo "Install lxd, you may need to enter your password."
	sudo snap install lxd
	#Checks if lxd successfully installed
	if [ $? -ne 0]; then
		#If failed to install lxd, exit
		echo "Failed to install LXD, exiting program."
		exit 1
	fi
fi

#Step 2: Configure lxd
#Check ip route for interfaces for lxdbr0
ip route | grep "lxdbr0"
echo "Checking if lxd has been configured."
#Configures lxd if interface is not found
if [ $? -ne 0 ]; then
	echo "Performing initial configuration of lxd." 
	sudo lxd init --auto
	#Checks if lxdbr0 interface has successfully installed
	ip route | grep "lxdbr0"
	if [ $? -ne 0 ]; then
		echo "Failed to configure lxd, exiting program."
		exit 1
	echo "lxd successfully configured."
	fi
fi

#Step 3:Set up container
#Check if the container already exists
lxc list | grep "COMP2101-S22"
echo "Checking if container COMP2101-S22 already exists"
if [$? -ne 0]; then
	echo "Does not exist, setting up COMP2101 container."
	lxc launch images:ubuntu/22.04 COMP2101-S22
	#Checks if the container was successfully created
	lxc list | grep "COMP2101-S22"
	if [$? -ne 0]; then
		echo "Failed to launch container, exiting program."
		exit 1
	echo "Container COMP2101 successfully launched."
	fi
fi

#Step 4:Add IP address to etc/hosts
#Search /etc/hosts for container name
grep COMP2101-S22 /etc/hosts
if [$? -ne 0]; then
	echo "Adding IP address to /etc/hosts file"
	



#Step 5:Install Apache2
#Checks to see if Apache2 is already installed
which apache2 >/dev/null
echo "Checking if Apache2 is installed on system."
#Installs it if it is not found
if [$? -ne 0]; then
        echo "Install Apache2, you may need to enter your password."
        sudo snap install apache2
        #Checks if lxd successfully installed
        if [ $? -ne 0]; then
                #If failed to install apache2, exit
                echo "Failed to install Apache2, exiting program."
                exit 1
        fi
fi

#Step 6: Retrieve web page from container
#Attempts to load webpage
curl http://COMP2101-S22
echo "Attempting to load COMP2101-S22 webpage."
if [$? -ne 0]; then
	echo "Unable to load page, exiting."
	exit 1
fi

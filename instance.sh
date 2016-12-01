#!/bin/bash

#####################################################################################################
#												    #
#	Title		: instance.sh								    #	
#	Author  	: Sagar Malve								    #
#	Purpose 	: This script is design to Start/Stop Instance with Instance ID. 	    #
#       Note		: Please check README.md before executing this script. 	   		    #
#	Date    	: Thu Dec  1 19:05:58 IST 2016						    #	
#	Version		: 0.1									    #
#	BASH_VERSION    : Tested on GNU BASH version 4.3.11					    #
#	OS Specs 	: Ubunt 14.04 LTS							    #	
#												    #
#####################################################################################################




start_instance(){
      active=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped | grep InstanceId | grep -E -o "i\-[0-9A-Za-z]+")
      #echo -e "Select Instance ID that you want to stop: "
      PS3="Select the instance id that you want to start: "
      select act in $active
	do 
              aws ec2 start-instances --instance-ids $act
	      echo "$act instance is launching"
	      exit 0;
       done
}

stop_instance(){
      stopped=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running | grep InstanceId | grep -E -o "i\-[0-9A-Za-z]+")
      #echo -e "Select Instance ID that you want to stop: "
      PS3="Select the instance id that you want to start: "
      select act in $stopped
	do 
              aws ec2 stop-instances --instance-ids $act
	      echo "$act instance is stopping"
	      exit 0;
       done
}


show_menu(){

echo -e "
	1) Start Instance \n
	2) Stop Instance
	3) Exit "
}


while :
do
	show_menu
	case $input in 
		1) start_instance ;;
		2) stop_instance ;;
		3) exit 0 ;;
	esac
	read -p "Select input [1-3]: " input
	echo "Below are the Instance ID to $input"
done

#!/bin/bash

#####################################################################################################
#												    #
#	Title		: instance.sh								    #	
#	Author  	: Sagar Malve								    #
#	Purpose 	: This script is design to Start/Stop Instance with Instance ID & Tag. 	    #
#       Note		: Please check README.md before executing this script. 	   		    #
#	Date    	: Wed Dec 21 12:03:25 IST 2016						    #	
#	Version		: 0.2									    #
#	BASH_VERSION    : Tested on GNU BASH version 4.3.11					    #
#	OS Specs 	: Ubunt 14.04 LTS							    #	
#												    #
#####################################################################################################




start_instance(){
      PS3="Select the instance id that you want to start: "
active=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=stopped --output text --query 'Reservations[*].Instances[*].[InstanceId,Tags[0].Value]' | awk '{printf $1 " " $2}' ) 
     select act in "${active[@]}"
	do 
	      instanceid=$(echo $act | awk '{print $1}')
              aws ec2 start-instances --instance-ids $instanceid
	      echo "$act instance is launching"
	      exit 0;
       done
}

stop_instance(){
      PS3="Select the instance id that you want to Stop: "
      active=$(aws ec2 describe-instances --filters Name=instance-state-name,Values=running --output text --query 'Reservations[*].Instances[*].[InstanceId,Tags[0].Value]' | awk '{printf $1 " " $2}' ) 
      select act in "${active[@]}"
	do 
	      instanceid=$(echo $act | awk '{print $1}')
              aws ec2 stop-instances --instance-ids $instanceid
	      echo "$act instance status is Stopped"
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
	printf "Below are the Instance ID to $input"
done

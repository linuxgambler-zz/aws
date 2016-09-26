#!/bin/bash

#####################################################################################################
#												    #
#	Title		: ec2launch.sh								    #	
#	Author  	: Sagar Malve								    #
#	Purpose 	: This script is design to launch VPC using Shell Script on AWS. 	    #
#       Note		: Please check README.md before executing this script. 	   		    #
#	Date    	: Mon Sep 26 12:53:07 IST 2016						    #	
#	Version		: 0.1									    #
#	BASH_VERSION    : Tested on GNU BASH version 4.3.11					    #
#	OS Specs 	: Ubunt 14.04 LTS							    #	
#												    #
#####################################################################################################

############################
#	GLOBAL VARIABLES   #
############################

vpcip=10.20.0.0/16   #VPC IP Range defined here you can select CIDR Block according to your requirement.

subnetip=10.20.10.0/24  #Subnet IP Range define here ...

sship=0.0.0.0/0  #Define the Public IP here for which you want to allow Port 22 SSH Access

aws_key=test #SSH Key through which you would like to access your EC2 instance 

key_path=/home/sagar/Desktop/test.pem   #Path to store the key so you can access your instance with ssh

instance_ami=ami-7172b611  # AMAZON AMI ID change it if you want to use Centos / RHEL / UBUNTU etc. 

instance_type=t2.micro  #Type of instance you want to launch with EC2 Eg:t2.micro,m4.largec4.large etc  ...

user=ec2-user          # For AWS AMI may vary depending upon the AMI you required.

############################################################################
#       Do not make any changes in below code				   #
############################################################################

#########################
#	CREATE VPC  	#
#########################

	vpc=$(aws ec2 create-vpc --cidr-block $vpcip --query 'Vpc.VpcId' --output text)
	aws ec2 create-tags --resources $vpc --tags Key=Stack,Value=production_vpc

########################
#	CREATE IGW     #
########################

	igw=$(aws ec2 create-internet-gateway --query 'InternetGateway.InternetGatewayId' --output text)
	aws ec2 attach-internet-gateway --internet-gateway-id $igw --vpc-id $vpc

##########################
#	Create Subnet 	 #
##########################

	subnet=$(aws ec2 create-subnet --vpc-id $vpc --cidr-block $subnetip --query 'Subnet.SubnetId' --output text)

##############################
#	Create Route Table   #
##############################

	route=$(aws ec2 create-route-table --vpc-id $vpc --query 'RouteTable.RouteTableId' --output text) 

########################################
#      Subnet Association for Route    #
########################################

	aws ec2 associate-route-table --route-table-id $route --subnet-id $subnet

#################################################	
#  Create Internet Gateway route in RouteTable  #
#################################################

	aws ec2 create-route --route-table-id $route --destination-cidr-block 0.0.0.0/0 --gateway-id $igw

#############################
#   Create Security Group   #
#############################

	sg=$(aws ec2 create-security-group --group-name sgtest1 --description "sgtest1" --vpc-id $vpc --query 'GroupId' --output text)

##############################
#  Allowing 22 port for SSH  #
##############################

	aws ec2 authorize-security-group-ingress --group-id $sg --protocol tcp --port 22 --cidr $sship

########################################################################################################################################

#############################
#	CREATE KEY PAIR	    #
#############################

	aws ec2 create-key-pair --key-name $aws_key --query 'KeyMaterial' --output text > $key_path

#############################
#	Launch instance     #
#############################

	aws ec2 run-instances --image-id $instance_ami --count 1 --instance-type $instance_type --key-name $aws_key --security-group-ids $sg --subnet-id $subnet --associate-public-ip-address --output text

sleep 2m

ec2=$(aws ec2 describe-instances --query 'Reservations[*].Instances[*].PublicIpAddress' --output=text | tail -n 1)

echo "Elastic IP:  $ec2" 

#################################### END OF FILE ###################################################################


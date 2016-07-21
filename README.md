######################################################

Requirements before launching VPC through script vpclaunch.sh

A---> First install awscli in your machine through which you are executing the script :::

Installation Steps :

For Debian :

1. sudo apt-get install python-pip
2. sudo pip install awscli

For Centos / Redhat :
 
1. sudo yum install python-pip
2. sudo pip install awscli

Reference link : http://docs.aws.amazon.com/cli/latest/userguide/installing.html

B----> Then create IAM User then after creating user you will be asked to download AWS access key and Secret key, save those credentials. Give that IAM then  and give that user full access to VPC. Create a policy 
such that the IAM user will have full access to VPC ....

Reference link : http://docs.aws.amazon.com/IAM/latest/UserGuide/id_users_create.html
		 http://docs.aws.amazon.com/AmazonVPC/latest/UserGuide/VPC_IAM.html 
		 http://docs.aws.amazon.com/directoryservice/latest/admin-guide/role_vpc_full_access.html


C----> Then setup aws configure :
On the terminal :
1) sudo aws configure

->After entering you will be first prompt for: AWS Access Key ID [None]:(By default it is none you need to enter you AWS Access key ID for IAM user that you have created. Enter that Access ID).

->Second prompt for: AWS Secret Access Key [None]:(By default it is none you need to enter you AWS Secret key ID for IAM user that you have created. Enter that AWS Secret key ID).

->Third prompt for: Default region name [None] : us-west-2 (Can define your default region here to which you want to launch your VPC)

->Fourth prompt for: Default output format [None]: (Enter)

Reference link :  http://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html



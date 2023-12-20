#!/bin/bash

AMI=ami-03265a0778a880afb
SG_ID=sg-04f1c1bae9e105fee
INSTANCES=("mongodb" "mysql" "redis" "rabbitmq" "cart" "catalogue" "user" "shipping" "payment" "dispatch" "web")

for i in "${INSTANCES[@]}"
do
    if [ $i == "mongodb" ] || [ $i == "mysql" ] || [ $i == "shipping" ]
    then
        INSTANCE_TYPE="t3.small"
    else
        INSTANCE_TYPE="t2.micro"
    fi
    IP_Address=$(aws ec2 run-instances --image-id $AMI --instance-type $INSTANCE_TYPE --security-group-ids $SG_ID --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$i}]" --query "Instances[0].PrivateIpAddress" --output text)
    echo "$i: $IP_Address"
done


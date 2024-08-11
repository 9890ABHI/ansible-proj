#!/bin/bash

# read -p "Enter key name :  " key_name 

# read -p "Enter image you to give to instances :  " image_name

# read -p "Enter the subnet id :  " subnet_id

# read -p "Enter the compute node number :  " compu_number

# export KEY_NAME=$key_name
# export IMAGE_NAME=$image_name
# export SUBNET_NAME=$subnet_id
# export COMPUTE_NUMBER=$compu_number

export KEY_NAME=boot-1
export IMAGE_NAME=ami-04a81a99f5ec58529
export SUBNET_NAME=subnet-0af822569e9483069
export COMPUTE_NUMBER=2
# echo $key_name
# echo $image_name
# echo $subnet_id


echo "create Ec2 Instances"
# Run the provisioning playbook and capture output
ansible-playbook playbooks/provision-ec2.yml | tee provision-output.txt
echo "successfully created Ec2 Instances"




echo "install slurm"
# ansible-playbook playbooks/install_slurm.yml
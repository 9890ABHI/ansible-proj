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


ansible-playbook -i inventory.ini hostname.yml

# echo "get IP and hostname Ec2 Instances"
# # Run the extract ip and hostname playbook and capture output
# ansible-playbook playbooks/Extract_details_instances.yml | tee Extract_details.txt
# echo "successfully get IP and hostname Ec2 Instances"


# # add ip to /etc/hosts file
# INSTANCE_IPS_FILE="instance-ips.txt"

# # Backup the current /etc/hosts file
# cp /etc/hosts /etc/hosts.bak

# # Add entries from the file to /etc/hosts
# while IFS= read -r line; do
#   # Skip empty lines and lines that start with a comment
#   [[ -z "$line" || "$line" =~ ^# ]] && continue

#   # Extract the IP address and hostname from the line
#   ip=$(echo "$line" | awk '{print $NF}')
#   hostname=$(echo "$line" | awk '{print $1}')

#   # Check if the line format is correct
#   if [[ -n "$ip" && -n "$hostname" ]]; then
#     # Append the IP address and hostname to /etc/hosts
#     grep -q "^$ip" /etc/hosts || echo "$ip $hostname" >> /etc/hosts
#   else
#     echo "Skipping invalid line: $line"
#   fi
# done < "$INSTANCE_IPS_FILE"

# echo "Update complete. Current /etc/hosts contents:"
# cat /etc/hosts

# ansible-playbook playbooks/set-hostname.yml
# ansible-playbook playbooks/share-ssh-key.yml

echo "install slurm"
# ansible-playbook playbooks/install_slurm.yml
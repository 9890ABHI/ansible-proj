#!/bin/bash

# read -p "Enter key name :  " key_name 

# read -p "Enter image you to give to instances :  " image_name

# read -p "Enter the subnet id :  " subnet_id


# export KEY_NAME=$key_name
# export IMAGE_NAME=$image_name
# export SUBNET_NAME=$subnet_id

export KEY_NAME=boot-1
export IMAGE_NAME=ami-04a81a99f5ec58529
export SUBNET_NAME=subnet-0af822569e9483069

echo $key_name
echo $image_name
echo $subnet_id



# Run the provisioning playbook and capture output
ansible-playbook playbooks/provision-ec2.yml | tee provision-output.txt

# Extract IPs from the output
master_ip=$(grep 'Public IP: ' provision-output.txt | grep 'master' | awk '{print $NF}')
compute_ips=$(grep 'Public IPs: ' provision-output.txt | awk '{print $NF}' | tr -d '[],')

# Write to inventory file
cat <<EOL > inventory.ini
[master]
$master_ip ansible_ssh_user=ubuntu

[compute]
$compute_ips ansible_ssh_user=ubuntu

#[all:vars]
#ansible_ssh_private_key_file=/path/to/your/private-key.pem
EOL
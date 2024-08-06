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

# echo $key_name
# echo $image_name
# echo $subnet_id

# Run the provisioning playbook and capture output
ansible-playbook playbooks/provision-ec2.yml | tee provision-output.txt

echo "# ==================== "
echo ""
if echo $? == 0;
then
  echo "Instances Created successfully" 
fi
echo "# ==================== "


# # Extract IPs from the output
# master_ip=$(grep 'Public IP: ' provision-output.txt | grep 'master' | awk '{print $NF}')
# compute_ips=$(grep 'Public IPs: ' provision-output.txt | awk '{print $NF}' | tr -d '[],')


# give the permision to .pem ey
chmod 0600 ~/.ssh/boot-1.pem


# # Write to inventory file
# cat <<EOL > inventory.ini
# [master]
# $master_ip ansible_ssh_user=ubuntu

# [compute]
# $compute_ips ansible_ssh_user=ubuntu

# [all:vars]
# ansible_ssh_private_key_file=~/.ssh/boot-1.pem
# EOL



# Get private IPs
# id private_ip 

# aws ec2 describe-instances \
#     --query "Reservations[*].Instances[*].[InstanceId,PrivateIpAddress]" \
#     --output text > private_ips.txt


# id private_ip public_ip 
aws ec2 describe-instances \
    --query "Reservations[*].Instances[*].[InstanceId,PrivateIpAddress,PublicIpAddress]" \
    --output text | awk '{printf "%s %s %s\n", $1, $2, $3}' > instance_inventory_ips.txt


# Update /etc/hosts
echo "Updating /etc/hosts..."
# cat private_ips.txt | sudo tee -a /etc/hosts
cat instance_ips.txt 

echo "Update complete!"


#!/bin/bash

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
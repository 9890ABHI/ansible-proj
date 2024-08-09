# ansible-proj

create EC2 with .pem key
and create a subnet for /24 CIDR with auto assign ipv4 public IP
save these key and subnet ID 


```bash
apt update && apt upgrade
apt install python3-pip -y
apt install python3-boto -y  && apt install python3-boto3 -y
apt install ansible -y
```



now clone this git

```bash
git clone https://github.com/9890ABHI/ansible-proj.git
```

```bash

chmod -R +x ansible-proj

```


then copy your .pem key and paste in .ssh dir

```bash

nano boot-1.pem
chmod 0600 boot-1.pem

```


export you your key 
go to IAM in AWS 
create user 
give the full permission of EC2 


```bash

export AWS_ACCESS_KEY_ID='your-access-key-id'
export AWS_SECRET_ACCESS_KEY='your-secret-access-key'

```



then run 
```bash

./inventory.sh

```



#! /bin/bash
apt-get update
apt-get install -y software-properties-common 
apt-add-repository -y ppa:ansible/ansible
apt-get update
apt-get install -y ansible
wget https://bootstrap.pypa.io/get-pip.py
python get-pip.py
rm get-pip.py
python -m pip install boto3 botocore

mkdir ~/.aws
echo "[default]" > ~/.aws/credentials
echo "aws_access_key_id = ${access_key}" >> ~/.aws/credentials
echo "aws_secret_access_key = ${secret_key}" >> ~/.aws/credentials
echo "region = eu-central-1" >> ~/.aws/credentials
echo "123" >> /root/ans

mkdir /root/ansible
cd /root/ansible
git clone https://github.com/namepunk/ans.git .

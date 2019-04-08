#! /bin/bash
apt-get update
apt-get install -y python3-distutils
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py
rm get-pip.py
ln -s /usr/bin/python3 /usr/bin/python
python -m pip install PyMySQL
echo "${cert}"  >> /home/ubuntu/.ssh/authorized_keys

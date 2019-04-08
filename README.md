Использование:
1. Ставим terraform
2. mkdir terraform
3. cd terraform
4. git clone https://github.com/namepunk/tf2.git . 
4. ssh-keygen -f mykey
5. создаем файлик myname.auto.tfvars c содержимым

access_key = "insert_here_aws_access_key"

secret_key = "insert_here_aws_secret_key"

cert_pub = "mykey.pub"

cert_priv = "mykey"

6. terraform init
7. terraform apply
 Ждем около 10 минут пока все накатится и у балансера пройдут хелс чеки

ssh-keygen -t rsa -f ~/.ssh/appuser -C appuser -P ""

ssh -i ~/.ssh/appuser appuser@<внешний IP VM>

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/appuser

sh [-A #проброс сертификата] -J [username]35.208.230.134 #bastion_ip[:port] [username]10.128.0.3 #target_ip[:port]

Подключение через другой хост


Настройки ~/.ssh/config 

Host bastion-host-nick
  HostName 35.208.230.134

### The Remote Host
Host target-host-name
  HostName 10.128.0.3
  ProxyJump instance-1

bastion_IP = 35.208.230.134
someinternalhost_IP = 10.128.0.3


testapp_IP = 35.228.152.217
testapp_port = 9292


gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --metadata startup-script-url=gs://sdv-buck1/startup_script.sh

gcloud compute firewall-rules create open-tcp-9292 --allow=tcp:9292 --target-tags=puma-server


### Packer
packer validate -var-file variables.json ./appub18.json
packer build -var-file variables.json ./appub18.json
packer build -var 'project_id=serious-unison-288814' -var 'source_image_family=reddit-base' ./immutable.json


### Terraform
terraform init
terraform plan
terraform apply -auto-approve=true
terraform destroy
terraform show
terraform state show
terraform fmt

### Ansible
echo "ansible>=2.4">>requirements.txt
pip install -r requirements.txt
ansible appserver -i ./inventory -m ping
ansible dbserver -m command -a uptime
ansible all -m ping -i inventory.yml
ansible app -m shell -a "ruby -v; bundler -v"
ansible db -m systemd -a name=mongod
ansible db -m service -a name=mongod
ansible app -m git -a 'repo=https://github.com/express42/reddit.git dest=/home/appuser/reddit'
ansible-playbook clone.yml

ansible-playbook reddit_app.yml --check --limit db
ansible-playbook reddit_app.yml --limit app --tags deploy-tag # One playbok, one play
ansible-playbook reddit_app2.yml --tags deploy-tag #one playbook, some plays
ansible-playbook site.yml # multyple playbooks

ansible-galaxy init app
ansible-playbook -i environments/prod/inventory.py playbooks/site.yml

# Установка Community ролей 
ansible-galaxy install -r environments/stage/requirements.yml

# Шифруем файлы используя vault.key
ansible-vault encrypt environments/prod/credentials.yml
Для редактирования переменных нужно использовать
команду ansible-vault edit <file>
А для расшифровки: ansible-vault decrypt <file>

# Vagrant
export PATH="$PATH:/mnt/c/Program Files/Oracle/VirtualBox" && export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"

vagrant init
vagrant status --debug
vagrant up
vagrant destroy -f
vagrant ssh-config
vagrant ssh virtualservername

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

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



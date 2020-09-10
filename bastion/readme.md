sh [-A #проброс сертификата] -J [username]35.208.230.134 #bastion_ip[:port] [username]10.128.0.3 #target_ip[:port]

Подключение через другой хост


Настройки ~/.ssh/config 

Host bastion-host-nick
  HostName 35.208.230.134

### The Remote Host
Host target-host-name
  HostName 10.128.0.3
  ProxyJump instance-1


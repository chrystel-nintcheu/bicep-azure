# Create a azure VM for linux and container labs
Le fichier `main.bicep` appelle tous les modules.


## Étape 5 — main.bicep (fichier principal)


### 5.1 - Get my current codespace public IP address
**sourceAddressPrefix** in Azure Network Security Group (NSG) rules specifies the source IP address, IP range, or CIDR block from which network traffic is allowed or denied.
```
curl https://api64.ipify.org
```

or 

```
curl https://ifconfig.me

```


[Az cli references](https://aka.ms/cli_ref)


### Créer une paire de clé

```
ssh-keygen -t rsa -b 4096 -C "votre_email@example.com"
```

ssh-keygen -t rsa -b 4096 -C "chrystel.nintcheu@polymtl.ca"

puis, identifier l'emplacement
 /home/vscode/.ssh/

### Créer un ressource groupe

```
az group create --name dev-bicep-rg --location canadacentral
```

```
az deployment group create \
  --resource-group rg-p109903 \
  --template-file main.bicep \
  --parameters sshPublicKey="$(cat ~/.ssh/id_rsa.pub)" \
               adminUsername=azureuser \
               allowedSshIp="$(curl https://ifconfig.me)"

```


```
   ssh -i ~/.ssh/id_rsa <utilisateur>@<ip_ou_dns_de_la_vm>
```
  

az deployment group create --resource-group rg-p109903   --template-file destroy.bicep --mode Complete

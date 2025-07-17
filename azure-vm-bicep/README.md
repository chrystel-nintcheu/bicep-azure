# Création d'une VM Linux dans Azure depuis GitHub Codespaces

Le fichier de lancement est `main.bicep`.
[Az cli references](https://aka.ms/cli_ref)

## 1. Mettre à jour l'environnement bicep codespaces

```
az bicep upgrade
```

## 2. Créer votre pair de clés dans codespaces

```
ssh-keygen -t rsa -b 4096 -C "votre_email@example.com"
```

ssh-keygen -t rsa -b 4096 -C "chrystel.nintcheu@polymtl.ca"

puis, identifier l'emplacement

```
 /home/vscode/.ssh/
```

## 3. Identifier l'adresse IP public de votre session codespaces

L'adresse IP vous sera utile afin de compléter le fichier `parameters.json` car la connexion à la VM se fera depuis cet adresse seulement

**sourceAddressPrefix** in Azure Network Security Group (NSG) rules specifies the source IP address, IP range, or CIDR block from which network traffic is allowed or denied.

```
curl https://api64.ipify.org
```
or 
```
curl https://ifconfig.me

```


## 4. Créer un ressource groupe
[doc az group](https://learn.microsoft.com/en-us/cli/azure/group?view=azure-cli-latest#az_group_create)
[Identifier la liste des regions supportées par votre abonnement] (https://learn.microsoft.com/en-us/cli/azure/account?view=azure-cli-latest#az-account-list-locations)
```
az account list-locations --output table
```
### 4.1 Créer votre rg dans la région de votre choix

> Exemple de region : canadacentral (Toronto), canadaeast (Québec)

```
az group create --name rg-<azregion>-<sequence> --location <azregion> --debug
```

Consulter le résultat

```
az group list --output table
```

## 5. Déployer la VM
### 5.1 - Déploiement - option 1 (Recommandé)

```
az deployment group create \
  --resource-group <ton_rg> \
  --template-file main.bicep \
  --parameters @parameters.json
  --debug
```

### 5.2 - Déploiement - option 2

```
az deployment group create \
  --resource-group <ton_rg> \
  --template-file main.bicep \
  --parameters sshPublicKey="$(cat ~/.ssh/id_rsa.pub)" \
               adminUsername=<username_vm> \
               allowedSshIp=<your_codespaces_publicIP> \
               vnetAddressPrefix="10.0.0.0/16"
               subnetPrefix="10.0.0.0/24"
  --debug
```

## 6. Se connecter à la VM

L'usager de la VM est celui du `<adminUsername>`

```
   ssh -i ~/.ssh/id_rsa <username_vm>@<ip_ou_dns_de_la_vm>
```


# 7. Détruire les ressources (important)

## Supprimer la VM et les ressources associées
az deployment group create --resource-group <ton_rg>  --template-file destroy.bicep --mode Complete --debug

## Supprimer le rg
az group delete <ton_rg>

### Approche plus drastique
Supprime le rg et toutes les VMs associées en une fois

```
az group delete -n <ton_rg> --force-deletion-types Microsoft.Compute/virtualMachines
```
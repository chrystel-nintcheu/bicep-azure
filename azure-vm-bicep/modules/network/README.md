# Création du module network

## Étape 1 — modules/network/network.bicep

Ce module crée :
- VNet
- Subnet
- NSG (avec règle SSH limitée à une IP source)

## Étape 2 — modules/network/publicIp.bicep

Création d’une IP publique pour la VM.
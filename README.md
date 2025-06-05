# How to create a Bicep Dev Container in GitHub Codespaces
> You can run Bicep in a GitHub Codespace, and it's a great way to work with infrastructure-as-code in a cloud-based development environment. Here's how you can set it up

**1. Create a GitHub Repository**
>Start with a GitHub repo where you want to store your Bicep files.

**2. Add a .devcontainer Configuration**
>To enable Bicep in Codespaces, you need to configure a Dev Container that installs the necessary tools.

Create a `.devcontainer/devcontainer.json` file like this:

```json
{
  "name": "Bicep Dev Container",
  "image": "mcr.microsoft.com/devcontainers/dotnet:7.0",
  "features": {
    "ghcr.io/devcontainers/features/bicep:1": {}
  },
  "postCreateCommand": "az bicep install"
}
```

This configuration:

Uses a .NET container (required for Bicep CLI).
Installs the Azure CLI.
Installs the Bicep CLI via az bicep install.

**3. Add Your Bicep Files**
> Place your `.bicep` files in the repo. For example:
```
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
  name: 'mystorageaccount'
  location: 'eastus'
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    supportsHttpsTrafficOnly: true
  }
}
```

**4 . Open in Codespaces**
- Go to your repo on GitHub.
- Click the green "**Code**" button → "**Codespaces**" → "**Create codespace on main**".

**5. (Optional) Validate Bicep**
Once inside the Codespace terminal, you can run:

```
az bicep build --file <votre-fichier>.bicep

```

**6. Deploy your resource**
```
az login
az group create --location <region> --resource-group <your-rg>
az deployment group create --resource-group <your-rg> --template-file <votre-fichier>.bicep --verbose
```

**7. Destroy your resource**

Comment the instruction inside `<votre-fichier>.bicep` then, save it

```
// resource storageAccount 'Microsoft.Storage/storageAccounts@2023-05-01' = {
//   name: 'mystorageaccount'
//   location: 'eastus'
//   sku: {
//     name: 'Standard_LRS'
//   }
//   kind: 'StorageV2'
//   properties: {
//     accessTier: 'Hot'
//     supportsHttpsTrafficOnly: true
//   }
// }

```

Then, deploy the file again with the command:

```
az deployment group create \
  --resource-group <your-rg> \
  --template-file <votre-fichier>.bicep \
  --mode Complete
  --verbose
```

Visual studio extension: 
https://marketplace.visualstudio.com/
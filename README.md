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

```resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: 'mystorageacct'
  location: resourceGroup().location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}
```

**4 . Open in Codespaces**
- Go to your repo on GitHub.
- Click the green "**Code**" button → "**Codespaces**" → "**Create codespace on main**".

**5. Validate Bicep**
Once inside the Codespace terminal, you can run:

```
az bicep build --file main.bicep

```

**6. Deploy your resource**
```
az login
az deployment group create --resource-group <your-rg> --template-file main.bicep


# Azure Bastion
**Use the Azure CLI to deploy Azure Bastion**

Create the Azure Bastion subnet
```bash
az network vnet subnet create \
  --resource-group myBastionRG \
  --vnet-name MyVirtualNetwork \
  --name AzureBastionSubnet \
  --address-prefixes 10.0.2.0/24
```

Create a public IP address
```bash
az network public-ip create
  --resource-group MyResourceGroup \
  --name MyPublicIp \
  --sku Standard \
  --location westus2
```

Create the Bestion resource
```bash
az network bastion create \
  --name MyBastion \
  --public-ip-address MyPublicIp \
  --resource-group MyResourceGroup \
  --vnet-name MyVnet \
  --location westus2
```

# Create and connect to an Azure Files share

Create a storage account with the Azure CLI

```bash
az storage account create \
--name <unique account name> \
--resource-group <resource group name> \
--sku Standard_GRS
```

Create a file share

```bash
az storage share create \
--account-name <unique account name> \
--account-key <account key> \
--name <share name>
```

## Create a GRS storage account

Create a storage account

```bash
export STORAGEACCT=learnazurefileshare$RANDOM

az storage account create \
    --name $STORAGEACCT \
    --resource-group learn-5be8a5eb-e6bf-45b0-a18e-46dbaf2b9108 \
    --sku Standard_GRS
```

Save the storage account key

```bash
STORAGEKEY=$(az storage account keys list \
    --resource-group learn-5be8a5eb-e6bf-45b0-a18e-46dbaf2b9108 \
    --account-name $STORAGEACCT \
    --query "[0].value" | tr -d '"')
```

## Create file shares

Create file shares

```bash
az storage share create \
    --account-name $STORAGEACCT \
    --account-key $STORAGEKEY \
    --name "reports"
    
az storage share create \
    --account-name $STORAGEACCT \
    --account-key $STORAGEKEY \
    --name "data"
```

## Create and connect to a Windows server

```bash
az vm create \
    --resource-group learn-5be8a5eb-e6bf-45b0-a18e-46dbaf2b9108 \
    --name 2019FileServer \
    --image Win2019Datacenter \
    --admin-username azureuser
```


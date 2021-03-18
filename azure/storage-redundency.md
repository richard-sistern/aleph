# Data Redundancy

Available storage options

| Type    | Copies | Use case                                                     |
| ------- | ------ | ------------------------------------------------------------ |
| LRS     | 3      | Data remains highly available, but for compliance reasons, isn't allowed to leave the local data centre. |
| GRS     | 6      | App has access to the data, even if an entire region has an outage. |
| RA-GRS  | 6      | App reads from multiple geographical locations, so you can serve users from a location that's closer to them. |
| ZRS     | 3      | Need redundancy in multiple physical locations, but because of compliance, data isn't allowed to leave a region. |
| GZRS    | 6      | App can access data, even if the primary region has failed, and your secondary region has a data centre that's experiencing an outage. But you don't want to read from the secondary region unless the primary region is down. |
| RA-GZRS | 6      | Regularly read data from your secondary region, perhaps to serve users from a location closer to them, even if a data centre is up in your primary region. |

Convert a storage account

```powershell
Set-AzStorageAccount -ResourceGroupName <resource-group> -AccountName <storage-account> -SkuName "Standard_GZRS"
```

## Create a storage account

```bash
export RESOURCEGROUP=learn-storage-replication-rg

export AZURE_STORAGE_ACCOUNT=<storageaccountname>

export LOCATION=westus2

az group create --name $RESOURCEGROUP --location $LOCATION

az storage account create \
--name $AZURE_STORAGE_ACCOUNT \
--resource-group $RESOURCEGROUP \
--location $LOCATION \
--sku Standard_GZRS \
--encryption-services blob \
--kind StorageV2

az storage account keys list \
--account-name $AZURE_STORAGE_ACCOUNT \
--resource-group $RESOURCEGROUP \
--output table

export AZURE_STORAGE_KEY="<account-key>"
```

## Create a blob container

```bash
export BLOB_CONTAINER_NAME=<blob-container-name>

az storage container create --account-key $AZURE_STORAGE_KEY --account-name $AZURE_STORAGE_ACCOUNT --name $BLOB_CONTAINER_NAME
```

## Create a file (blob)

```bash
cat > song.mp3

cat song.mp3
```

## Upload the file

```bash
az storage blob upload \
    --container-name $BLOB_CONTAINER_NAME \
    --name song \
    --file song.mp3
    
az storage blob list \
--container-name $BLOB_CONTAINER_NAME  \
--output table
```


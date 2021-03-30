# Azure Immersion Workshop: Data Modernisation

Enable service broker and change recovery model to full

```sql
USE master;
GO

-- Update the recovery model of the database to FULL and enable Service Broker
ALTER DATABASE WideWorldImporters SET
RECOVERY FULL,
ENABLE_BROKER WITH ROLLBACK IMMEDIATE;
GO

```

Retrieve public IP for SQL 2008 VM

```bash
$resourceGroup = "<your-resource-group-name>"
az vm list-ip-addresses -g $resourceGroup -n Sql2008-SUFFIX --output table
```

Create a new transaction log backup

```sql
USE master;
GO

BACKUP LOG WideWorldImporters
TO DISK = 'c:\dms-backups\WideWorldImportersLog.trn'
WITH CHECKSUM
GO
```

Retrieve information about SQL Managed Instance

```bash
$resourceGroup = "<your-resource-group-name>"
az sql mi list --resource-group $resourceGroup

```

Enable transparent encryption

```sql
USE WideWorldImportersSUFFIX;
GO

ALTER DATABASE [WideWorldImportersSUFFIX] SET ENCRYPTION ON

--verify
SELECT * FROM sys.dm_database_encryption_keys
```

## Dynamic Data Masking

Create a user to test with

```sql
USE [WideWorldImportersSUFFIX];
GO

--create account
CREATE USER DDMUser WITHOUT LOGIN;
GRANT SELECT ON [Sales].[CreditCard] TO DDMUser;

--verify account
EXECUTE AS USER = 'DDMUser';
SELECT TOP 10 * FROM [Sales].[CreditCard];
REVERT;
```

Apply a DDM to the card number field

```sql
ALTER TABLE [Sales].[CreditCard]
ALTER COLUMN [CardNumber] NVARCHAR(25) MASKED WITH (FUNCTION = 'partial(0,"xxx-xxx-xxx-",4)')

--verify ddm
ALTER TABLE [Sales].[CreditCard]
ALTER COLUMN [CardNumber] NVARCHAR(25) MASKED WITH (FUNCTION = 'partial(0,"xxx-xxx-xxx-",4)')
```

Apply a DDM to email address

```sql
--show initial table state
SELECT TOP 10 * FROM [dbo].[Gamer];

--grant access to DDMUser
GRANT SELECT ON [dbo].[Gamer] to DDMUser;

--apply DDM
ALTER TABLE [dbo].[Gamer]
ALTER COLUMN [LoginEmail] NVARCHAR(250) MASKED WITH (FUNCTION = 'Email()');

--verify DDM
EXECUTE AS USER = 'DDMUser';
SELECT top 10 * FROM [dbo].[Gamer];
REVERT;
```
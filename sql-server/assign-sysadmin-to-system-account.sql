-- Assign sysadmin permission to local SYSTEM account
IF NOT EXISTS (
    SELECT name
    FROM master.sys.server_principals
    WHERE IS_SRVROLEMEMBER ('sysadmin', name) = 1
    AND name LIKE 'NT AUTHORITY\SYSTEM'
)
EXEC master..sp_addsrvrolemember
@loginame = N'NT AUTHORITY\SYSTEM', @rolename = N'sysadmin'

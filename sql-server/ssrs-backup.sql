-- To permit log backups, before the full database backup, alter the database
-- to use the full recovery model.
USE master;
GO
ALTER DATABASE ReportServer
   SET RECOVERY FULL

-- If the ReportServerData device does not exist yet, create it.
USE master
GO
EXEC sp_addumpdevice 'disk', 'ReportServerData',
'D:\Backup\SSRS\ReportServerData.bak'

-- Create a logical backup device, ReportServerLog.
USE master
GO
EXEC sp_addumpdevice 'disk', 'ReportServerLog',
'D:\Backup\SSRS\ReportServerLog.bak'

-- Back up the full ReportServer database.
BACKUP DATABASE ReportServer
   TO ReportServerData
   WITH COPY_ONLY

-- Back up the ReportServer log.
BACKUP LOG ReportServer
   TO ReportServerLog
   WITH COPY_ONLY

-- To permit log backups, before the full database backup, alter the database
-- to use the full recovery model.
USE master;
GO
ALTER DATABASE ReportServerTempdb
   SET RECOVERY FULL

-- If the ReportServerTempDBData device does not exist yet, create it.
USE master
GO
EXEC sp_addumpdevice 'disk', 'ReportServerTempDBData',
'D:\Backup\SSRS\ReportServerTempDBData.bak'

-- Create a logical backup device, ReportServerTempDBLog.
USE master
GO
EXEC sp_addumpdevice 'disk', 'ReportServerTempDBLog',
'D:\Backup\SSRS\ReportServerTempDBLog.bak'

-- Back up the full ReportServerTempDB database.
BACKUP DATABASE ReportServerTempDB
   TO ReportServerTempDBData
   WITH COPY_ONLY

-- Back up the ReportServerTempDB log.
BACKUP LOG ReportServerTempDB
   TO ReportServerTempDBLog
   WITH COPY_ONLY

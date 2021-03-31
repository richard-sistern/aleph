-- Restore the report server database and move to new instance folder   
RESTORE DATABASE ReportServer
   FROM DISK='D:\SSRS\ReportServerData.bak'
   WITH NORECOVERY,
      MOVE 'ReportServer' TO
         'D:\DATA\ReportServer.mdf',
      MOVE 'ReportServer_log' TO
         'L:\LOGS\ReportServer_Log.ldf';
GO

-- Restore the report server log file to new instance folder
RESTORE LOG ReportServer
   FROM DISK='D:\SSRS\ReportServerData.bak'
   WITH NORECOVERY, FILE=2
      MOVE 'ReportServer' TO
         'D:\DATA\ReportServer.mdf',
      MOVE 'ReportServer_log' TO
         'L:\LOGS\ReportServer_Log.ldf';
GO

-- Restore and move the report server temporary database
RESTORE DATABASE ReportServerTempdb
   FROM DISK='D:\SSRS\ReportServerTempDBData.bak'
   WITH NORECOVERY,
      MOVE 'ReportServerTempDB' TO
         'D:\DATA\ReportServerTempDB.mdf',
      MOVE 'ReportServerTempDB_log' TO
         'L:\LOGS\ReportServerTempDB_Log.ldf';
GO

-- Restore the temporary database log file to new instance folder
RESTORE LOG ReportServerTempdb
   FROM DISK='D:\SSRS\ReportServerTempDBData.bak'
   WITH NORECOVERY, FILE=2
      MOVE 'ReportServerTempDB' TO
         'D:\DATA\ReportServerTempDB.mdf',
      MOVE 'ReportServerTempDB_log' TO
         'L:\LOGS\ReportServerTempDB_Log.ldf';
GO

-- Perform final restore
RESTORE DATABASE ReportServer
   WITH RECOVERY
GO

-- Perform final restore
RESTORE DATABASE ReportServerTempDB
   WITH RECOVERY
GO

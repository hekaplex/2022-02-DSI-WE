/*
SQL has some new Windows 11 security issues that 
require a couple of steps.

This will only affect Windows 11 users not users
of the VMs

1. Find the SQL Server Path install by
    looking at the "services.msc"
2.  Locate the Backup, Log and Data
https://docs.microsoft.com/en-us/sql/sql-server/install/file-locations-for-default-and-named-instances-of-sql-server?view=sql-server-ver15#:~:text=The%20directory%20structure%20for%20a,Server%5CMSSQL%7Bnn%7D.

3. Move .bak files into the Backup directory 
4. Adapt script to do restores
*/
RESTORE FILELISTONLY FROM DISK ='C:\Users\Temitope''s PC\Desktop\Divergence-DSI\MSSQL15.MSSQLSERVER\MSSQL\Backup\MurachCollege.bak'

LogicalName	PhysicalName	Type	FileGroupName	Size	MaxSize	FileId	CreateLSN	DropLSN	UniqueId	ReadOnlyLSN	ReadWriteLSN	BackupSizeInBytes	SourceBlockSize	FileGroupId	LogGroupGUID	DifferentialBaseLSN	DifferentialBaseGUID	IsReadOnly	IsPresent	TDEThumbprint	SnapshotUrl
AdventureWorks2017	C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019\MSSQL\DATA\AdventureWorks2019.mdf	D	PRIMARY	276824064	35184372080640	1	0	0	733940A8-D019-4DC5-80F8-13E869A504EC	0	0	215678976	4096	1	NULL	39000002354400001	A44F7D23-17A1-49BE-BC7E-F5D68E5FDDC4	0	1	NULL	NULL
AdventureWorks2017_log	C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019\MSSQL\DATA\AdventureWorks2019_log.ldf	L	NULL	75497472	2199023255552	2	0	0	B166C891-E43F-42DA-87FC-8D7F34022B35	0	0	0	4096	0	NULL	0	00000000-0000-0000-0000-000000000000	0	1	NULL	NULL

RESTORE DATABASE AdventureWorks2019
FROM DISK = 'C:\Users\Temitope''s PC\Desktop\Divergence-DSI\MSSQL15.MSSQLSERVER\MSSQL\Backup\AdventureWorks2019 (2).bak'
WITH MOVE 'AdventureWorks2017' to 'C:\Users\Temitope''s PC\Desktop\Divergence-DSI\MSSQL15.MSSQLSERVER\MSSQL\Data\AdventureWorks2019.mdf',
MOVE 'AdventureWorks2017_log' to 'C:\Users\Temitope''s PC\Desktop\Divergence-DSI\MSSQL15.MSSQLSERVER\MSSQL\Log\AdventureWorks2019.ldf'


RESTORE DATABASE AdventureWorksDW2019
FROM DISK = 'C:\Users\Temitope''s PC\Desktop\Divergence-DSI\MSSQL15.MSSQLSERVER\MSSQL\Backup\AdventureWorksDW2019.bak'
WITH MOVE 'AdventureWorksDW2017' to 'C:\Users\Temitope''s PC\Desktop\Divergence-DSI\MSSQL15.MSSQLSERVER\MSSQL\Data\AdventureWorksDW2019.mdf',
MOVE 'AdventureWorksDW2017_log' to 'C:\Users\Temitope''s PC\Desktop\Divergence-DSI\MSSQL15.MSSQLSERVER\MSSQL\Log\AdventureWorksDW2019.ldf'

RESTORE DATABASE MurachCollege
FROM DISK = 'C:\Users\Temitope''s PC\Desktop\Divergence-DSI\MSSQL15.MSSQLSERVER\MSSQL\Backup\MurachCollege.bak'
WITH MOVE 'MurachCollege' to 'C:\Users\Temitope''s PC\Desktop\Divergence-DSI\MSSQL15.MSSQLSERVER\MSSQL\Data\MurachCollege.mdf',
MOVE 'MurachCollege_log' to 'C:\Users\Temitope''s PC\Desktop\Divergence-DSI\MSSQL15.MSSQLSERVER\MSSQL\Log\MurachCollege.ldf'
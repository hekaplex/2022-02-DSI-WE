USE master
GO
DROP DATABASE MyPartitionPracticeDB
GO
CREATE DATABASE MyPartitionPracticeDB
ON PRIMARY
( NAME = db_dat,
FILENAME = 'c:\PartitionPractice\db.mdf',
SIZE = 4MB),
FILEGROUP FG1
( NAME = FG1_dat,
FILENAME = 'c:\PartitionPractice\FG1.ndf',
SIZE = 2MB),
FILEGROUP FG3
( NAME = FG3_dat,
FILENAME = 'c:\PartitionPractice\FG3.ndf',
SIZE = 2MB),
FILEGROUP FG4
( NAME = FG4_dat,
FILENAME = 'c:\PartitionPractice\FG4.ndf',
SIZE = 2MB),
FILEGROUP FG5
( NAME = FG5_dat,
FILENAME = 'c:\PartitionPractice\FG5.ndf',
SIZE = 2MB),
FILEGROUP FG6
( NAME = FG6_dat,
FILENAME = 'c:\PartitionPractice\FG6.ndf',
SIZE = 2MB),
FILEGROUP FG7
( NAME = FG7_dat,
FILENAME = 'c:\PartitionPractice\FG7.ndf',
SIZE = 2MB),
FILEGROUP FG2
( NAME = FG2_dat,
FILENAME = 'c:\PartitionPractice\FG2.ndf',
SIZE = 2MB)
LOG ON
( NAME = db_log,
FILENAME = 'c:\PartitionPractice\log.ndf',
SIZE = 2MB,
FILEGROWTH = 2MB );
GO
USE MyPartitionPracticeDB
GO
--1. STEP # 01 (Create partition function)

CREATE PARTITION FUNCTION partfunc (int) AS
RANGE LEFT FOR VALUES (1000, 2000, 3000, 4000, 5000);

--2. STEP # 02 (Create partition scheme)

CREATE PARTITION SCHEME MyPartitionScheme AS
PARTITION partfunc TO
([FG1], [FG2],[FG3], [FG4],[FG5],FG6,FG7)
GO
--3. STEP # 03 (Create table or index based on the partition scheme)
--The important clause related to partitioning is 
--ON clause in CREATE TABLE statement. 

CREATE TABLE MyPartionedTable
(
 ID int PRIMARY KEY,
 Name VARCHAR(50)
)
ON 
MyPartitionScheme(ID)

--4. STEP # 04 Split Partitions
ALTER PARTITION FUNCTION partfunc()
SPLIT RANGE (3500)

--5. STEP # 05 Remove Partition
ALTER PARTITION FUNCTION partfunc ()
MERGE RANGE (3500)

--DROP TABLE MyNewPartTable

CREATE TABLE MyNewPartTable6
(
 ID int PRIMARY KEY,
 Name VARCHAR(50)
)
ON FG5
--6. STEP # 06 Switch in
ALTER TABLE MyNewPartTable6 switch TO MyPartionedTable PARTITION 5

--7. STEP # 07 Switch out
ALTER TABLE MyPartionedTable switch PARTITION 5 TO MyNewPartTable6

--8. STEP # 08 Parallelism
SELECT * FROM MyPartionedTable
ORDER BY [Name] DESC
OPTION (MAXDOP 4)

--9. STEP # 09 plan guide
EXEC sp_create_plan_guide 
 @name = N'Guide1', 
 @stmt = N'SELECT * FROM MyPartionedTable
 ORDER BY [Name] DESC', 
 @type = N'SQL',
 @module_or_batch = NULL, 
 @params = NULL, 
 @hints = N'OPTION (MAXDOP 4)';

 --10 STEP # 10 configuration
 sp_configure 'show advanced options', 1;
GO
RECONFIGURE WITH OVERRIDE;
GO
sp_configure 'max degree of parallelism', 4;
GO
RECONFIGURE WITH OVERRIDE;
GO
SELECT * FROM SYS.CONFIGURATIONS
WHERE NAME = 'max worker threads'
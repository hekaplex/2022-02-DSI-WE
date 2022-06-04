CREATE TABLE employees (
    employee_id   NUMERIC       NOT NULL,
    first_name    VARCHAR(1000) NOT NULL,
    last_name     VARCHAR(900)  NOT NULL,
    date_of_birth DATE                   ,
    phone_number  VARCHAR(1000) NOT NULL,
    junk          CHAR(1000)             ,
    CONSTRAINT employees_pk
       PRIMARY KEY NONCLUSTERED (employee_id)
);

select 
* from sys.indexes where object_id 
=object_id('employees')

CREATE TABLE employees2 (
    employee_id   NUMERIC       NOT NULL,
    first_name    VARCHAR(1000) NOT NULL,
    last_name     VARCHAR(900)  NOT NULL,
    date_of_birth DATE                   ,
    phone_number  VARCHAR(1000) NOT NULL,
    junk          CHAR(1000)             ,
    CONSTRAINT employees2_pk
       PRIMARY KEY  (employee_id)
);

select 
* from sys.indexes where object_id 
=object_id('employees2')

sp_help employees2
[dbo].[DatabaseLog]
CREATE TABLE txn2 (
    employee_id   NUMERIC       NOT NULL,
    txn_id    NUMERIC       NOT NULL ,
    CONSTRAINT tx_id
       PRIMARY KEY (txn_id)
);

ALTER TABLE txn2 
WITH CHECK 
ADD  CONSTRAINT txn2_empl
FOREIGN KEY([employee_id])
REFERENCES employees2(employee_id)

select 
* from sys.indexes where object_id 
=object_id('txn2')

ALTER TABLE txn2 
DROP CONSTRAINT txn2_empl


ALTER TABLE txn2 
WITH CHECK 
ADD  CONSTRAINT txn2_empl
FOREIGN KEY ([employee_id])
REFERENCES employees2(employee_id)


CREATE 
	NONCLUSTERED INDEX 
		[AK_txn2_employee] 
	ON 
	txn2
	(
		[employee_id] ASC
	)

		WITH (
				PAD_INDEX = OFF
				, STATISTICS_NORECOMPUTE = OFF
				, SORT_IN_TEMPDB = OFF
				, IGNORE_DUP_KEY = OFF
				, DROP_EXISTING = OFF
				, ONLINE = OFF
				, ALLOW_ROW_LOCKS = ON
				, ALLOW_PAGE_LOCKS = ON
				
				, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF
				) ON [PRIMARY]
GO

CREATE STATISTICS txn2_stats  
    ON txn2(employee_id)  


--indexes not being used
	SELECT TableName = OBJECT_SCHEMA_NAME(s.OBJECT_ID, db_id()) 	+ '.' + OBJECT_NAME(s.OBJECT_ID)
     , IndexName = i.NAME
     , READS = user_seeks + user_scans + user_lookups
     , WRITES = user_updates
     , p.ROWS
     , k.partition_number
     , IndexSizeMB = (k.used_page_count * 8) / 1024
FROM sys.dm_db_index_usage_stats s
INNER JOIN sys.indexes i ON i.index_id = s.index_id
     AND s.OBJECT_ID = i.OBJECT_ID
INNER JOIN sys.partitions p ON p.index_id = s.index_id
     AND s.OBJECT_ID = p.OBJECT_ID
INNER JOIN sys.dm_db_partition_stats k ON k.index_id = i.index_id
     AND k.OBJECT_ID = i.OBJECT_ID
WHERE OBJECTPROPERTY(s.OBJECT_ID, 'IsUserTable') = 1
     AND s.database_id = DB_ID()
     AND i.type_desc = 'nonclustered'
     AND i.is_primary_key = 0
     AND i.is_unique_constraint = 0
     AND p.ROWS > 10000
     AND user_seeks + user_scans + user_lookups = 0
ORDER BY READS, WRITES DESC, ROWS DESC

set showplan_xml off

select * from sys.partitions 

select * from sys.dm_db_partition_stats

select * from INFORMATION_SCHEMA.COLUMNS order by DATA_TYPE

select * from sys.dm_db_missing_index_details

exec master..xp_readerrorlog

SELECT * FROM sys.dm_db_index_physical_stats  
    (DB_ID(N'Adventureworks2019'), OBJECT_ID(N'Person.Address'), NULL, NULL , 'DETAILED');  

--hack for writing SQl from a query
SELECT DISTINCT 'DROP TABLE ' + TABLE_NAME + '
GO' from INFORMATION_SCHEMA.COLUMNS

SELECT * FROM INFORMATION_SCHEMA.CONSTRAINT_COLUMN_USAGE


SELECT TOP 100
         SUBSTRING(t.text, (s .statement_start_offset/ 2)+1 ,
                ((CASE s.statement_end_offset
                   WHEN - 1 THEN DATALENGTH(t.text)
                 ELSE s.statement_end_offset
              END - s.statement_start_offset )/2) + 1 ) AS statement_text
        , DB_NAME (t.dbid) AS [db_name]
        , 1.00* s.total_elapsed_time / DATEDIFF (second, s.creation_time, GETDATE ()) / 1 AS percent_used_time
        , DATEDIFF (HOUR, s.creation_time, GETDATE()) AS cached_hours
        , s.execution_count
        , 1.00* s.execution_count / ( 1+DATEDIFF (HOUR, s.creation_time, GETDATE())) AS executions_per_hour
        , s.max_elapsed_time
        , ISNULL (s.total_elapsed_time / s.execution_count, 0) AS avg_elapsed_time
        , s.total_elapsed_time
        , s.creation_time
        , s.last_execution_time
        , s.sql_handle
        , s.plan_handle
        , c.most_recent_session_id
        , c.parent_connection_id
        , c.session_id
FROM sys .dm_exec_query_stats s
        CROSS APPLY sys. dm_exec_sql_text( s .sql_handle ) t
        LEFT JOIN sys. dm_exec_connections c
               ON c. most_recent_sql_handle = s .sql_handle
WHERE s. execution_count > 1 AND DATEDIFF (second, creation_time,GETDATE ())>0
ORDER BY 9 DESC --total_elapsed_time


select * from sys.sysprocesses
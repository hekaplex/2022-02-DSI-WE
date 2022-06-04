select * from [Production].[vProductAndDescription]

select @@version

--removes execution plans
dbcc freeproccache
;

--pushing all data out of memory
dbcc dropcleanbuffers
;

select * from sysprocesses

select * from sys.indexes

select 
	d.* from FactFinance f
 inner merge join DimAccount d
on d.AccountKey
= f.AccountKey
where
--SARG = Search Argument =OVER, WHERE, HAVING, ON
-- NOT using native data types - weakly typed or Non-SARGABLE
CAST(f.AccountKey  as varchar(20)) between '65' and '68'
--using native datatypes - strongly typed query
--f.AccountKey between 65 and 68

--BEFORE: 153 ms. 78.453% improvement

--CAST(f.AccountKey  as varchar(20))= '66' index scan when we had covering index
--f.DepartmentGroupKey = 2 table scan
--d.AccountType = 'Expenditures' index scan

select @@spid

SET STATISTICS PROFILE ON
SET STATISTICS TIME ON
SET STATISTICS IO ON

select object_name (object_id), count(*) 
from sys.indexes
group by object_name (object_id)
order by 2 desc


SET STATISTICS PROFILE OFF
SET STATISTICS TIME OFF
SET STATISTICS IO OFF

SET STATISTICS PROFILE ON
SET STATISTICS TIME ON
SET STATISTICS IO ON
--RULE #1: Have a covering index for your predicates
--WHERE clauses and the ON clause in a JOIN 
--RULE #2: Prepare to add NC indexes to foreign keys
--RULE #3: Profile, Review plans and manage stats
--RULE #4: Profile, Review plans and manage index
--RULE #5: Composite indexes need statistics on secondary columns
--RULE #6: Always use the native data type of a column in a seach arg
--RULE #7: Convert UDF(User-Defined Functions) to stored procedures and tables when possible
--RULE #8: Temporary objects may need indexes too (dev in normal tables first)

DBCC SHOW_STATISTICS('[Production].[vProductAndDescription]',[IX_vProductAndDescription])

sp_help FactFinance


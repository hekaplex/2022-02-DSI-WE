--initial check on table names

select new.TABLE_NAME , old.TABLE_NAME old
from [AdventureWorksDW].INFORMATION_SCHEMA.TABLES new
FULL JOIN [AdventureWorksDW2019].INFORMATION_SCHEMA.TABLES old
on old.TABLE_NAME = new.TABLE_NAME  

-- sanity check on col numbers between databases
with
newcol as
	(
	SELECT
		TABLE_NAME new, count(*)	newqty
	from [AdventureWorksDW].INFORMATION_SCHEMA.COLUMNS 
	GROUP BY TABLE_NAME
	)
	,
oldcol 
	AS
	(
		SELECT
		TABLE_NAME old, count(*)	oldqty
	from [AdventureWorksDW2019].INFORMATION_SCHEMA.COLUMNS old
	GROUP BY old.TABLE_NAME
)
SELECT *
from
	newcol
JOIN 
	oldcol
on oldcol.old = newcol.new

SELECT *  from [AdventureWorksDW2019].INFORMATION_SCHEMA.COLUMNS

--changes in column names
select 
	new.TABLE_NAME newtbl
,	new.COLUMN_NAME  newcol
,	old.TABLE_NAME oldtbl
,	old.COLUMN_NAME oldcol

from [AdventureWorksDW].INFORMATION_SCHEMA.COLUMNS new
FULL JOIN [AdventureWorksDW2019].INFORMATION_SCHEMA.COLUMNS old
on old.TABLE_NAME = new.TABLE_NAME  
AND 	new.COLUMN_NAME =	old.COLUMN_NAME

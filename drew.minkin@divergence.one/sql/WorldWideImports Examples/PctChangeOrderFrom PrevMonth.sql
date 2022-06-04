/****** Script for SelectTopNRows command from SSMS  ******/
WITH Base
AS
(SELECT YEAR([Order Date Key]) SalesYear
      ,Month([Order Date Key]) SalesMonth
	  ,[Salesperson Key] RepID
      ,SUM([Total Excluding Tax]) [SalesTotal]
  FROM [WideWorldImportersDW].[Fact].[Order]
  GROUP BY 
  YEAR([Order Date Key]) 
      ,Month([Order Date Key]) 
	  ,[Salesperson Key]
)
SELECT
RepID
,SalesYear
,SalesMonth
,LAG([SalesTotal],1,0) 
	OVER 
		(
			PARTITION BY [RepID] 
			ORDER BY [SalesYear],SalesMonth
			) 
	As LastSales
, 
--ChangeFromLastSales = For RepID, Current Year's SalesTotal- LastSales (Last Year's SalesTotal)
	[SalesTotal] 
	- LAG([SalesTotal],1,0) 
		OVER 
			(
				PARTITION BY [RepID] 
				ORDER BY [SalesYear],SalesMonth
			) 
	As ChangeFromLastSales
, 
--PctChangeFromLastSales = (Current Year's SalesTotal - LastSales )/LastSales 
IIF(
	--check for divide by 0
			LAG([SalesTotal],1,0) 
			OVER 
				(
					PARTITION BY [RepID] 
					ORDER BY [SalesYear],SalesMonth
				) 
					!= 0,
		(
		[SalesTotal] 
		- LAG([SalesTotal],1,0)
			OVER 
				(
					PARTITION BY [RepID] 
					ORDER BY [SalesYear],SalesMonth
				)
		)
		/
			LAG([SalesTotal],1,0) 
			OVER 
				(
					PARTITION BY [RepID] 
					ORDER BY [SalesYear]
				)
	,
	NULL
	)
	As PctChangeFromLastSales
from Base
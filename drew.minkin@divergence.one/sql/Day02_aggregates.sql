use AP
go


--CREATE VIEW v_vendorsInvoices
--AS
--Invoices has Vendors 
select 
	v.VendorID
	,v.VendorName
	,i.InvoiceNumber

from
	Vendors AS v
--inner join implicitly
--join
	,Invoices AS i
--on
where
	v.VendorID = i.VendorID

--vendors with no invoices
select 
	v.VendorID
	,v.VendorName
	,i.InvoiceNumber

from
	Vendors AS v
left outer join
	Invoices AS i
on
	v.VendorID = i.VendorID
where
	i.InvoiceNumber IS  NULL

--invoices with no vendors 
Select distinct derived_table.VendorName
from (select 
	v.VendorID
	,v.VendorName
	,i.InvoiceNumber

from
	(SELECT * from Vendors where DefaultTermsID = 1) v
left outer join
	Invoices AS i
on
	v.VendorID = i.VendorID
) derived_table
	

	select 
	v.VendorID
	,v.VendorName
	,i.InvoiceNumber
	, CASE 
		WHEN I.InvoiceNumber IS NULL
			THEN 1
		ELSE 0
	END 
		as boolIsSuccessful

from
	Vendors AS v
left join
	Invoices AS i
on
	v.VendorID = i.VendorID

select 
	v.VendorName
	,i.InvoiceNumber

from
	Vendors v
join
	Invoices i
on
	v.VendorID = i.VendorID



declare @x int = 4
declare @y int = 5

select @x * @y


CREATE TABLE [some table]
(col1 int )


select * from `some table`

use examples

SELECT
DeptName
,LastName
FROM Departments d
right join
	Employees e
on d.DeptNo = e.DeptNo

SELECT
DeptName
,LastName
FROM Departments d
right join
	Employees e
on d.DeptNo = e.DeptNo

SELECT
DeptName
,LastName
FROM Departments d
left join
	Employees e
on d.DeptNo = e.DeptNo

SELECT
DeptName
,LastName
FROM Departments d
outer join
	Employees e
on d.DeptNo = e.DeptNo

SELECT
DeptName
,LastName
FROM Departments d
cross join
	Employees e

	SELECT
		CustomerFirst
		, CustomerLast
	FROM 
		Customers
INTERSECT
	SELECT 
		FirstName
		, LastName
	FROM
		Employees

ORDER BY CustomerLast


SELECT
DeptName
,LastName
FROM Departments d
cross join
	Employees e

	SELECT
		CustomerFirst
		, CustomerLast
	FROM 
		Customers
EXCEPT
	SELECT 
		FirstName
		, LastName
	FROM
		Employees

ORDER BY CustomerLast

SELECT VendorID
    ,SUM(InvoiceTotal)	AS VendorTotal,
    COUNT(InvoiceTotal) AS VendorCount,
    AVG(InvoiceTotal)	AS VendorAvg
FROM Invoices
GROUP BY VendorID
HAVING COUNT(InvoiceTotal) > 1
ORDER BY 2 DESC

--total invoice population
SELECT 
    SUM(InvoiceTotal)	AS VendorTotal,
    COUNT(InvoiceTotal) AS VendorCount,
    AVG(InvoiceTotal)	AS VendorMean,
	STDEV(InvoiceTotal) AS VendorStdev
FROM Invoices
/*
VendorTotal	VendorCount	VendorMean	VendorStdev
214290.51	114	1879.7413	5609.11872672873
*/

SELECT 1879.7413+5609.11872672873

SELECT 0.35 * 114

--expectation <35% will be outliers
SELECT 
    COUNT(InvoiceTotal) AS VendorCount
FROM Invoices
WHERE InvoiceTotal = 

SELECT VendorID
    ,SUM(InvoiceTotal)	AS VendorTotal,
    MIN(InvoiceTotal)	AS VendorMin,
    MAX(InvoiceTotal)	AS VendorMax,
    AVG(CASE WHEN [CreditTotal] > 0 THEN 1.0 ELSE 0.0 END)	AS CreditCount,
	COUNT(InvoiceTotal) AS VendorCount,
    AVG(InvoiceTotal)	AS Vendormean,
	STDEV(InvoiceTotal) AS VendorStdev,
	100*(STDEV(InvoiceTotal)/AVG(InvoiceTotal)) AS [Vendor Coefficient of Variance]
FROM Invoices
GROUP BY VendorID
HAVING 
--COUNT(InvoiceTotal) > 1
--	AND
	    SUM(CASE WHEN [CreditTotal] > 0 THEN 1 ELSE 0 END)	> 1
ORDER BY 2 DESC

SELECT 
	COUNT(*) AS TotalInvoices,
    SUM([CreditTotal])	AS CreditTotal,
    AVG([CreditTotal])	AS CreditMean,
	STDEV([CreditTotal]) AS CreditStdev
FROM Invoices



SELECT VendorID, InvoiceDate, InvoiceTotal,
    SUM(InvoiceTotal)	AS VendorTotal,
    COUNT(InvoiceTotal) AS VendorCount,
    AVG(InvoiceTotal)	AS VendorAvg
FROM Invoices
GROUP BY VendorID, InvoiceDate, InvoiceTotal
ORDER BY VendorID, InvoiceDate
;
/*
VendorID	InvoiceDate			InvoiceTotal		VendorTotal		VendorCount	VendorAvg
34			2016-01-07 00:00:00	116.54				116.54			1			116.54
34			2016-02-09 00:00:00	1083.58				1083.58			1			1083.58
*/

USE AP;
SELECT AccountNo, SUM(InvoiceLineItemAmount) AS LineItemSum
FROM InvoiceLineItems
GROUP BY AccountNo 
WITH ROLLUP;

--new school
SELECT VendorID, COUNT(*) AS Qtyinv,
SUM(InvoiceTotal) as invtot
FROM Invoices
GROUP BY VendorID
WITH ROLLUP;

--old school
SELECT AccountNo, SUM(InvoiceLineItemAmount) AS LineItemSum
FROM InvoiceLineItems
GROUP BY AccountNo 
UNION
SELECT NULL AS AccountNo, SUM(InvoiceLineItemAmount) AS LineItemSum
FROM InvoiceLineItems
--214290.51

SELECT AccountNo, SUM(InvoiceLineItemAmount) AS LineItemSum
FROM InvoiceLineItems
GROUP BY ROLLUP(AccountNo)
;
use AP
go
SELECT
	VendorCity
	, VendorState
	, count(*)	as	qtyvendors
FROM
	Vendors 
WHERE VendorState in ('IA','NJ')
GROUP BY 
	VendorCity
	,VendorState
ORDER BY 
	VendorCity DESC
	, VendorState DESC

SELECT
	VendorCity
	, VendorState
	, count(*)	as	qtyvendors
FROM
	Vendors 
WHERE VendorState in ('IA','NJ')
GROUP BY 
	VendorCity
	,VendorState
WITH ROLLUP
ORDER BY 
	VendorCity DESC
	, VendorState DESC


SELECT
	VendorCity
	, VendorState
	, count(*)	as	qtyvendors
FROM
	Vendors 
WHERE VendorState in ('IA','NJ')
GROUP BY 
	VendorCity
	,VendorState
WITH CUBE
ORDER BY 
	VendorCity DESC
	, VendorState DESC


SELECT
	VendorCity
	, VendorState
	, count(*)	as	qtyvendors
FROM
	Vendors 
WHERE VendorState in ('IA','NJ')
GROUP BY 
	CUBE(VendorCity
	,VendorState
	)
ORDER BY 
	VendorCity DESC
	, VendorState DESC



SELECT
	VendorCity
	, VendorState
	, count(*)	as	qtyvendors
FROM
	Vendors 
WHERE VendorState in ('IA','NJ')
GROUP BY 
	GROUPING SETS(
		VendorCity
		,VendorState
	)
ORDER BY 
	VendorCity DESC
	, VendorState DESC



SELECT
	VendorCity
	, VendorState
	,VendorZipCode
	, count(*)	as	qtyvendors
FROM
	Vendors 
WHERE VendorState in ('IA','NJ')
GROUP BY 
	GROUPING SETS(
				VendorCity
				,VendorState
		,
			VendorZipCode
		,
		()
	)
ORDER BY 
	VendorCity DESC
	, VendorState DESC

SELECT
	VendorCity
	, VendorState
	,VendorZipCode
	, count(*)	as	qtyvendors
FROM
	Vendors 
WHERE VendorState in ('IA','NJ')
GROUP BY 
	GROUPING SETS(
			(
				VendorCity
				,VendorState
			)
			,
			(
				VendorCity
				,VendorZipCode
			)
			,
			(
				VendorCity
				,VendorZipCode
				,VendorState
			)
			,
			()
		)
ORDER BY 
	VendorCity DESC
	, VendorState DESC

SELECT
	VendorCity
	, VendorState
	,VendorZipCode
	, count(*)	as	qtyvendors
FROM
	Vendors 
WHERE VendorState in ('IA','NJ')
GROUP BY 
	GROUPING SETS(
					ROLLUP(
						VendorState
						,VendorCity
					)
				,
					VendorZipCode
				,
					()
	)
ORDER BY 
	VendorCity DESC
	, VendorState DESC


SELECT VendorID, InvoiceDate, InvoiceTotal,
	ROW_NUMBER() OVER (PARTITION BY VendorID order by InvoiceDate) RowNumberz,
    SUM(InvoiceTotal) OVER (PARTITION BY VendorID) AS VendorTotal,
    COUNT(InvoiceTotal) OVER (PARTITION BY VendorID) AS VendorCount,
    AVG(InvoiceTotal) OVER (PARTITION BY VendorID) AS VendorAvg
FROM Invoices;

SELECT InvoiceDate,
    SUM(InvoiceTotal)   SUMInvoiceTotal,
    COUNT(InvoiceTotal) COUNTInvoiceTot,
    AVG(InvoiceTotal)   AVGInvoiceTotal
FROM Invoices
GROUP BY InvoiceDate
/*
InvoiceDate	SUMInvoiceTotal	COUNTInvoiceTot	AVGInvoiceTotal
2015-12-08 00:00:00	3813.33	1	3813.33
2015-12-10 00:00:00	40.20	1	40.20
2015-12-13 00:00:00	138.75	1	138.75
2015-12-16 00:00:00	202.95	3	67.65
2015-12-21 00:00:00	172.50	1	172.50
2015-12-24 00:00:00	739.62	3	246.54
*/


SELECT InvoiceNumber, InvoiceDate, InvoiceTotal,
    SUM(InvoiceTotal) OVER (PARTITION BY InvoiceDate) AS DailyCumulativeTotal,
    COUNT(InvoiceTotal) OVER (PARTITION BY InvoiceDate) AS DailyInvoiceCount,
    AVG(InvoiceTotal) OVER (PARTITION BY InvoiceDate) AS DailyAvg,
	InvoiceTotal/SUM(InvoiceTotal) OVER (PARTITION BY InvoiceDate) AS PctOfDailySales
FROM Invoices
ORDER BY InvoiceDate;


SELECT InvoiceNumber, TermsID, InvoiceDate, InvoiceTotal,
    SUM(InvoiceTotal)	OVER (PARTITION BY TermsID ORDER BY InvoiceDate ) AS ByTermsIDCumulativeTotal,
    COUNT(InvoiceTotal) OVER (PARTITION BY TermsID ORDER BY InvoiceDate ) AS ByTermsIDInvoiceCount,
    AVG(InvoiceTotal)	OVER (PARTITION BY TermsID ORDER BY InvoiceDate ) AS ByTermsIDAvg,
	InvoiceTotal/SUM(InvoiceTotal)	OVER (PARTITION BY TermsID ORDER BY InvoiceDate ) AS PctOfDailySalesByTermsID,
	InvoiceTotal/SUM(InvoiceTotal)	OVER (PARTITION BY TermsID) AS PctOfSalesByTermsID
FROM Invoices
ORDER BY TermsID, InvoiceDate;


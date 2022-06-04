Select 'SELECT '+''''+TABLE_NAME +''''+ ' AS tbl_name, COUNT(*)  AS QTY FROM '+TABLE_NAME+' UNION' from INFORMATION_SCHEMA.TABLES
--QUOTED IDENTIFIER & dELIMITER EXAMPLE
"NAME, FNAME", 

Select 'SELECT '+Char(39)+TABLE_NAME +Char(39)+ ' AS tbl_name, COUNT(*)  AS QTY FROM '+TABLE_NAME+' UNION' from INFORMATION_SCHEMA.TABLES

SELECT 'ActiveInvoices' AS tbl_name, COUNT(*)  AS QTY FROM ActiveInvoices UNION
SELECT 'APFlat' AS tbl_name, COUNT(*)  AS QTY FROM APFlat UNION
SELECT 'Customers' AS tbl_name, COUNT(*)  AS QTY FROM Customers UNION
SELECT 'DateSample' AS tbl_name, COUNT(*)  AS QTY FROM DateSample UNION
SELECT 'Departments' AS tbl_name, COUNT(*)  AS QTY FROM Departments UNION
SELECT 'Employees' AS tbl_name, COUNT(*)  AS QTY FROM Employees UNION
SELECT 'EmployeesOld' AS tbl_name, COUNT(*)  AS QTY FROM EmployeesOld UNION
SELECT 'EmployeesTest' AS tbl_name, COUNT(*)  AS QTY FROM EmployeesTest UNION
SELECT 'Investors' AS tbl_name, COUNT(*)  AS QTY FROM Investors UNION
SELECT 'Invoices' AS tbl_name, COUNT(*)  AS QTY FROM Invoices UNION
SELECT 'NullSample' AS tbl_name, COUNT(*)  AS QTY FROM NullSample UNION
SELECT 'PaidInvoices' AS tbl_name, COUNT(*)  AS QTY FROM PaidInvoices UNION
SELECT 'Projects' AS tbl_name, COUNT(*)  AS QTY FROM Projects UNION
SELECT 'RealSample' AS tbl_name, COUNT(*)  AS QTY FROM RealSample UNION
SELECT 'SalesReps' AS tbl_name, COUNT(*)  AS QTY FROM SalesReps UNION
SELECT 'SalesTotals' AS tbl_name, COUNT(*)  AS QTY FROM SalesTotals UNION
SELECT 'Sample' AS tbl_name, COUNT(*)  AS QTY FROM Sample UNION
SELECT 'StringSample' AS tbl_name, COUNT(*)  AS QTY FROM StringSample UNION
SELECT 'Vendors' AS tbl_name, COUNT(*)  AS QTY FROM Vendors UNION
SELECT 'sysdiagrams' AS tbl_name, COUNT(*)  AS QTY FROM sysdiagrams 
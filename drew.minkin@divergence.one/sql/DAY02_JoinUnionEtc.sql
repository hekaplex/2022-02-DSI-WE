/*
SELECT 
	VendorName
	, InvoiceNumber
	, InvoiceDate
	, InvoiceLineItemAmount AS LineItemAmount
	, AccountDescription
FROM 
	Vendors
	, Invoices
	, InvoiceLineItems
	, GLAccounts
WHERE 
	Vendors.VendorID = Invoices.VendorID
  AND 
	Invoices.InvoiceID = InvoiceLineItems.InvoiceID
  AND 
	InvoiceLineItems.AccountNo = GLAccounts.AccountNo
  AND 
	InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY VendorName, LineItemAmount DESC;
*/

--better syntax
SELECT 
	VendorName
	,Vendors.VendorID
	, Invoices.VendorID
	, InvoiceNumber
	, InvoiceDate
	, InvoiceLineItemAmount AS LineItemAmount
	, AccountDescription
FROM 
	Vendors
--join type
	LEFT JOIN 
		Invoices
	--join condition
	ON
			Vendors.VendorID = Invoices.VendorID
	LEFT JOIN
		InvoiceLineItems
		ON
			Invoices.InvoiceID = InvoiceLineItems.InvoiceID
	LEFT JOIN
		GLAccounts
		ON
			InvoiceLineItems.AccountNo = GLAccounts.AccountNo

--WHERE 
--	InvoiceTotal - PaymentTotal - CreditTotal > 0
ORDER BY 
	VendorName, LineItemAmount DESC;

SELECT 
	DeptName
	, Departments.DeptNo
	, Employees.DeptNo
	, LastName
	, Employees.EmployeeID
	, Projects.EmployeeID
	, ProjectNo
FROM Departments
    FULL JOIN Employees
        ON 
			Departments.DeptNo = Employees.DeptNo
    FULL JOIN Projects
        ON 
			Employees.EmployeeID = Projects.EmployeeID
ORDER BY DeptName;





   SELECT 'Active' AS Source, InvoiceNumber,
        InvoiceDate, InvoiceTotal, TermsID
    FROM ActiveInvoices
    WHERE InvoiceDate >= '02/01/2016'
UNION 
    SELECT 'Paid' AS Source, InvoiceNumber,
        InvoiceDate, InvoiceTotal,NULL as TermsID
    FROM PaidInvoices
    WHERE InvoiceDate >= '02/01/2016'
ORDER BY InvoiceTotal DESC;


   SELECT 
	CASE TermsID
		WHEN 2
		THEN 'Type2'
		ELSE 'Type3'
	END
    FROM Examples.dbo.ActiveInvoices
    WHERE InvoiceDate >= '02/01/2016'

SELECT 
	CASE
		WHEN 
			InvoiceTotal - PaymentTotal - CreditTotal > 0 
		THEN 'Active' 
		ELSE 'Paid' 
	END 
		AS Source
	,InvoiceNumber
	,InvoiceDate
	,InvoiceTotal
FROM Invoices
ORDER BY InvoiceTotal DESC;



SELECT CustomerFirst, CustomerLast
    FROM Customers
EXCEPT
    SELECT FirstName, LastName
    FROM Employees
ORDER BY CustomerLast;




SELECT CustomerFirst, CustomerLast
    FROM Customers c
LEFT OUTER JOIN 
    Employees e
    on e.FirstName = c.CustomerFirst
	and e.LastName = c.CustomerLast
WHERE
	e.FirstName IS NULL
	and e.LastName IS NULL
ORDER BY CustomerLast;


SELECT CustomerFirst, CustomerLast
    FROM Customers
INTERSECT
    SELECT FirstName, LastName
    FROM Employees
ORDER BY CustomerLast;

SELECT CustomerFirst, CustomerLast
    FROM Customers c
LEFT OUTER JOIN 
    Employees e
    on e.FirstName = c.CustomerFirst
	and e.LastName = c.CustomerLast
WHERE
	e.FirstName IS NOT NULL
	and e.LastName IS NOT NULL
ORDER BY CustomerLast;
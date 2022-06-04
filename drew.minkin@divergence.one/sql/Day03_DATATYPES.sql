/*
SELECT 29/6.0

SELECT TRY_CONVERT(date,'Feb 30 2022')

SELECT TRY_CONVERT(int,'Feb')

SELECT VendorName + CHAR(10) 
     + VendorAddress1 + CHAR(10)
     + VendorCity + ', ' + VendorState + ' '      + VendorZipCode
FROM Vendors

select nchar(702)
SELECT UNICODE('ʾ')
*/
SELECT
    CAST(InvoiceDate AS varchar) AS varcharDate,
    CAST(InvoiceTotal AS integer) AS integerTotal,
    CAST(InvoiceTotal AS varchar) AS varcharTotal,
	CONVERT(varchar, InvoiceDate) AS varcharDate_0,
    CONVERT(varchar, InvoiceDate, 1) AS varcharDate_1,
    CONVERT(varchar, InvoiceDate, 101) AS varcharDate_101,
    CONVERT(varchar, InvoiceDate, 7) AS varcharDate_7,
    CONVERT(varchar, InvoiceDate, 107) AS varcharDate_107,
    CONVERT(varchar, InvoiceDate, 12) AS varcharDate_12,
    CONVERT(varchar, InvoiceDate, 112) AS varcharDate_112,
	CONVERT(int, InvoiceDate, 112) AS intDate_112,
    CONVERT(varchar, InvoiceTotal) AS varcharTotal_0,
    CONVERT(varchar, InvoiceTotal, 0) AS varcharTotal_0A,
    CONVERT(varchar, InvoiceTotal, 1) AS varcharTotal_1,
	CONVERT(varchar, InvoiceTotal, 2) AS varcharTotal_2,
	TRY_CONVERT(varchar, InvoiceDate) AS varcharDate,
    TRY_CONVERT(varchar, InvoiceDate, 1) AS varcharDate_1,
    TRY_CONVERT(varchar, InvoiceDate, 107) AS varcharDate_107,
    TRY_CONVERT(varchar, InvoiceTotal) AS varcharTotal,
    TRY_CONVERT(varchar, InvoiceTotal, 1) AS varcharTotal_1,
    TRY_CONVERT(date, 'Feb 29 2019') AS invalidDate
FROM Invoices
;



--SELECT 42344/365.25
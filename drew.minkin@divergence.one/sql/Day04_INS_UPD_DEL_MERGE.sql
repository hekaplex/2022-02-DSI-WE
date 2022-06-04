USE AP;

IF OBJECT_ID('InvoiceCopy') IS NOT NULL 
	DROP TABLE InvoiceCopy
;
--SELECT...INTO
SELECT 
	*
INTO InvoiceCopy
FROM Invoices
;
SELECT OBJECT_ID('InvoiceCopy')
;
SELECT COUNT(*) FROM InvoiceCopy
;
--INSERT Single row 
INSERT INTO InvoiceCopy
VALUES
--[InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]
 (97, '456789', '2020-03-01', 8344.50, 0, 0, 1, '2020-03-31', NULL);
;
 SELECT * FROM InvoiceCopy
 ;
 INSERT INTO InvoiceCopy
VALUES
--[InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate]
 (98, '456789', '2022-03-31', 8344.50, 0, 0, 1, '2022-03-31', NULL);
 ;
  INSERT INTO InvoiceCopy
  ([VendorID], [InvoiceNumber], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate],[InvoiceDate],  [PaymentDate])
  VALUES (99, '456789',  4747.50, 0, 0, 1, '2022-03-31', '2022-03-31',NULL);
  ;
  SELECT * FROM InvoiceCopy
  ;
  --MULTIROW INSERT
 INSERT INTO InvoiceCopy
VALUES
    (95, '111-10098', '2020-03-01', 219.50, 0, 0, 1, '2020-03-31', NULL),
    (102, '109596', '2020-03-01', 22.97, 0, 0, 1, '2020-03-31', NULL),
    (72, '40319', '2020-03-01', 173.38, 0, 0, 1, '2020-03-31', NULL); 
;
--INSERT SELECT
--SET IDENTITY_INSERT Invoices OFF
INSERT INTO Invoices
SELECT [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate] FROM InvoiceCopy
EXCEPT
SELECT [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate] FROM Invoices
;
--SELECT INTO Metadata Only
SELECT 
	*
INTO InvoiceEmpty
FROM Invoices
WHERE 1 =2
;
select * from InvoiceEmpty
;
INSERT INTO InvoiceEmpty
SELECT [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate], [PaymentDate] 
FROM InvoiceCopy

--UPDATE Simple
;
SELECT * from InvoiceCopy
;
--BEGIN TRAN
UPDATE 
	InvoiceCopy
--ALWAYS DO A SELECT of old/new versin of columns before UPDATE or DELETE
SET
	PaymentDate = '2022-04-01'
	,PaymentTotal = 19351.18
WHERE
	InvoiceNumber = '97/522'
--ROLLBACK --(undo)
--COMMIT
;
SELECT VendorID	,LastName	,FirstName FROM ContactUpdates	
EXCEPT
SELECT VendorID	,[VendorContactLName], [VendorContactFName] FROM VendorCopy
;
SELECT 
	* 
INTO
	VendorCopy
FROM 
	Vendors
;
--preflightcheck
SELECT
	vc.[VendorContactLName]
	,vs.LastName	
	,vc.[VendorContactFName]
	,vs.FirstName 
FROM
	VendorCopy vc
		JOIN
		ContactUpdates vs
			ON
				vc.VendorID = vs.VendorID
;
--Complex UPDATE
UPDATE
	vc
	SET
	[VendorContactLName] = LastName	
	, [VendorContactFName] = FirstName 
FROM
	VendorCopy vc
		JOIN
		ContactUpdates vs
			ON
				vc.VendorID = vs.VendorID
;
--DELETE
DELETE
	InvoiceCopy
WHERE
	VendorID =
		(
			SELECT
				VendorID
			FROM
				VendorCopy
			WHERE
				VendorName = 'Blue Cross'
		)
;		
--ROWCOUNT
SET ROWCOUNT 0
Select count(*) from Invoices
;
--Complex DELETE			
DELETE
	ic
FROM
	InvoiceCopy ic
		Join
			VendorCopy vc
				ON	ic.VendorID = vc.VendorID 
			WHERE
				vc.VendorName = 'Blue Cross'
;
--MERGE		
--SELECT *  FROM [dbo].[InvoiceArchive]
MERGE INTO InvoiceArchive ia
USING InvoiceCopy ic
ON ia.InvoiceID = ic.InvoiceID
--INNER JOIN = UPDATE
WHEN MATCHED 
	AND ic.PaymentDate IS NOT NULL
	AND ic.PaymentTotal > ia.PaymentTotal
	THEN 
		UPDATE SET
		ia.PaymentTotal = ic.PaymentTotal
		,ia.PaymentDate = ic.PaymentDate
		,ia.CreditTotal = ic.CreditTotal
--LEFT OUTER JOIN WITH NULL FROM SOURCE = INSERT
WHEN NOT MATCHED 
	THEN
		INSERT ([InvoiceID], [VendorID], [InvoiceNumber], [InvoiceDate], [InvoiceTotal], [PaymentTotal], [CreditTotal], [TermsID], [InvoiceDueDate])
		VALUES(ic.[InvoiceID], ic.[VendorID], ic.[InvoiceNumber], ic.[InvoiceDate], ic.[InvoiceTotal], ic.[PaymentTotal], ic.[CreditTotal], ic.[TermsID], ic.[InvoiceDueDate])
--RIGHT OUTER JOIN = DELETE
WHEN NOT MATCHED BY SOURCE
	THEN DELETE;


SELECT * from InvoiceArchive;
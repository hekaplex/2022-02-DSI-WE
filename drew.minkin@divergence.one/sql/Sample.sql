SELECT
    InvoiceID
    ,InvoiceTotal
    ,CreditTotal + PaymentTotal
        AS TotalCredits
FROM 
    Invoices
WHERE 
    InvoiceID = 17
GO
select count(*) from Vendors    
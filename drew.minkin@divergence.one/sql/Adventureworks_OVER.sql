SELECT BusinessEntityID, TerritoryID   
    ,CONVERT(VARCHAR(20),SalesYTD,1) AS SalesYTD  
    ,DATEPART(yy,ModifiedDate) AS SalesYear  
    ,CONVERT(VARCHAR(20),SUM(SalesYTD) OVER (PARTITION BY TerritoryID   
                                             ORDER BY DATEPART(yy,ModifiedDate)   
											 ROWS BETWEEN 1 PRECEDING AND CURRENT ROW
                                              ),1) AS CumulativeTotal  
FROM Sales.SalesPerson  
WHERE TerritoryID IS NULL OR TerritoryID < 5;

/*
BusinessEntityID	TerritoryID	SalesYTD	SalesYear	CumulativeTotal
274	NULL	559,697.56	2010	559,697.56
287	NULL	519,905.93	2012	1,079,603.50
285	NULL	172,524.45	2013	1,252,127.95
283	1	1,573,012.94	2011	2,925,590.07
280	1	1,352,577.13	2011	2,925,590.07
284	1	1,576,562.20	2012	4,502,152.27
275	2	3,763,178.18	2011	3,763,178.18
277	3	3,189,418.37	2011	3,189,418.37
276	4	4,251,368.55	2011	6,709,904.17
281	4	2,458,535.62	2011	6,709,904.17
*/

SELECT BusinessEntityID, TerritoryID   
    ,CONVERT(VARCHAR(20),SalesYTD,1) AS SalesYTD  
    ,DATEPART(yy,ModifiedDate) AS SalesYear  
    ,CONVERT(VARCHAR(20),SUM(SalesYTD) OVER (PARTITION BY TerritoryID   
                                             ORDER BY DATEPART(yy,ModifiedDate)   
                                             ROWS UNBOUNDED PRECEDING),1) AS CumulativeTotal  
FROM Sales.SalesPerson  
WHERE TerritoryID IS NULL OR TerritoryID < 5;
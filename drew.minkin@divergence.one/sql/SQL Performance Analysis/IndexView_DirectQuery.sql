

--Power BI Direct Query Example
SELECT  
	TOP (1000001) 
	[t3].[CalendarYear]
	,[t16].[ProductSubcategoryName]
	,SUM([t0].[SalesAmount])  AS [a0] 
FROM  
	( 
		( 
			(
				(
					select 
						[$Table].[SalesKey] as [SalesKey]
						,     [$Table].[DateKey] as [DateKey]
						,     [$Table].[channelKey] as [channelKey]
						,     [$Table].[StoreKey] as [StoreKey]
						,     [$Table].[ProductKey] as [ProductKey]
						,     [$Table].[PromotionKey] as [PromotionKey]
						,     [$Table].[CurrencyKey] as [CurrencyKey]
						,     [$Table].[UnitCost] as [UnitCost]
						,     [$Table].[UnitPrice] as [UnitPrice]
						,     [$Table].[SalesQuantity] as [SalesQuantity]
						,     [$Table].[ReturnQuantity] as [ReturnQuantity]
						,     [$Table].[ReturnAmount] as [ReturnAmount]
						,     [$Table].[DiscountQuantity] as [DiscountQuantity]
						,     [$Table].[DiscountAmount] as [DiscountAmount]
						,     [$Table].[TotalCost] as [TotalCost]
						,     [$Table].[SalesAmount] as [SalesAmount]
						,     [$Table].[ETLLoadID] as [ETLLoadID]
						,     [$Table].[LoadDate] as [LoadDate]
						,     [$Table].[UpdateDate] as [UpdateDate] 
						from [dbo].[FactSales] as [$Table]
					) AS [t0]   
					
					LEFT OUTER JOIN   
						(
							select 
								[$Table].[Datekey] as [Datekey]
								,     [$Table].[FullDateLabel] as [FullDateLabel]
								,     [$Table].[DateDescription] as [DateDescription]
								,     [$Table].[CalendarYear] as [CalendarYear]
								,     [$Table].[CalendarYearLabel] as [CalendarYearLabel]
								,     [$Table].[CalendarHalfYear] as [CalendarHalfYear]
								,     [$Table].[CalendarHalfYearLabel] as [CalendarHalfYearLabel]
								,     [$Table].[CalendarQuarter] as [CalendarQuarter]
								,     [$Table].[CalendarQuarterLabel] as [CalendarQuarterLabel]
								,     [$Table].[CalendarMonth] as [CalendarMonth]
								,     [$Table].[CalendarMonthLabel] as [CalendarMonthLabel]
								,     [$Table].[CalendarWeek] as [CalendarWeek]
								,     [$Table].[CalendarWeekLabel] as [CalendarWeekLabel]
								,     [$Table].[CalendarDayOfWeek] as [CalendarDayOfWeek]
								,     [$Table].[CalendarDayOfWeekLabel] as [CalendarDayOfWeekLabel]
								,     [$Table].[FiscalYear] as [FiscalYear]
								,     [$Table].[FiscalYearLabel] as [FiscalYearLabel]
								,     [$Table].[FiscalHalfYear] as [FiscalHalfYear]
								,     [$Table].[FiscalHalfYearLabel] as [FiscalHalfYearLabel]
								,     [$Table].[FiscalQuarter] as [FiscalQuarter]
								,     [$Table].[FiscalQuarterLabel] as [FiscalQuarterLabel]
								,     [$Table].[FiscalMonth] as [FiscalMonth]
								,     [$Table].[FiscalMonthLabel] as [FiscalMonthLabel]
								,     [$Table].[IsWorkDay] as [IsWorkDay]
								,     [$Table].[IsHoliday] as [IsHoliday]
								,     [$Table].[HolidayName] as [HolidayName]
								,     [$Table].[EuropeSeason] as [EuropeSeason]
								,     [$Table].[NorthAmericaSeason] as [NorthAmericaSeason]
								,     [$Table].[AsiaSeason] as [AsiaSeason] 
							from 
								[dbo].[DimDate] as [$Table]
						) AS 
						
						[t3] 
							on  ( [t0].[DateKey] = [t3].[Datekey] ) 
					)    
				LEFT OUTER JOIN   
					(select [$Table].[ProductKey] as [ProductKey],     [$Table].[ProductLabel] as [ProductLabel],     
					[$Table].[ProductName] as [ProductName],     [$Table].[ProductDescription] as [ProductDescription]
					,     [$Table].[ProductSubcategoryKey] as [ProductSubcategoryKey],     
					[$Table].[Manufacturer] as [Manufacturer],     [$Table].[BrandName] as [BrandName],     
					[$Table].[ClassID] as [ClassID],     [$Table].[ClassName] as [ClassName],     
					[$Table].[StyleID] as [StyleID],     [$Table].[StyleName] as [StyleName],     
					[$Table].[ColorID] as [ColorID],     [$Table].[ColorName] as [ColorName],     
					[$Table].[Size] as [Size],     [$Table].[SizeRange] as [SizeRange],     
					[$Table].[SizeUnitMeasureID] as [SizeUnitMeasureID],     
					[$Table].[Weight] as [Weight],     [$Table].[WeightUnitMeasureID] as [WeightUnitMeasureID],     
					[$Table].[UnitOfMeasureID] as [UnitOfMeasureID],     
					[$Table].[UnitOfMeasureName] as [UnitOfMeasureName],     
					[$Table].[StockTypeID] as [StockTypeID],     
					[$Table].[StockTypeName] as [StockTypeName],     
					[$Table].[UnitCost] as [UnitCost],     [$Table].[UnitPrice] as [UnitPrice],    
					[$Table].[AvailableForSaleDate] as [AvailableForSaleDate],     [$Table].[StopSaleDate] as [StopSaleDate]
					,     [$Table].[Status] as [Status],     [$Table].[ImageURL] as [ImageURL],     [$Table].[ProductURL] as [ProductURL]
					,     [$Table].[ETLLoadID] as [ETLLoadID],     [$Table].[LoadDate] as [LoadDate]
					,     [$Table].[UpdateDate] as [UpdateDate] from [dbo].[DimProduct] as [$Table]) AS [t4] 
				on  
					( [t0].[ProductKey] = [t4].[ProductKey] ) )    
				LEFT OUTER JOIN   
					(
						select [$Table].[ProductSubcategoryKey] as [ProductSubcategoryKey]
						,     [$Table].[ProductSubcategoryLabel] as [ProductSubcategoryLabel]
						,     [$Table].[ProductSubcategoryName] as [ProductSubcategoryName]
						,     [$Table].[ProductSubcategoryDescription] as [ProductSubcategoryDescription]
						,     [$Table].[ProductCategoryKey] as [ProductCategoryKey]
						,     [$Table].[ETLLoadID] as [ETLLoadID]
						,     [$Table].[LoadDate] as [LoadDate]
						,     [$Table].[UpdateDate] as [UpdateDate] 
						from 
							[dbo].[DimProductSubcategory] as [$Table]) AS [t16] 
				on  
					( [t4].[ProductSubcategoryKey] = [t16].[ProductSubcategoryKey] ) 
					)  GROUP BY [t3].[CalendarYear],[t16].[ProductSubcategoryName]

USE [AdventureWorks2019]
GO

/****** Object:  View [Production].[vProductAndDescription]    Script Date: 2/20/2021 1:37:24 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [Production].[vProductAndDescription] 
WITH SCHEMABINDING 
AS 
-- View (indexed or standard) to display products and product descriptions by language.
SELECT 
    p.[ProductID] 
    ,p.[Name] 
    ,pm.[Name] AS [ProductModel] 
    ,pmx.[CultureID] 
    ,pd.[Description] 
FROM [Production].[Product] p 
    INNER JOIN [Production].[ProductModel] pm 
    ON p.[ProductModelID] = pm.[ProductModelID] 
    INNER JOIN [Production].[ProductModelProductDescriptionCulture] pmx 
    ON pm.[ProductModelID] = pmx.[ProductModelID] 
    INNER JOIN [Production].[ProductDescription] pd 
    ON pmx.[ProductDescriptionID] = pd.[ProductDescriptionID];
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Product names and descriptions. Product descriptions are provided in multiple languages.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'VIEW',@level1name=N'vProductAndDescription'
GO

USE [AdventureWorks2019]
GO

SET ARITHABORT ON
SET CONCAT_NULL_YIELDS_NULL ON
SET QUOTED_IDENTIFIER ON
SET ANSI_NULLS ON
SET ANSI_PADDING ON
SET ANSI_WARNINGS ON
SET NUMERIC_ROUNDABORT OFF
GO

/****** Object:  Index [IX_vProductAndDescription]    Script Date: 2/20/2021 1:39:46 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_vProductAndDescription] ON [Production].[vProductAndDescription]
(
	[CultureID] ASC,
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Clustered index on the view vProductAndDescription.' , @level0type=N'SCHEMA',@level0name=N'Production', @level1type=N'VIEW',@level1name=N'vProductAndDescription', @level2type=N'INDEX',@level2name=N'IX_vProductAndDescription'
GO




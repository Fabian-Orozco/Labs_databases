/* Trabajo en parejas
  Fabián Orozco Chaves - B95690
  Daniel Escobar Giraldo - C02748 
  LabOpt_04
*/

use LabOpt_04
-- Ejercicio 1 (a)
select * from Sales.SalesPerson

SELECT * INTO dbo.SalesOrderHeader FROM Sales.SalesOrderHeader;
SELECT * INTO dbo.SalesOrderDetail FROM Sales.SalesOrderDetail;
SELECT * INTO dbo.SalesPerson FROM Sales.SalesPerson;

SELECT ProductID
FROM Sales.SalesOrderDetail;
SELECT ProductID
FROM dbo.SalesOrderDetail;

-- Ejercicio 1 (e)
create index SalesOrderDetail_ProductID
ON dbo.SalesOrderDetail(ProductID)

-- Ejercicio 1 (g)
drop index SalesOrderDetail_ProductID on dbo.SalesOrderDetail


-- Ejercicio 2(a)
SELECT count(*)
FROM dbo.SalesOrderHeader
WHERE DATEPART(YEAR, OrderDate) = '2014'

-- Ejercicio 2(d)
SELECT count(*) 
FROM dbo.SalesOrderHeader 
WHERE OrderDate >= '20140101' AND OrderDate < '20150101'

-- Ejercicio 2(g)
create index SalesOrderHeader_OrderDate
on dbo.SalesOrderHeader(OrderDate)

-- Ejercicio 2(j)
drop index SalesOrderHeader_OrderDate on dbo.SalesOrderHeader

-- Ejercicio 3(a)
SELECT * FROM dbo.SalesOrderHeader 
WHERE TotalDue BETWEEN 500 AND 40000

-- Ejercicio 3(d)
create index SalesOrderHeader_TotalDue on dbo.SalesOrderHeader(TotalDue)

-- Ejercicio 3(f)
SELECT TotalDue FROM dbo.SalesOrderHeader
WHERE TotalDue BETWEEN 500 AND 40000

-- Ejercicio 3(h)
SELECT SalesOrderID, TotalDue 
FROM dbo.SalesOrderHeader 
WHERE TotalDue BETWEEN 500 AND 40000

-- Ejercicio 3(j)
drop index SalesOrderHeader_TotalDue on dbo.SalesOrderHeader 
create index SalesOrderHeader_TotalDue_SalesOrderID on dbo.SalesOrderHeader(TotalDue) include (SalesOrderID)

-- Ejercicio 3(l)
SELECT SalesOrderID, TotalDue 
FROM dbo.SalesOrderHeader
WHERE ABS(TotalDue) BETWEEN 500 AND 40000

-- Ejercicio 3(n)
SELECT SalesOrderID, TotalDue 
FROM dbo.SalesOrderHeader 
WHERE TotalDue BETWEEN 500 AND 40000

SELECT SalesOrderID, TotalDue 
FROM dbo.SalesOrderHeader
WHERE ABS(TotalDue) BETWEEN 500 AND 40000

-- Ejercicio 3(p)
drop index SalesOrderHeader_TotalDue_SalesOrderID on dbo.SalesOrderHeader


-- Ejercicio 4(a)
SELECT h.SalesOrderID, d.SalesOrderDetailID, h.SalesPersonID
FROM Sales.SalesOrderHeader h 
 JOIN Sales.SalesOrderDetail d 
 ON d.SalesOrderID = h.SalesOrderID
 JOIN Sales.SalesPerson p 
 ON p.BusinessEntityID = h.SalesPersonID

SELECT h.SalesOrderID, d.SalesOrderDetailID, h.SalesPersonID
FROM dbo.SalesOrderHeader h 
 JOIN dbo.SalesOrderDetail d 
 ON d.SalesOrderID = h.SalesOrderID
 JOIN dbo.SalesPerson p 
 ON p.BusinessEntityID = h.SalesPersonID

-- Ejercicio 4(e)
create nonclustered index OrderID_PersonID on dbo.SalesOrderHeader (SalesPersonID) include (SalesOrderID)
create nonclustered index sales_OrderDetailID on [dbo].[SalesOrderDetail] ([SalesOrderID]) include ([SalesOrderDetailID])

-- Ejercicio 4(g)
drop index OrderID_PersonID on dbo.SalesOrderHeader 
drop index sales_OrderDetailID on [dbo].[SalesOrderDetail]

-- Ejercicio 5(a)
SELECT SalesOrderID, SalesPersonID, ShipDate 
FROM dbo.SalesOrderHeader 
WHERE SalesPersonID IN (SELECT BusinessEntityID FROM dbo.SalesPerson WHERE TerritoryID > 5) AND ShipDate > '2014-01-01' 

-- Ejercicio 5(c)
SELECT SalesOrderID, SalesPersonID, ShipDate, BusinessEntityID
FROM dbo.SalesOrderHeader h Left JOIN dbo.SalesPerson p ON h.SalesPersonID = p.BusinessEntityID
WHERE p.TerritoryID > 5 AND ShipDate > '2014-01-01'

-- Ejercicio 5(e)
create nonclustered index ShipDate
on dbo.SalesOrderHeader (ShipDate)
include (SalesOrderID,SalesPersonID)

create nonclustered index PersonID_ShipDate
on dbo.SalesOrderHeader (SalesPersonID,ShipDate)
include (SalesOrderID)
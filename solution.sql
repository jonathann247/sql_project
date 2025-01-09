use MYDSmartDrive;

--2. Select the number of units, average product price, the standard deviation, Max and min by category
SELECT CAT.CategoryName
     , COUNT(0) AS Units
     , ROUND(AVG(PRO.Price),2) AS AveragePrice
     , MAX(PRO.Price) AS MaxPrice
     , MIN(PRO.Price) AS MinPrice
     , ROUND(STDEV(PRO.Price),2) AS StandardDeviation
  FROM Product AS PRO
  JOIN Category AS CAT
    ON PRO.CategoryID = CAT.CategoryID
 GROUP BY CAT.CategoryName
 ORDER BY AveragePrice DESC

--3. Select top 10 best selling products of all times
SELECT CAT.CategoryName
     , PRO.ProductName
     , SUM(ODE.Quantity) AS UnitsSold
  FROM OrderDetail ODE
  JOIN Product  AS PRO
    ON ODE.ProductID = PRO.ProductID
  JOIN Category AS CAT
    ON PRO.CategoryID = CAT.CategoryID
 GROUP BY CAT.CategoryName, PRO.ProductName
 ORDER BY UnitsSold DESC
 
 SELECT  TOP 10 CAT.CategoryName as CategoryName
     , PRO.ProductName as ProductName
     , SUM(ODE.Quantity) AS UnitsSold 
  FROM OrderDetail ODE
  JOIN Product  AS PRO
    ON ODE.ProductID = PRO.ProductID
  JOIN Category AS CAT
    ON PRO.CategoryID = CAT.CategoryID
 GROUP BY CAT.CategoryName, PRO.ProductName
  ORDER BY UnitsSold DESC
 

--4. Gross Revenue and Total Tax by year
SELECT DATEPART(year, ORD.OrderDate) AS Year
     , ROUND(SUM(ODE.Quantity * PRO.Price * (1-COALESCE(ODE.Discount,0))),2) AS GrossRevenue
     , ROUND(SUM(ODE.Quantity * PRO.Price * (1-COALESCE(ODE.Discount,0)) * COALESCE(CAT.Tax,0) /100),2) AS Tax     
  FROM OrderDetail ODE
  JOIN Product  AS PRO
    ON ODE.ProductID  = PRO.ProductID
  JOIN Orders   AS ORD
    ON ODE.OrderID    = ORD.OrderID
  JOIN Category AS CAT
    ON PRO.CategoryID = CAT.CategoryID
  JOIN SalesRep AS REP
    ON ORD.SalesRepID = REP.SalesRepID
 GROUP BY DATEPART(year, ORD.OrderDate)      
 ORDER BY GrossRevenue DESC
          
--5. Customers with more than $ 30,000 of Sales in 2014
SELECT CUS.CustomerName
     , ROUND(SUM(ODE.Quantity * PRO.Price * (1-COALESCE(ODE.Discount,0))),2) AS GrossRevenue
  FROM OrderDetail ODE
  JOIN Product  AS PRO
    ON ODE.ProductID = PRO.ProductID
  JOIN Orders   AS ORD
    ON ODE.OrderID   = ORD.OrderID
  JOIN Customer AS CUS
    ON ORD.CustomerID = CUS.CustomerID
 WHERE DATEPART(year, ORD.OrderDate) = 2014
 GROUP BY CUS.CustomerName
HAVING SUM(ODE.Quantity * PRO.Price * (1-COALESCE(ODE.Discount,0))) > 30000
ORDER BY GrossRevenue DESC
 
--6. Calculate the sales Rep Comission
SELECT COALESCE(REP.SalesRepName, 'Online') AS SalesRep
     , ROUND(SUM(ODE.Quantity * PRO.Price * (1-COALESCE(ODE.Discount,0)) * 0.2 ) ,2) AS Comission
  FROM OrderDetail ODE
  JOIN Orders   AS ORD
    ON ODE.OrderID    = ORD.OrderID
  JOIN Product  AS PRO
    ON ODE.ProductID = PRO.ProductID
  LEFT JOIN SalesRep AS REP
    ON ORD.SalesRepID = REP.SalesRepID
  JOIN Category AS CAT
    ON PRO.CategoryID = CAT.CategoryID
 GROUP BY REP.SalesRepName
 ORDER BY Comission DESC

--7. 
SELECT COALESCE(REP.SalesRepName, 'Online') AS SalesRep
     , ROUND(SUM(ODE.Quantity * PRO.Price * (1-COALESCE(ODE.Discount,0)) * 0.2 ) -
             SUM(ODE.Quantity * PRO.Price * COALESCE(ODE.Discount,0)),2) AS Comission
  FROM OrderDetail ODE
  JOIN Orders   AS ORD
    ON ODE.OrderID    = ORD.OrderID
  JOIN Product  AS PRO
    ON ODE.ProductID = PRO.ProductID
  LEFT JOIN SalesRep AS REP
    ON ORD.SalesRepID = REP.SalesRepID
  JOIN Category AS CAT
    ON PRO.CategoryID = CAT.CategoryID
 GROUP BY REP.SalesRepName
 ORDER BY Comission DESC


USE MYDSmartDrive;

--;cleansing data
SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Orders$ExternalData_1';

SELECT CONVERT(int, OrderID) as OrderID, CONVERT(date, OrderDate) as OrderDate,
CONVERT(int, CustomerID) as CustomerID, CONVERT(int, SalesRepID) as SalesRepID
FROM [dbo].[Orders$ExternalData_1];

--insert cleansed data into another table, this is due to conversion type error on importing excel data
-- a staging table was created on importing excel data

INSERT INTO Orders(OrderID, OrderDate, CustomerID, SalesRepID)
SELECT CONVERT(int, OrderID), CONVERT(date, OrderDate),
CONVERT(int, CustomerID), CONVERT(int, SalesRepID)
FROM [dbo].[Orders$ExternalData_1];

SELECT * FROM Orders;



SELECT * FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'OrderDetail$ExternalData_1';


SELECT CONVERT(int, OrderDetailID) as OrderDetailID, CONVERT(int, OrderID) as OrderID,
CONVERT(int, ProductID) as ProductID, Discount, CONVERT(int, Quantity) as Quantity
FROM [dbo].[OrderDetail$ExternalData_1];


INSERT INTO OrderDetail(OrderDetailID, OrderID, ProductID, Discount, Quantity)
SELECT CONVERT(int, OrderDetailID), CONVERT(int, OrderID),
CONVERT(int, ProductID), Discount, CONVERT(int, Quantity)
FROM [dbo].[OrderDetail$ExternalData_1];

SELECT * FROM OrderDetail;


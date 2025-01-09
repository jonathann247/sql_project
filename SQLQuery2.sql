use MYDSmartDrive;
--checking the imports
SELECT * FROM Category;

SELECT * FROM Branch;

SELECT * FROM Customer;

SELECT * FROM SalesRep;


--conversion error message, conveted csv file to excel and used power query to cleanse data
SELECT * FROM Orders;

--import excel data, to be cleansed further and put back to orders table
SELECT * FROM [dbo].[Orders$ExternalData_1];


SELECT * FROM Product;

--conversion error message, conveted csv file to excel and used power query to cleanse data
SELECT * FROM OrderDetail;

--import excel data, to be cleansed further and put back to orderDetail table
SELECT * FROM [dbo].[OrderDetail$ExternalData_1];




-- Task 1
-- Explore the Northwind database using the W3Schools SQL Tryit Editor.

-- SQL Code
SELECT *
FROM Employees;

-- SQL Code
SELECT *
FROM Customers;

-- SQL Code
SELECT *
FROM Categories;

-- Task 2
-- Examine the contents of the database tables to identify data tables and fields required to inform a business decision.

-- Business Problem/Question:
-- As a method of increasing future sales, the company has decided to give employee bonuses for exemplary performance in sales. 
-- Bonuses will be awarded to those employees who are responsible for the five highest order amounts.
-- How can we identify those employees?

-- SQL Code
SELECT *
FROM Orders;

-- SQL Code
SELECT *
FROM Orderdetails
ORDER BY OrderId;

-- SQL Code
SELECT *
FROM Products;

-- We are going to use 4 tables in order to solve our business problem: Employees, Orders, Order Details, and Products.

-- Task 3
-- Retrieve the data needed to solve a business question by joining multiple tables in SQL.

-- In order to do that, we need to join tables.

-- SQL Code for Joining 4 Tables

SELECT LastName, FirstName, Orders.OrderID, Products.ProductID,
            Quantity, Price
FROM (((Employees
  INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID)
  INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID)
  INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
ORDER BY LastName, FirstName;

-- Task 4
-- Write SQL code to calculate and aggregate data.

-- 1) Calculate Quantity * Price for each line item on the order.

-- SQL Code
SELECT LastName, FirstName, Orders.OrderID, Products.ProductID,
        	Quantity, Price, Quantity * Price as SalesAmount
FROM (((Employees
  INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID)
  INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID)
  INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
ORDER BY LastName, FirstName;

-- 2) Add together (summarize) the line item totals to get one total sales value per order.

-- SQL Code
SELECT LastName, FirstName, Orders.OrderID, SUM(Quantity * Price) as SalesAmount
FROM (((Employees
  INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID)
  INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID)
  INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
GROUP BY LastName, FirstName,Orders.OrderID;

-- Task 5
-- Display data in a format that can be used to inform a business decision.

-- SQL Code
-- It was initially supposed to be like this:
-- SELECT LastName, FirstName, Orders.OrderID, SUM(Quantity * Price) as SalesAmount
-- FROM (((Employees
--   INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID)
--   INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID)
--   INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
-- GROUP BY LastName, FirstName, Orders.OrderID
-- ORDER BY SalesAmount DESC
-- LIMIT 5;

-- But due to specific limitations within the W3Schools environment, we've adapted it as follows:

-- SQL Code
SELECT TOP 5 LastName, FirstName, Orders.OrderID, SalesAmount
FROM (
  SELECT LastName, FirstName, Orders.OrderID, SUM(Quantity * Price) as SalesAmount
  FROM (((Employees
	INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID)
	INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID)
	INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
  GROUP BY LastName, FirstName, Orders.OrderID
) AS Subquery
ORDER BY SalesAmount DESC;

-- This query provides a list of orders with the five highest sales amounts with the names of the three employees responsible.
-- But we also would like to have a list of the five employees with the highest sales amounts.

-- SQL Code
SELECT LastName, FirstName, Orders.OrderID, SalesAmount
FROM (
  SELECT LastName, FirstName, Orders.OrderID, SUM(Quantity * Price) as SalesAmount
  FROM (((Employees
	INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID)
	INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID)
	INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
  GROUP BY LastName, FirstName, Orders.OrderID
  HAVING Orders.OrderID in (10372, 10424, 10417, 10324, 10351)
) AS Subquery
ORDER BY SalesAmount DESC;

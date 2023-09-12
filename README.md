# Project Title: Pulling Insights from Data 📊
### Author: Buse Göğüsger
### Date: September 12, 2023

## **Introduction**

In this project, we explore the world of data analysis by pulling valuable insights from a database to answer critical business questions. Dive into the data, discover actionable insights, and drive informed decisions. 💡

🔍 Data Analysis | 📈 Business Insights | 🚀 Decision-Making

Note: You can access and utilize all of the provided code samples by following this [link](https://coursera.w3schools.com/sql/trysql.asp?filename=trysql_select_all) to reach the database.

## **Task 1 : Project and Database Introduction**

**Objective:** Explore the Northwind database using the W3Schools SQL Tryit Editor.

**Key Takeaways**

- A database is a collection of related tables.
- Data is stored in tables and is organized into rows and columns.
- The W3Schools SQL Tryit Editor provides a place to write and run SQL code. 

Here is our database overview:

![databaseoverview](https://github.com/BuseGogusger/data_analysis_with_SQL-inform_a_business_decision/assets/135744125/31b721bc-d7bc-4b75-8c9a-d842a0f71685)

Now, let's delve into our database using the provided code snippets.

```
SELECT *
FROM Employees;

SELECT *
FROM Customers;

SELECT *
FROM Categories;
```

## **Task 2 : A Look at the Question and the Suggested Solution**

**Objective:** Examine the contents of the database tables to identify data tables and fields required to inform a business decision.

**Key Takeaways**

- The data analyst strives to use data to answer business questions.
- A business problem is best solved by examining the data available and visualizing which pieces of data should make up the solution.
- Data from multiple tables may be required to solve a business problem.

**Business Problem/Question:**  As a method of increasing future sales, the company has decided to give employee bonuses for exemplary performance in sales. Bonuses will be awarded to those employees who are responsible for the five highest order amounts.
**How can we identify those employees?**

```
SELECT *
FROM Orders;

SELECT *
FROM Orderdetails
ORDER BY OrderId;

SELECT *
FROM Products;
```

We are going to use 4 tables in order to solve our business problem: Employees, Orders, Order Details and  Products.

![required](https://github.com/BuseGogusger/data_analysis_with_SQL-inform_a_business_decision/assets/135744125/746d5184-a157-456a-9086-63efb7ce4d41)

## **Task 3 : Joining Tables Together in SQL to Obtain Data for Analysis**

**Objective:** Retrieve the data needed to solve a business question by joining multiple tables in SQL.

**Key Takeaways**

- To join two tables, they must share a common column.
- The SQL INNER JOIN command returns only rows that match between two tables.
- An SQL query can be keyed into the SQL Tryit editor without regard to case; however, correct spelling and punctuation is critical

**Tables/Fields Needed:**

![tables](https://github.com/BuseGogusger/data_analysis_with_SQL-inform_a_business_decision/assets/135744125/854e51fe-0329-4df9-8f29-4cd4a7578f1a)

In order to do that, we need to join tables. Here are the common columns:

![coomons](https://github.com/BuseGogusger/data_analysis_with_SQL-inform_a_business_decision/assets/135744125/8ec349e5-1966-4069-9da8-e5ea9be103dc)

```
SELECT LastName, FirstName, Orders.OrderID, Products.ProductID,
            Quantity, Price
FROM (((Employees
  INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID)
  INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID)
  INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
ORDER BY LastName, FirstName;

```
## **Task 4 : Calculate and Summarize Sales for each Order**

**Objective:** Write SQL code to calculate and aggregate data.

**Key Takeaways**

- New, temporary fields can be created as a result of a calculation in SQL.
- Aggregating or grouping data can make it more useful for decision making.
- In SQL code, the SUM() function, together with the GROUP BY clause, can be used to aggregate data.

**1.** Calculate Quantity * Price for each line item on the order.

```
SELECT LastName, FirstName, Orders.OrderID, Products.ProductID,
        	Quantity, Price, Quantity * Price as SalesAmount
FROM (((Employees
  INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID)
  INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID)
  INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
ORDER BY LastName, FirstName;
```

**2.** Add together (summarize) the line item totals to get one total sales value per order.

```
SELECT LastName, FirstName, Orders.OrderID, SUM(Quantity * Price) as SalesAmount
FROM (((Employees
  INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID)
  INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID)
  INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
GROUP BY LastName, FirstName,Orders.OrderID;
```

## **Task 5**

**Objective:** Display data in a format that can be used to inform a business decision.

**Key Takeaways**

- Limiting the number of rows that display as the result of an SQL query can be accomplished using the LIMIT command.
- In SQL code, the HAVING command applies a filter after aggregation.
- A data analyst often strives to anticipate alternative types of data that may address a business problem.

Initially, the query was formulated as follows:

```
SELECT LastName, FirstName, Orders.OrderID, SUM(Quantity * Price) as SalesAmount
FROM (((Employees
  INNER JOIN Orders ON Employees.EmployeeID = Orders.EmployeeID)
  INNER JOIN OrderDetails ON Orders.OrderID = OrderDetails.OrderID)
  INNER JOIN Products ON OrderDetails.ProductID = Products.ProductID)
GROUP BY LastName, FirstName, Orders.OrderID
ORDER BY SalesAmount DESC
LIMIT 5;

```

However, due to specific limitations within the W3Schools environment, I've adapted it as follows:

```
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
```
![top5](https://github.com/BuseGogusger/data_analysis_with_SQL-inform_a_business_decision/assets/135744125/dba13da0-d662-48d6-b2c2-98d3efb39c19)

This revised query generates a list of the top five sales amounts for orders and includes the names of the respective employees involved. Furthermore, we also desired to obtain a list of the top five employees with the highest sales amounts. Here's the corresponding SQL code:

```
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
```
![top5employee](https://github.com/BuseGogusger/data_analysis_with_SQL-inform_a_business_decision/assets/135744125/a5a87ba8-4330-4d3a-8c1d-bed384978586)

In this data analysis journey, we've not only explored the world of data but also paved the way for informed business decisions. By leveraging data insights, we empower the company to make strategic choices that drive growth and success. Now, armed with the knowledge of how to identify the top-performing employees who are responsible for the five highest order amounts, the company can take steps towards rewarding exemplary sales performance and ultimately boosting future sales.

Thank you for joining me on this data-driven adventure, where we've pulled valuable insights from a database to answer critical business question. Together, we've unlocked the potential of data analysis to inform and transform.




-- What customers are from the UK?
SELECT *
FROM Customers
WHERE Country = 'UK'

-- Find 2 customers from the UK.
SELECT *
FROM Customers
WHERE Country = 'UK'
LIMIT 2

-- What are the ids and names of the customers with the 10 smallest CustomerIDs? (ORDER BY, 10 rows, 2 columns)
SELECT CustomerID, CustomerName
FROM Customers
ORDER BY CustomerID
LIMIT 10

-- What are the ids and names of the customers with the 10 highest CustomerIDs? (DESC, 10 rows, 2 columns)
SELECT CustomerID, CustomerName
FROM Customers
ORDER BY CustomerID DESC
LIMIT 10

-- How many customers are from each country? (GROUP BY, 21 rows, 2 columns)
SELECT Country, COUNT(CustomerID)
FROM Customers
GROUP BY Country

-- What country provides the most customers? (1 row, 1 column)
SELECT a.Country
FROM
(
SELECT Country, COUNT(CustomerID) as cust
FROM Customers
GROUP BY 1
ORDER BY 2 Desc
LIMIT 1
) a

-- What is the id of the customer who has the most orders? (1 row, 1 column)
SELECT a.CustomerID
FROM
(
SELECT CustomerID, COUNT(OrderID) as ords
FROM Orders
GROUP BY 1
ORDER BY 2 Desc
LIMIT 1
) a

-- What is the name of the customer who has the most orders? (JOIN, 1 row, 1 column)
SELECT c.CustomerName
FROM
(
SELECT CustomerID, COUNT(OrderID) as ords
FROM Orders
GROUP BY 1
ORDER BY 2 Desc
LIMIT 1
) a join Customers c on a.CustomerID = c.CustomerID

-- What are the names of the customers who only have one order? (HAVING, 22 rows, 1 column)
SELECT c.CustomerName
FROM
(
SELECT CustomerID, COUNT(OrderID) as ords
FROM Orders
GROUP BY 1
HAVING ords = 1
) a join Customers c on a.CustomerID = c.CustomerID

-- What was the total price of OrderID = 10253? (1806)
SELECT Sum(o.Quantity * p.Price)
FROM
(
SELECT OrderID, ProductID, Quantity
FROM OrderDetails
WHERE OrderID = 10253
) o join
(
SELECT ProductID, Price
FROM Products
) p
on (o.ProductID = p.ProductID)

-- What supplier has the highest average product price? (Aux joyeux eccl�siastiques)
SELECT SupplierName
FROM
(
SELECT SupplierID, Avg(Price)
FROM Products
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1
) p join Suppliers s on p.SupplierID = s.SupplierID

-- What supplier has the highest average product price and more than 20 products? (Gai p�turage)
SELECT SupplierName
FROM
(
SELECT SupplierID, Avg(Price), COUNT(ProductID) as prods
FROM Products
GROUP BY 1
HAVING prods > 20
ORDER BY prods DESC
LIMIT 1
) p join Suppliers s on p.SupplierID = s.SupplierID
-- Hmm, it seems like no supplier has more than 20 products?!

What employees have BS degrees? (LIKE, 2 rows)

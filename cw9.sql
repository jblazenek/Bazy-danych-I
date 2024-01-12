/* Zadanie 1 */

WITH CTE AS 
(
    SELECT 
        e.BusinessEntityID, 
        e.JobTitle, 
        e.HireDate, 
        e.Gender, 
        p.FirstName, 
        p.LastName, 
        p.EmailPromotion, 
        p.Title
    FROM AdventureWorks2022.HumanResources.Employee e
    JOIN AdventureWorks2022.Person.Person p ON e.BusinessEntityID = p.BusinessEntityID
)
SELECT *
INTO TempEmployeeInfo
FROM CTE;


/* Zadanie 2 */

WITH StoreRevenue AS (
    SELECT
        s.Name AS StoreName,
        CONCAT(p.FirstName, ' ', p.LastName) AS ContactName,
        SUM(soh.TotalDue) AS Revenue
    FROM SalesLT.Customer c
    JOIN SalesLT.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
    JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
    JOIN SalesLT.Store s ON soh.CustomerID = s.BusinessEntityID
    GROUP BY s.Name, p.FirstName, p.LastName
)
SELECT StoreName, ContactName, Revenue
FROM StoreRevenue
ORDER BY StoreName, ContactName;


/* Zadanie 3 */

WITH CTE AS (
    SELECT 
        c.Name AS CategoryName, 
        SUM(sod.LineTotal) AS TotalSales
    FROM AdventureWorksLT2022.SalesLT.SalesOrderDetail sod
    JOIN AdventureWorksLT2022.SalesLT.Product p ON sod.ProductID = p.ProductID
    JOIN AdventureWorksLT2022.SalesLT.ProductCategory sc ON p.ProductCategoryID = sc.ProductCategoryID
    JOIN AdventureWorksLT2022.SalesLT.ProductCategory c ON sc.ParentProductCategoryID = c.ProductCategoryID
    GROUP BY c.Name
)
SELECT *
FROM CTE;

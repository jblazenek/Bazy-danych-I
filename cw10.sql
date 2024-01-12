-- Zadanie 1
BEGIN TRANSACTION;
UPDATE AdventureWorks2022.Production.Product
SET ListPrice = ListPrice * 1.1
WHERE ProductID = 680;
COMMIT TRANSACTION;

-- Zadanie 2
BEGIN TRANSACTION;
BEGIN TRY
    INSERT INTO AdventureWorks2022.Production.Product 
    VALUES ('New Product', 'XX-5678', 100, 200, 1);
    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'An error occurred. The transaction was rolled back.';
END CATCH;

-- Zadanie 3
BEGIN TRANSACTION;
DECLARE @ProductIdToDelete INT;

INSERT INTO AdventureWorks2022.Production.Product 
VALUES ('New Product', 'XX-9876', 150, 250, 2);

SET @ProductIdToDelete = SCOPE_IDENTITY();

DELETE FROM AdventureWorks2022.Production.Product
WHERE ProductID = @ProductIdToDelete;

ROLLBACK TRANSACTION;

-- Zadanie 4
BEGIN TRANSACTION;
DECLARE @sum FLOAT;

SELECT @sum = SUM(StandardCost) FROM AdventureWorks2022.Production.Product;

IF (@sum * 1.1 <= 50000)
BEGIN
    UPDATE AdventureWorks2022.Production.Product
    SET StandardCost = StandardCost * 1.1;
    COMMIT TRANSACTION;
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
END

-- Zadanie 5
BEGIN TRANSACTION;
DROP INDEX AK_Product_ProductNumber ON AdventureWorks2022.Production.Product;
DROP INDEX AK_Product_Name ON AdventureWorks2022.Production.Product;

DECLARE @ProductNumber VARCHAR(25);

SET @ProductNumber = 'XX-5678';

INSERT INTO AdventureWorks2022.Production.Product 
VALUES ('New Product', @ProductNumber, 120, 180, 3);

IF EXISTS (SELECT * FROM AdventureWorks2022.Production.Product WHERE ProductNumber = @ProductNumber)
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Transaction rolled back. Product with the same number already exists.';
END
ELSE
BEGIN 
    COMMIT TRANSACTION;
    PRINT 'Transaction committed. New product added successfully.';
END

-- Zadanie 6
BEGIN TRANSACTION;

BEGIN TRY
    UPDATE AdventureWorks2022.Sales.SalesOrderDetail
    SET OrderQty = OrderQty + 1
    WHERE OrderQty > 0;

    COMMIT TRANSACTION;
END TRY
BEGIN CATCH
    ROLLBACK TRANSACTION;
    PRINT 'An error occurred. The transaction was rolled back.';
END CATCH;

-- Zadanie 7
BEGIN TRANSACTION;

WITH avg_cost AS (
    SELECT AVG(StandardCost) AS avg_cost
    FROM AdventureWorks2022.Production.Product
)
DELETE FROM AdventureWorks2022.Production.Product
WHERE StandardCost > (SELECT avg_cost FROM avg_cost)

IF @@ROWCOUNT > 200
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Transaction rolled back. The number of products to be modified exceeds 200.';
END
ELSE
BEGIN
    COMMIT TRANSACTION;
END;

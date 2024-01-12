/* Zadanie 1 */

CREATE OR ALTER PROCEDURE dbo.PrintFibonacciSeq (@n INT)
AS
BEGIN
    IF @n <= 0
    BEGIN
        PRINT 'Provide a positive integer.';
        RETURN;
    END;

    DECLARE @FibTable TABLE (nFib INT);

    INSERT INTO @FibTable
    SELECT nFib FROM dbo.FibbonacciSeq(@n);

    DECLARE @nFib INT;

    DECLARE FibCursor CURSOR FOR
        SELECT nFib FROM @FibTable;

    OPEN FibCursor;

    FETCH NEXT FROM FibCursor INTO @nFib;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @nFib;
        FETCH NEXT FROM FibCursor INTO @nFib;
    END;

    CLOSE FibCursor;
    DEALLOCATE FibCursor;
END;

CREATE OR ALTER FUNCTION dbo.FibbonacciSeq (@n INT)
RETURNS @FibTable TABLE (nFib INT)
AS
BEGIN
    DECLARE @f1 INT = 0, @f2 INT = 1;

    WHILE @n > 0
    BEGIN
        INSERT INTO @FibTable (nFib) VALUES (@f1);
        SET @f1 = @f1 + @f2;
        SET @f2 = @f1 - @f2;
        SET @n = @n - 1;
    END;

    RETURN;
END;

/* Zadanie 2 */

CREATE OR ALTER TRIGGER TriggerUpperLastName
ON Person.Person
AFTER INSERT, UPDATE
AS
BEGIN
    UPDATE P
    SET P.LastName = UPPER(I.LastName)
    FROM Person.Person P
    INNER JOIN inserted I ON P.BusinessEntityID = I.BusinessEntityID;
END;

/* Zadanie 3 */

CREATE OR ALTER TRIGGER taxRateMonitoring
ON Sales.SalesTaxRate
AFTER UPDATE
AS
BEGIN
    IF UPDATE(TaxRate)
    BEGIN
        DECLARE @OldTaxRate SMALLMONEY;
        DECLARE @NewTaxRate SMALLMONEY;

        SELECT @OldTaxRate = TaxRate FROM deleted;
        SELECT @NewTaxRate = TaxRate FROM inserted;

        IF @NewTaxRate > @OldTaxRate * 1.3
        BEGIN
            RAISEERROR('Tax rate cannot be bigger than 30%.', 16, 1);
            ROLLBACK;
            RETURN;
        END;
    END;
END;

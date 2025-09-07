USE RestaurantDB;
GO

DROP PROCEDURE IF EXISTS sp_AddNewOrder;
GO
CREATE PROCEDURE sp_AddNewOrder(
@ReservationId INT, @EmployeeId INT, @OrderDate DATE, @TotalAmount DECIMAL(10,2)
)
AS BEGIN
  BEGIN TRY
    INSERT INTO Restaurant.[Order](OrderDate, TotalAmount, EmployeeID, ReservationID)
    OUTPUT INSERTED.OrderID
    VALUES (@OrderDate, @TotalAmount, @EmployeeId, @ReservationId);
    END TRY
    BEGIN CATCH
        PRINT 'Error inserting data: ' + ERROR_MESSAGE();
    END CATCH
END;
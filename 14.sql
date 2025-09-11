USE RestaurantDB;
GO

CREATE OR ALTER PROCEDURE Restaurant.sp_AddNewOrder(
@ReservationId INT, @EmployeeId INT, @OrderDate DATE, @TotalAmount DECIMAL(10,2)
)
AS 
BEGIN
  BEGIN TRY
    IF EXISTS
    (
        SELECT 1 FROM Restaurant.[Order]
        WHERE ReservationID = @ReservationId
    )
        THROW 51000, 'An order already exists for this reservation.', 1;
    IF @OrderDate IS NULL 
         THROW 51001, 'Order Date cannot be NULL', 1;

    IF NOT EXISTS (SELECT 1 FROM Restaurant.Reservation WHERE ReservationID = @ReservationId)
          THROW 51002, 'Reservation does not exist.', 1;

    IF @TotalAmount IS NULL OR @TotalAmount <0
         THROW 51003, 'Order Amount cannot be negative', 1;

    IF NOT EXISTS 
    (
    SELECT 1 FROM Restaurant.Employee AS e
    WHERE e.EmployeeID = @EmployeeId
    )
         THROW 51004, 'Employee does not exist', 1;

    INSERT INTO Restaurant.[Order](OrderDate, TotalAmount, EmployeeID, ReservationID)
    OUTPUT INSERTED.OrderID
    VALUES (@OrderDate, @TotalAmount, @EmployeeId, @ReservationId);
    END TRY
    BEGIN CATCH
        --PRINT 'Error inserting data: ' + ERROR_MESSAGE();
     DECLARE @ErrorMessage NVARCHAR(4000);
      SELECT @ErrorMessage = ERROR_MESSAGE();
      PRINT(@ERRORMESSAGE);
    END CATCH
END;
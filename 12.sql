USE RestaurantDB;
GO

CREATE FUNCTION Restaurant.fn_CalculateEmployeeSalary(
@EmployeeId INT 
)
RETURNS FLOAT AS
BEGIN
DECLARE @salary FLOAT;
DECLARE @orders_num int;
DECLARE @emp_rank int;
DECLARE @position char(20);

SELECT @orders_num = COUNT(*)
FROM Restaurant.[Order] AS r
WHERE r.EmployeeID = @EmployeeId;
 
SELECT @position = position
FROM Restaurant.Employee
WHERE Restaurant.Employee.EmployeeID = @EmployeeId;

SET @emp_rank = 3
IF (@position = 'StandardWaiter')SET @emp_rank = 4;
IF (@position = 'VIPOrdersWaiter')SET @emp_rank = 5;

SET @salary = @emp_rank * @orders_num;
IF @salary IS NULL
    SET @salary = 0;
RETURN @salary;
END
GO
-- Create a sample database
CREATE DATABASE SampleDB;
GO

USE SampleDB;
GO

-- Create a sample table
CREATE TABLE Users (
    Id INT PRIMARY KEY IDENTITY(1,1),
    Username NVARCHAR(50) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    CreatedAt DATETIME2 DEFAULT GETDATE(),
    IsActive BIT DEFAULT 1
);
GO

-- Create another table
CREATE TABLE Orders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    UserId INT FOREIGN KEY REFERENCES Users(Id),
    OrderDate DATETIME2 DEFAULT GETDATE(),
    TotalAmount DECIMAL(10,2),
    Status NVARCHAR(20) DEFAULT 'Pending'
);
GO

-- Create a stored procedure
CREATE PROCEDURE sp_GetActiveUsers
AS
BEGIN
    SELECT Id, Username, Email, CreatedAt
    FROM Users
    WHERE IsActive = 1
    ORDER BY CreatedAt DESC;
END;
GO

-- Create a view
CREATE VIEW vw_RecentOrders AS
SELECT 
    o.OrderId,
    u.Username,
    o.OrderDate,
    o.TotalAmount,
    o.Status
FROM Orders o
INNER JOIN Users u ON o.UserId = u.Id
WHERE o.OrderDate > DATEADD(day, -30, GETDATE());
GO
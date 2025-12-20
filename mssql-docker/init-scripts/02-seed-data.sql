USE SampleDB;
GO

-- Insert sample users
INSERT INTO Users (Username, Email) VALUES
('john_doe', 'john@example.com'),
('jane_smith', 'jane@example.com'),
('bob_wilson', 'bob@example.com'),
('alice_johnson', 'alice@example.com');

-- Insert sample orders
INSERT INTO Orders (UserId, TotalAmount, Status) VALUES
(1, 99.99, 'Completed'),
(1, 49.99, 'Pending'),
(2, 149.99, 'Completed'),
(3, 29.99, 'Shipped'),
(4, 199.99, 'Completed');

-- Create an index
CREATE INDEX IX_Users_Email ON Users(Email);
GO

-- Create a non-admin user for application use
CREATE LOGIN AppUser WITH PASSWORD = 'AppUser!Pass123';
CREATE USER AppUser FOR LOGIN AppUser;
ALTER ROLE db_datareader ADD MEMBER AppUser;
ALTER ROLE db_datawriter ADD MEMBER AppUser;
GO

-- Print success message
PRINT 'Database initialization completed successfully!';
GO
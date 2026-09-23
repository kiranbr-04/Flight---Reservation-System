USE ReservationDB;
GO

-- Insert sample users
INSERT INTO Users (Name, Email, Password, Phone) VALUES 
('John Doe', 'john@example.com', 'password123', '1234567890'),
('Jane Smith', 'jane@example.com', 'pwd456', '0987654321');
GO

-- Insert sample transports
INSERT INTO Transport (Name, Source, Destination, DepartureTime, Seats, Price) VALUES 
('Flight Express Air-101', 'New York', 'London', DATEADD(day, 5, GETDATE()), 150, 450.00),
('Train Express Alpha', 'Chicago', 'Los Angeles', DATEADD(day, 2, GETDATE()), 300, 120.00),
('Flight Delta-202', 'Paris', 'Tokyo', DATEADD(day, 10, GETDATE()), 200, 850.50),
('Train Beta-Fast', 'Berlin', 'Munich', DATEADD(day, 1, GETDATE()), 100, 45.00),
('Flight Jet-303', 'San Francisco', 'New York', DATEADD(day, 7, GETDATE()), 180, 320.00),
('Train Gamma-Night', 'London', 'Edinburgh', DATEADD(day, 3, GETDATE()), 250, 65.00);
GO

CREATE DATABASE ReservationDB;
GO

USE ReservationDB;
GO

CREATE TABLE Users (
    UserID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20) NOT NULL
);

CREATE TABLE Transport (
    TransportID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Source NVARCHAR(100) NOT NULL,
    Destination NVARCHAR(100) NOT NULL,
    DepartureTime DATETIME NOT NULL,
    Seats INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL
);

CREATE TABLE Booking (
    BookingID INT IDENTITY(1,1) PRIMARY KEY,
    UserID INT NOT NULL FOREIGN KEY REFERENCES Users(UserID),
    TransportID INT NOT NULL FOREIGN KEY REFERENCES Transport(TransportID),
    SeatNo NVARCHAR(10) NOT NULL,
    JourneyDate DATE NOT NULL,
    Status NVARCHAR(20) DEFAULT 'Booked',
    PaymentMethod NVARCHAR(50)
);

CREATE TABLE Admin (
    AdminID INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(100) NOT NULL UNIQUE,
    Password NVARCHAR(100) NOT NULL
);

-- Insert default admin
INSERT INTO Admin (Username, Password) VALUES ('admin', 'admin123');

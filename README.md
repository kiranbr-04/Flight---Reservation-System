# Flight & Reservation System

## Requirements
* Visual Studio (2019 or later recommended)
* SQL Server (Express or Developer Edition)
* .NET Framework 4.8

## Setup Instructions

### 1. Database Setup
1. Open **SQL Server Management Studio (SSMS)**.
2. Connect to your local database engine (usually `localhost\SQLEXPRESS`).
3. Open the `Database.sql` file provided in this folder.
4. Execute the script. It will create the `ReservationDB` database, all necessary tables, and insert a default Admin account.
   * Default Admin Username: `admin`
   * Default Admin Password: `admin123`

### 2. Project Setup
1. Open **Visual Studio**.
2. Select **Continue without code**.
3. Go to **File -> Open -> Web Site...**
4. Select the `ReservationSystem` folder.
5. Visual Studio will load the website project.

### 3. Connection String Setup
If your SQL server instance is not `localhost\SQLEXPRESS`:
1. Open `Web.config` in Visual Studio.
2. Update the `connectionString` attribute in the `<connectionStrings>` block to match your SQL Server instance name.

### 4. Running the Application
1. Right-click on `Home.aspx` in the Solution Explorer and select **Set As Start Page**.
2. Press `F5` or the generic **Run / IIS Express** button at the top.
3. The site will open in your default browser.

## Features
### User Flow
* Register a new user account.
* Login to the account.
* Search for available transport routes based on source and destination.
* Select a transport and book a ticket with a custom seat number.
* View your booked tickets in "My Bookings" and cancel them.

### Admin Flow
* Login via Admin Login page (default route `AdminLogin.aspx`).
* Dashboard displays total users, transports, and bookings.
* Manage Transports: Add, Edit, Delete transport options.
* View Bookings: See all bookings made by any user.
"# Flight---Reservation-System" 

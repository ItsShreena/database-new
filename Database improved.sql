-- Creating the Database
CREATE DATABASE MedicalInventoryDataB;
USE MedicalInventoryDataB;

--  Creating the Suppliers Table
CREATE TABLE Suppliers (
    SupplierID INT PRIMARY KEY AUTO_INCREMENT,
    SupplierName VARCHAR(255) NOT NULL,
    ContactPerson VARCHAR(100),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(255) NOT NULL
);

--  Creating the Medicines Table
CREATE TABLE Medicines (
    MedicineID INT PRIMARY KEY AUTO_INCREMENT,
    MedicineName VARCHAR(255) NOT NULL,
    Category VARCHAR(100),
    ExpiryDate DATE,
    UnitPrice DECIMAL(10, 2),
    SupplierID INT,
    BatchNumber VARCHAR(50),
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE CASCADE
);

--  Creating the Inventory Table
CREATE TABLE Inventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    MedicineID INT NOT NULL,
    QuantityInStock INT NOT NULL,
    LastRestocked DATE,
    ExpiryDate DATE NOT NULL,
    FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID) ON DELETE CASCADE
);

--  Creating the MedicineInventory Table
CREATE TABLE MedicineInventory (
    InventoryID INT PRIMARY KEY AUTO_INCREMENT,
    MedicineID INT NOT NULL,
    NumberOfMeds INT NOT NULL,
    Threshold INT NOT NULL,
    SupplierName VARCHAR(255) NOT NULL,
    SupplierEmail VARCHAR(255) NOT NULL,
    FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID) ON DELETE CASCADE
);

--  Creating the Orders Table
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    MedicineID INT NOT NULL,
    OrderDate DATE NOT NULL,
    QuantityOrdered INT NOT NULL,
    SupplierID INT NOT NULL,
    Status ENUM('Pending', 'Shipped', 'Delivered', 'Cancelled') DEFAULT 'Pending',
    FOREIGN KEY (MedicineID) REFERENCES Medicines(MedicineID) ON DELETE CASCADE,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID) ON DELETE CASCADE
);

--  Creating the Staff Table
CREATE TABLE Staff (
    StaffID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100),
    Role VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber VARCHAR(20),
    Username VARCHAR(50) UNIQUE NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL -- Requires manual password entry
);
-- Inserting Sample Data into Suppliers
INSERT INTO Suppliers (SupplierName, ContactPerson, PhoneNumber, Email)
VALUES 
('HealthSupplies Co.', 'Verma & Co', '976-456-7890', 'verma@healthsupplies.com'),
('MedGlobal', 'Ram Ratan', '987-654-3210', 'ratan@medglobal.com'),
('HealthIndia Co.', 'Krishna&co', '167-654-0000', 'krishna@healthIndia.com'),
('A1suppliers', 'A1meds',  '997-654-3990','A1@suppliers.com'),
('RajMeds Co.', 'RajGroups', '987-784-3200', 'raj@healthsupplies.com');

--  Inserting Sample Data into Medicines
INSERT INTO Medicines (MedicineName, Category, ExpiryDate, UnitPrice, SupplierID, BatchNumber)
VALUES 
('Paracetamol', 'Pain Relief', '2025-12-31', 1.50, 1, 'BATCH001'),
('Ibuprofen', 'Pain Relief', '2024-10-31', 2.00, 2, 'BATCH002'),
('Aspirin', 'Pain Relief', '2025-09-30', 1.00, 1, 'BATCH003'),
('Amoxicillin', 'Antibiotic', '2026-01-15', 3.00, 2, 'BATCH004'),
('Cetirizine', 'Antihistamine', '2025-12-10', 1.20, 1, 'BATCH005');

--  Inserting Sample Data into Inventory
INSERT INTO Inventory (MedicineID, QuantityInStock, LastRestocked, ExpiryDate)
VALUES 
(1, 500, '2024-10-01', '2025-12-31'), 
(2, 300, '2024-10-05', '2024-10-31'), 
(3, 400, '2024-09-15', '2025-09-30'), 
(4, 600, '2024-09-18', '2026-01-15'), 
(5, 350, '2024-09-20', '2025-12-10'); 

--  Inserting Sample Data into MedicineInventory
INSERT INTO MedicineInventory (MedicineID, NumberOfMeds, Threshold, SupplierName, SupplierEmail)
VALUES 
(1, 50, 20, 'HealthSupplies Co.', 'verma@healthsupplies.com'),
(2, 100, 50, 'MedIndia', 'ratan@medIndia.com'),
(3, 30, 10, 'HealthIndia Co.', 'krishna@healthIndia.com'),
(4, 70, 25, 'A1suppliers', 'A1@suppliers.com'),
(5, 60, 30, 'RajMeds Co.', 'raj@healthsupplies.com');

-- Inserting Sample Data into Orders
INSERT INTO Orders (MedicineID, OrderDate, QuantityOrdered, SupplierID, Status)
VALUES 
(1, '2024-10-10', 200, 1, 'Pending'),    
(2, '2024-10-11', 100, 2, 'Shipped'),    
(3, '2024-09-25', 150, 1, 'Delivered'),    
(4, '2024-09-26', 200, 2, 'Cancelled'),   
(5, '2024-09-27', 100, 1, 'Pending');

-- Inserting Sample Data into Staff with Manual Passwords
INSERT INTO Staff (FirstName, LastName, Role, Email, PhoneNumber, Username, PasswordHash)
VALUES 
('Kanishka', 'Agrawal', 'Inventory Manager', 'kanishkaagrawal@example.com', '9588403356', 'Kanishhka', '1234'),
('Yug', 'Kochar', 'Pharmacist', 'yugkochar@example.com', '8966940333', 'Yugk', '5678');

-- View All Data
SELECT * FROM Suppliers;
SELECT * FROM Medicines;
SELECT * FROM Inventory;
SELECT * FROM MedicineInventory;
SELECT * FROM Orders;
SELECT * FROM Staff;

-- Checking Number of Medicines
SELECT COUNT(*) AS TotalMedicines FROM Medicines;

-- Droping Database (if needed)
 DROP DATABASE MedicalInventoryDataB;

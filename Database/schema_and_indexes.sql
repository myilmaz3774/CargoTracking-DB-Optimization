CREATE DATABASE CargoTrackingDB;
USE CargoTrackingDB;

-- 1. Şubeler Tablosu
CREATE TABLE Branches (
    BranchId INT AUTO_INCREMENT PRIMARY KEY,
    BranchName VARCHAR(100) NOT NULL,
    City VARCHAR(50) NOT NULL
);

-- 2. Müşteriler Tablosu (Gönderici/Alıcı)
CREATE TABLE Customers (
    CustomerId INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) UNIQUE NOT NULL
);

-- 3. Kargolar Tablosu (3NF'ye uygun tasarım)
CREATE TABLE Shipments (
    TrackingNumber VARCHAR(20) PRIMARY KEY,
    SenderId INT NOT NULL,
    ReceiverId INT NOT NULL,
    OriginBranchId INT NOT NULL,
    Weight DECIMAL(5,2) NOT NULL,
    ShipmentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    CurrentStatus VARCHAR(50) DEFAULT 'Şubede Bekliyor',
    FOREIGN KEY (SenderId) REFERENCES Customers(CustomerId),
    FOREIGN KEY (ReceiverId) REFERENCES Customers(CustomerId),
    FOREIGN KEY (OriginBranchId) REFERENCES Branches(BranchId)
);

-- 4. Kargo Hareket Dökümü (Log/Tracking Tablosu)
CREATE TABLE TrackingLogs (
    LogId INT AUTO_INCREMENT PRIMARY KEY,
    TrackingNumber VARCHAR(20) NOT NULL,
    CurrentBranchId INT,
    LogTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    StatusMessage VARCHAR(255) NOT NULL,
    FOREIGN KEY (TrackingNumber) REFERENCES Shipments(TrackingNumber),
    FOREIGN KEY (CurrentBranchId) REFERENCES Branches(BranchId)
);

-- OPTİMİZASYON: Sık aranan sütunlar için Index oluşturma
CREATE INDEX IDX_Shipment_Status ON Shipments(CurrentStatus);
CREATE INDEX IDX_Tracking_Date ON TrackingLogs(LogTime);

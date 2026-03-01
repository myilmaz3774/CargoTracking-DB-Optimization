USE CargoTrackingDB;

-- SAKLI YORDAM (Stored Procedure): Yeni kargo hareketi eklendiğinde güvenli işlem yapma
DELIMITER //
CREATE PROCEDURE AddTrackingLog (
    IN p_TrackingNumber VARCHAR(20),
    IN p_BranchId INT,
    IN p_StatusMessage VARCHAR(255)
)
BEGIN
    -- Hareketi Log tablosuna ekle
    INSERT INTO TrackingLogs (TrackingNumber, CurrentBranchId, StatusMessage)
    VALUES (p_TrackingNumber, p_BranchId, p_StatusMessage);
    
    -- Ana kargo tablosundaki güncel durumu otomatik güncelle (Optimizasyon)
    UPDATE Shipments 
    SET CurrentStatus = p_StatusMessage 
    WHERE TrackingNumber = p_TrackingNumber;
END //
DELIMITER ;

-- TETİKLEYİCİ (Trigger): Bir kargo 'Teslim Edildi' olduğunda yapılacak otomatik işlem
DELIMITER //
CREATE TRIGGER trg_AfterShipmentDelivered
AFTER UPDATE ON Shipments
FOR EACH ROW
BEGIN
    IF NEW.CurrentStatus = 'Teslim Edildi' AND OLD.CurrentStatus != 'Teslim Edildi' THEN
        -- Buraya teslimat sonrası mail atma veya loglama işlemleri için tablo kayıtları eklenebilir.
        INSERT INTO TrackingLogs (TrackingNumber, StatusMessage) 
        VALUES (NEW.TrackingNumber, 'Sistem: Teslimat süreci başarıyla tamamlandı.');
    END IF;
END //
DELIMITER ;

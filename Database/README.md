# 📦 Kargo-Takip Sistemi & Veritabanı Optimizasyonu

Bu repo, İlişkisel Veritabanı Yönetim Sistemleri (RDBMS) dersi kapsamında akademik bir proje olarak geliştirilen, normalizasyon kurallarına tam uyumlu ve sorgu optimizasyonu yapılmış bir kargo takip sistemi veritabanı mimarisini içermektedir.

## 🎯 Projenin Odak Noktası
Geleneksel yazılım projelerinden farklı olarak bu proje, kod tarafındaki mantıktan (Backend) ziyade doğrudan **Veritabanı Katmanındaki (Database Layer)** performansa, veri bütünlüğüne (Data Integrity) ve İlişkisel Cebir kurallarına odaklanmaktadır.

## ⚙️ Tasarım Prensipleri ve Optimizasyonlar
* **Normalizasyon (1NF, 2NF, 3NF):** Veri tekrarını (Redundancy) önlemek amacıyla Müşteri, Şube, Kargo ve Hareket Dökümü (Log) tabloları ilişkisel kurallara göre bağımsızlaştırılmıştır.
* **Sorgu Optimizasyonu (Indexing):** Milyonlarca satır verinin içinde kargo takip numarasının ve hareket tarihlerinin hızlı sorgulanabilmesi için `B-Tree İndeksleme` stratejisi kullanılmıştır.
* **Veritabanı Programlama (Stored Procedures & Triggers):**
  * Uygulama (Backend) tarafına yük bindirmemek için veri güncellemeleri Saklı Yordamlar (Stored Procedures) ile doğrudan SQL sunucusunda yapılmıştır.
  * Tetikleyiciler (Triggers) kullanılarak ana tablodaki durum değişikliklerinde log tablolarının otomatik güncellenmesi sağlanmıştır.

## 📂 Dosya İçerikleri
* `Database/schema_and_indexes.sql`: Tablo mimarisi, DDL komutları ve performans indeksleri.
* `Database/optimized_queries.sql`: İş kurallarını (Business Rules) veritabanı seviyesinde çözen T-SQL/MySQL scriptleri.

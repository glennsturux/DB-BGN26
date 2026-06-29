-- membuat database
CREATE DATABASE Pert8_NPM;
USE Pert8_NPM;

--Membuat table product
CREATE TABLE Product (
    Product_id INT PRIMARY KEY,
    Product_name NVARCHAR(50),
    Stock INT
);

--insert data ke dalam table product
INSERT INTO product VALUES
(101, 'Smartphone', 12),
(102, 'Laptop', 15),
(103, 'iPad', 8),
(104, 'Headphone', 20),
(105, 'Keyboard', 10);

--Melihat tabel product 
SELECT * FROM product

--Membuat table Transactions
CREATE TABLE Sales (
    Sale_id INT PRIMARY KEY,             
    Product_id INT,
    Quantity INT,
    Sale_Date DATE,

    CONSTRAINT FK_Product FOREIGN KEY (Product_id)
	REFERENCES product(Product_id)
);

--Melihat tabel Sales
SELECT * FROM Sales;

--1
CREATE TRIGGER trg_UpdateStock
ON Sales
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Kurangi stok produk berdasarkan data transaksi yang diinsert
    UPDATE product
    SET Stock = Stock - i.Quantity
    FROM product P
    INNER JOIN Inserted i ON P.Product_id = i.Product_id;

    -- Validasi stok tidak boleh negatif
    IF EXISTS (
        SELECT 1
        FROM product
        WHERE Stock < 0
    )
    BEGIN
        -- Rollback transaksi jika stok negatif
        RAISERROR ('Stok tidak mencukupi untuk transaksi ini.', 16, 1);
        ROLLBACK TRANSACTION;
    END
END;


--2
CREATE TRIGGER trg_CheckStockBeforeSales
ON Sales
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Periksa stok produk yang diinsert melalui tabel Inserted
    IF EXISTS (
        SELECT 1
        FROM Inserted i
        INNER JOIN product AS p 
		ON i.Product_id = p.Product_id
        WHERE i.Quantity > p.Stock
    )
    BEGIN
        -- Jika stok tidak mencukupi, batalkan transaksi dan tampilkan pesan error
        RAISERROR ('Mohon maaf stok produk tidak mencukupi', 16, 1);
        ROLLBACK TRANSACTION;
    END
    ELSE
    BEGIN
        -- Jika stok mencukupi, lanjutkan transaksi
        INSERT INTO Sales (Sale_id, Product_id, Quantity, Sale_Date)
        SELECT Sale_id, Product_id, Quantity, Sale_Date
        FROM Inserted;
		PRINT('Data Penjualan Berhasil Ditambahkan Ke Tabel Sales')
    END
END;

--3a
INSERT INTO Sales (Sale_id, Product_id, Quantity, Sale_Date)
VALUES (1, 101, 15, GETDATE());

SELECT * FROM product;
SELECT * FROM Sales;


--3b
INSERT INTO Sales (Sale_id, Product_id, Quantity, Sale_Date)
VALUES (2, 103, 10, '2024-12-01');

SELECT * FROM product;
SELECT * FROM Sales;


--3c
INSERT INTO Sales (Sale_id, Product_id, Quantity, Sale_Date)
VALUES (3, 102, 10, '2024-12-01');

SELECT * FROM product;
SELECT * FROM Sales;


--3d
INSERT INTO Sales (Sale_id, Product_id, Quantity, Sale_Date)
VALUES (4, 104, 15, '2024-12-01');

SELECT * FROM product;
SELECT * FROM Sales;


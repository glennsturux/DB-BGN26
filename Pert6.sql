CREATE DATABASE Pert6_NPM;
USE Pert6_NPM;


--1
DECLARE @sisi FLOAT; 
DECLARE @luasPersegi FLOAT; 

SET @sisi = 8.5;
SET @luasPersegi = @sisi * @sisi;
PRINT 'Luas persegi dengan sisi ' + CAST(@sisi AS VARCHAR) + ' adalah ' + CAST(@luasPersegi AS VARCHAR);


--2
--a
CREATE PROCEDURE TambahData
    @npm VARCHAR(8),
    @nama VARCHAR(50),
    @kelas VARCHAR(5),
    @jurusan VARCHAR(30)
AS
BEGIN
    -- Insert data ke tabel Mahasiswa
    INSERT INTO Mahasiswa (npm, nama, kelas, jurusan)
    VALUES (@npm, @nama, @kelas, @jurusan);
    
    -- Konfirmasi data berhasil dimasukkan
    PRINT 'Data Mahasiswa berhasil ditambahkan!';
END;

--b
CREATE TABLE Mahasiswa (
    npm VARCHAR(8) PRIMARY KEY,
    nama VARCHAR(50),
    kelas VARCHAR(5),
    jurusan VARCHAR(30)
);

--c
EXEC TambahData @npm = '30121453', @nama = 'Farras Rasendriya', @kelas = '4ID01', @jurusan = 'Teknik Industri';


--d
SELECT * FROM Mahasiswa;


--3
CREATE CLUSTERED INDEX IDX_Mahasiswa_Farras
ON Mahasiswa (Nama);
EXEC sp_helpindex 'Mahasiswa';

--pasti bakal error karena udah ada PK di tabel Mahasiswa
--kita cek constraint PK di tabel mahasiswa apakah benar udah ada clustered index-nya?
SELECT
	constraint_name,
	constraint_type
FROM information_schema.table_constraints
WHERE table_name = 'Mahasiswa';

--hapus constraint PK table mahasiswa
ALTER TABLE mahasiswa
DROP CONSTRAINT PK__Mahasisw__DF90E5C9396865DF;

--kita buat lagi clustered index nya
CREATE CLUSTERED INDEX IDX_Mahasiswa_Farras
ON Mahasiswa (Nama);
--terus kita cek lagi udah ada atau engga si index nya
EXEC sp_helpindex 'Mahasiswa';

--kalau Hapus index
DROP INDEX IDX_Mahasiswa_Farras
--4
CREATE NONCLUSTERED INDEX IDX_Mahasiswa_TeknikIndustri
ON Mahasiswa (JURUSAN);
EXEC sp_helpindex 'Mahasiswa';


--gausah dipakai yang dibawah ini
--Query Tambahan (FYI)
CREATE TABLE Mahasiswa (
    NPM VARCHAR(8) PRIMARY KEY,
	-- Membuat Clustered index pada kolom Nama (SQL Server 2022 ke atas)
    Nama VARCHAR(50) INDEX IDX_Mahasiswa_Nama CLUSTERED,
    Kelas VARCHAR(5) NOT NULL,
	-- Membuat Non-Clustered index pada kolom Jurusan (SQL Server 2022 ke atas)
    Jurusan VARCHAR(30) INDEX IDX_Mahasiswa_Jurusan NONCLUSTERED
);
EXEC sp_helpindex 'Mahasiswa';

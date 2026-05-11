--1
CREATE DATABASE Pert5_NPM;
USE Pert5_NPM;

DROP LOGIN Staff_NPM;
Drop USER Staff;

--hapus member dari role
ALTER ROLE Staff_Role DROP MEMBER Staff;

--hapus role
DROP ROLE Staff_Role;

--Kalau masih error karena role punya permission, revoke dulu:
Kalau masih error karena role punya permission, revoke dulu:

--CEK LOGIN
SELECT * FROM sys.sql_logins;

--CEK ROLE
SELECT * FROM sys.database_principals;
--2
CREATE LOGIN Staff_NPM
WITH PASSWORD = 'Staff123',
CHECK_POLICY = OFF;

CREATE LOGIN Asisten_NPM
WITH PASSWORD = 'Asisten123',
CHECK_POLICY = OFF;

CREATE LOGIN Praktikan_NPM
WITH PASSWORD = 'Praktikan123',
CHECK_POLICY = OFF;

ALTER LOGIN Staff_NPM ENABLE;

--3
CREATE USER Staff FOR LOGIN Staff_NPM;
CREATE USER Asisten FOR LOGIN Asisten_NPM;
CREATE USER Praktikan FOR LOGIN Praktikan_NPM;

--4
CREATE ROLE Staff_Role;
ALTER ROLE Staff_Role ADD MEMBER Staff;

--5
GRANT CREATE TABLE TO Staff_Role;
GRANT ALTER, SELECT, INSERT, UPDATE, DELETE ON SCHEMA::dbo TO Staff_Role;

--ATAU--

GRANT CONTROL ON SCHEMA::dbo TO Staff_Role;

--Sudah Mencakup CREATE, ALTER, SELECT, INSERT, UPDATE, DELETE--

--6
GRANT SELECT ON SCHEMA::dbo TO Praktikan;

--7
--LOGIN SEBAGAI STAFF
--BUAT TABLE
CREATE TABLE data_praktikan (
	npm CHAR(8) NOT NULL PRIMARY KEY,
    nama VARCHAR(50) NOT NULL,
    jurusan VARCHAR(30) NOT NULL,
    kelas VARCHAR(5)NOT NULL,
    no_hp VARCHAR(13) NOT NULL);

--MASUKKAN 1 DATA SEBAGAIN PERCOBAAN
    INSERT INTO data_praktikan VALUES
('51423183', 'NAMA', 'Teknik Informatika', '3IA08', '081287138898');
SELECT * FROM data_praktikan;
  
--UPDATE
UPDATE data_praktikan SET nama = 'Raffi Ahmad' WHERE npm = '51423183';
SELECT * FROM data_praktikan;

--8
--LOGIN SEBAGAI PRAKTIKKAN
use Pert5_NPM

SELECT * FROM dbo.data_praktikan;

INSERT INTO dbo.data_praktikan VALUES
('12110354', 'Fazriyati', 'Sistem Informasi', '4ka18', '0818141233');


--####
SELECT session_id
FROM sys.dm_exec_sessions
WHERE login_name = 'Praktikan_NPM';
KILL 54; KILL 58; KILL 59;










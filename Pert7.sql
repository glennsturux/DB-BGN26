--1
Create Database Pert7_NPM
use Pert7_NPM


--2A
CREATE TABLE MAHASISWA (
    NPM INT PRIMARY KEY,
    NAMA VARCHAR(20),
    KELAS VARCHAR(10),
    KD_MK VARCHAR(10)
);

--2B
CREATE TABLE DOSEN (
    NID INT PRIMARY KEY,
    NAMA VARCHAR(20),
    ALAMAT VARCHAR(30),
    KD_MK VARCHAR(10)
);

--2C
CREATE TABLE MATAKULIAH (
    KD_MK VARCHAR(10) PRIMARY KEY,
    NID INT,
    NPM INT,
    NM_MATKUL VARCHAR(10)
);

--3
Object Explorer > Server Object > Backup Devices > New Backup Device(Klik kanan Backup Devices)
backup_data_1_npm.bak

--4
CREATE TABLE MAHASISWA (
    NPM INT PRIMARY KEY,
    NAMA VARCHAR(20),
    NILAI int
);


--5
Object Explorer > Databases > Pert7_NPM > Task(Klik kanan Pert7_NPM) > Back up...(Langusng Di Ok-in aja)

'Kalau gagal'
BACKUP DATABASE Pert7_NPM
TO DISK = 'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.LEPKOMF4112\MSSQL\Backup\Pert7_NPM.bak';

--6
DROP TABLE MAHASISWA;
Use Master;

'Kalau gagal'
RESTORE DATABASE Pert7_NPM
FROM DISK = 'C:\Program Files (x86)\Microsoft SQL Server\MSSQL10_50.LEPKOMF4112\MSSQL\Backup\Pert7_NPM.bak';







SELECT * FROM emp;
SELECT * FROM dept;
SELECT * FROM bonus;
SELECT * FROM salgrade;

--1
SELECT 
	LOWER(ename) AS Nama, 
	LEN(ename) AS Panjang
FROM emp
WHERE deptno = 10;

--2
SELECT 
	ename AS [Nama Karyawan],
	ABS(sal + (sal * 0.1)) AS [Total Gaji]
FROM emp;

--3
SELECT TOP 1
	ename, hiredate
FROM emp
ORDER BY hiredate DESC;

--4
SELECT 
	ename AS "Nama Karyawan",
	CASE
		WHEN sal < 1500 THEN 'Gaji Rendah' 
		WHEN sal BETWEEN 1500 AND 3000 THEN 'Gaji Sedang'
		ELSE 'Gaji Tinggi'
	END AS Kategori_Gaji
FROM EMP;
--ORDER BY "Kategori_Gaji";

--5
CREATE VIEW V_Dept_Sales73 AS
	SELECT emp.ename, emp.job, dept.dname, emp.sal
	FROM emp
	INNER JOIN dept
	ON emp.deptno = dept.deptno
	WHERE emp.deptno = (
		SELECT deptno 
		FROM dept 
		WHERE dname = 'SALES');

--alternatif
CREATE VIEW V_Dept_Sales73 AS
SELECT ename, job, sal
FROM emp
WHERE deptno = (
	SELECT deptno 
	FROM dept 
	WHERE dname = 'SALES');

--menampilkan data pada view 
SELECT * FROM V_Dept_Sales73;

--6
--sebelum view di update
SELECT * FROM V_Dept_Sales73
WHERE ename = 'WARD';

--update
UPDATE V_Dept_Sales73
SET sal = 2000
WHERE ename = 'WARD';

--setelah view di update
SELECT * FROM V_Dept_Sales73
WHERE ename = 'WARD';


--7
DROP VIEW V_Dept_Sales73;

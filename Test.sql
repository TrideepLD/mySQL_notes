/* Creating the table */
CREATE TABLE Test1(
	IntDatatype INT(5)PRIMARY KEY,
	VarcharDatatype VARCHAR(15) NOT NULL,
    DateDatatype DATE,
    FloatDatatype FLOAT(7,2),
    DoubleDatatype DOUBLE(15,8),
    DatetimeDatatype DATETIME
);


/*Creating a Table From the original*/
CREATE TABLE Test2 AS SELECT * FROM test1;
/* To copy table without its data, add 'WHERE 1=0' after 'SELECT * FROM test1;'*/


/*If you only need to copy a few columns*/
CREATE TABLE Test3 
AS 
SELECT DatetimeDatatype, VarcharDatatype, FloatDatatype 
FROM test1;


/* To add a column to the table*/
ALTER TABLE test3 ADD extra VARCHAR(10)


/* To modify an existing Column*/
ALTER TABLE test3 
MODIFY extra FLOAT(10,2)


/* To delete or drop column */
ALTER TABLE test3 DROP COLUMN extra;
/* Can Execute multiple drops 
but requires DROP COLUMN to be written each time*/
/* DROP TABLE test3 Deletes the table */


/* TRUNCATE Removes all records in myssql w/o where clause*/
TRUNCATE TABLE test3;


/* DELETE is sued to delete a single record
or multiple records in MYSQL table*/
DELETE FROM test3 
WHERE VarcharDatatype = 'Something' 
AND FloatDatatype < 2500.00;


/* To create Index */
CREATE INDEX FUCK_YOU
ON test3(VarcharDatatype)

/* To drop index */
DROP INDEX FUCK_YOU;


/* To select a row */
SELECT VarcharDatatype
FROM test3
WHERE VarcharDatatype = 'FUCK_YOU' /* This basically specifies*/


/* Group By 
Lists the groups of Jobs there are*/
SELECT job from emp
   GROUP BY job;
/* JOB
---------
ANALYST
CLERK
MANAGER
PRESIDENT
SALESMAN
*/


/* Count */
SELECT Count(*) FROM emp

SELECT job, count(*) from emp group by job;
/*
JOB               COUNT(*)
---------         ---------------
ANALYST            2
CLERK              4
MANAGER            3
PRESIDENT          1
SALESMAN           4
*/
--Count the amount of Rows in table emp/*


/* Use of things like SUM, MAX, MIN, AVG*/
SELECT AVG(sal) 
FROM emp
WHERE job = 'MANAGER' 

/*
AVG(SAL)
2758.3333
*/

SELECT job, SUM(sal), AVG(sal), MAX(sal), MIN(sal) 
FROM emp 
Group by job;
/*
JOB            SUM(SAL)    AVG(SAL)     MAX(SAL)   MIN(SAL)
---------     ----------  ----------   ---------- ----------
ANALYST         6000       3000          3000       3000
CLERK           4150       1037.5        1300        800
MANAGER         8275       2758.3333     2975       2450
PRESIDENT       5000       5000          5000       5000
SALESMAN        5600       1400          1600       1250

*/

/* Using Having */
SELECT deptno, AVG(sal), COUNT(*) 
FROM emp 
GROUP BY deptno 
HAVING COUNT(*) > 5;
/*
DEPTNO   AVG(SAL)   COUNT(*)
-------- ---------- ---------- 
      30 1566.66667        6
*/

/* The useful shit*/
SELECT   table1.columnName3
FROM     table1, table2, table3
WHERE    table1.columnName3=buyer 
AND  	 table2=table2.column1
AND  	 table3.column2=“telephony”


Select empno, ename, emp.deptno, dname 
From emp, dept
Where emp.deptno = dept.deptno;



/* To select the max value of a column*/
SELECT ename, sal 
From emp 
Where sal = (Select MAX(sal) from emp);



/* Lists employees that do not work in the same department as King*/
Select ename, deptno 
From emp 
Where deptno != (Select deptno from emp where ename = 'KING')

/* List the employees who earn salary greater 
than the average salary in their department.*/
Select empno, ename, sal, deptno 
from emp e 
where sal > (select avg(sal) from emp where deptno = e.deptno)

/* Inserting values into the table */
Insert into emp (empno,ename,deptno) values (7822, 'JACK', 10)

/* Inserting values into another table into current table and specifying the values inserted */
Insert into emp1 (empno,ename,deptno) 
select empno, ename, deptno 
from emp 
where deptno = 10 -- Here it inserts empno, ename, deptno from the emp table but only values where deptno = 10




/* Different ways of updating data */

update emp set comm = 500 -- will update the whole column's data

update emp set sal = sal + (sal * .1) -- updates everyone's salary with a 10% increase

update emp set deptno = 40 where ename = 'KING' -- changes deptno no to 40 of employee whose name is KING


/* DELETING ROWS FROM A TABLE*/
Delete from emp where job = 'CLERK' 

/* Creating a USER */
CREATE USER user_01 IDENTIFIED BY 'DEMO'

/* Altering User's Password */
ALTER USER user_01 IDENTIFIED BY 'ok' --which doesn't work for some reason

SET PASSWORD 'user_01'@'locathost' = newpass;

USE mysql
UPDATE user SET authentication_string = PASSWORD('newpass') WHERE user = 'user01' AND host = '%' ;
FLUSH PRIVILEGES;\
--this seems to be the only solution to this

/* Dropping User */
DROP USER  <username> -- Adding cascade at the end allows you to also delete user data

/* Granting Prividlidges Syntax */
GRANT < System Privileges/roles> -- Insert either CREATE SESSION, CREATE Table or CREATE ANY TABLE int < >
	To <Users/roles/PUBLIC>		-- Self explanatory
	[ WITH ADMIN OPTION]		-- Just remove Square brackets

Revoke <System Privileges>
		FROM	<user/roles/PUBLIC>;

---------------------------------------------
GRANT <all/Object privileges> -- The 5 object priviledges SELECT, UPDATE, DELETE, INSERT, EXECUTE
ON <Object name> 			--Like column name
TO <users/roles/PUBLIC>
[WITH GRANT OPTION]

REVOKE <object Privileges>| ALL [Privileges] ON <object name>
		FROM <users/roles/PUBLIC>
		[ CASCADE CONSTRAINTS]





CREATE TABLE EMPP(EMPNO NUMBER(4) NOT NULL,ENAME VARCHAR2(10),JOB VARCHAR2(9),MGR NUMBER(4),
HIREDATE DATE,SAL NUMBER(7, 2),COMM NUMBER(7, 2),DEPTNO NUMBER(2));

INSERT INTO EMPP VALUES(7369, 'SMITH', 'CLERK', 7902,TO_DATE('17-DEC-1980', 'DD-MON-YYYY'), 800, NULL, 20);
INSERT INTO EMPP VALUES(7499, 'ALLEN', 'SALESMAN', 7698, TO_DATE('20-FEB-1981', 'DD-MON-YYYY'), 1600, 300, 30);
INSERT INTO EMPP VALUES(7521, 'WARD', 'SALESMAN', 7698,TO_DATE('22-FEB-1981', 'DD-MON-YYYY'), 1250, 500, 30);
INSERT INTO EMPP VALUES(7566, 'JONES', 'MANAGER', 7839,TO_DATE('2-APR-1981', 'DD-MON-YYYY'), 2975, NULL, 20);
INSERT INTO EMPP VALUES(7654, 'MARTIN', 'SALESMAN', 7698,TO_DATE('28-SEP-1981', 'DD-MON-YYYY'), 1250, 1400, 30);
INSERT INTO EMPP VALUES(7698, 'BLAKE', 'MANAGER', 7839,TO_DATE('1-MAY-1981', 'DD-MON-YYYY'), 2850, NULL, 30);
INSERT INTO EMPP VALUES(7782, 'CLARK', 'MANAGER', 7839,TO_DATE('9-JUN-1981', 'DD-MON-YYYY'), 2450, NULL, 10);
INSERT INTO EMPP VALUES (7788, 'SCOTT', 'ANALYST', 7566,TO_DATE('09-DEC-1982', 'DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO EMPP VALUES(7839, 'KING', 'PRESIDENT', NULL,TO_DATE('17-NOV-1981', 'DD-MON-YYYY'), 5000, NULL, 10);
INSERT INTO EMPP VALUES(7844, 'TURNER', 'SALESMAN', 7698,TO_DATE('8-SEP-1981', 'DD-MON-YYYY'), 1500, 0, 30);
INSERT INTO EMPP VALUES(7876, 'ADAMS', 'CLERK', 7788,TO_DATE('12-JAN-1983', 'DD-MON-YYYY'), 1100, NULL, 20);
INSERT INTO EMPP VALUES(7900, 'JAMES', 'CLERK', 7698,TO_DATE('3-DEC-1981', 'DD-MON-YYYY'), 950, NULL, 30);
INSERT INTO EMPP VALUES(7902, 'FORD', 'ANALYST', 7566,TO_DATE('3-DEC-1981', 'DD-MON-YYYY'), 3000, NULL, 20);
INSERT INTO EMPP VALUES(7934, 'MILLER', 'CLERK', 7782,TO_DATE('23-JAN-1982', 'DD-MON-YYYY'), 1300, NULL, 10);
 
CREATE TABLE DEPT(DEPTNO NUMBER(2),DNAME VARCHAR2(14),LOC VARCHAR2(13) );
INSERT INTO DEPT VALUES (10, 'ACCOUNTING', 'NEW YORK');
INSERT INTO DEPT VALUES (20, 'RESEARCH', 'DALLAS');
INSERT INTO DEPT VALUES (30, 'SALES', 'CHICAGO');
INSERT INTO DEPT VALUES (40, 'OPERATIONS', 'BOSTON');

CREATE TABLE SALGRADE(GRADE NUMBER,LOSAL NUMBER,HISAL NUMBER);
INSERT INTO SALGRADE VALUES (1, 700, 1200);
INSERT INTO SALGRADE VALUES (2, 1201, 1400);
INSERT INTO SALGRADE VALUES (3, 1401, 2000);
INSERT INTO SALGRADE VALUES (4, 2001, 3000);
INSERT INTO SALGRADE VALUES (5, 3001, 9999);

CREATE TABLE TEST(ENAME VARCHAR2(40),lOC VARCHAR2(20));
INSERT INTO TEST VALUES('SMITH','HYD');
INSERT INTO TEST VALUES('ALLEN','MUMBAI');
INSERT INTO TEST VALUES('JONES','HYD');
INSERT INTO TEST VALUES('WARD','PUNE');

OPERATORS
===============================================================================
select ename,sal,job from empp where (sal>=1500 and sal<=5000) and job='MANAGER'; 
select * from empp where job between 'MANAGER' and 'SALESMAN';

JOINS
===============================================================================
create table student(sid int,sname varchar2(20),cid int);
create table course(cid int,cname varchar2(20),cfee int);
insert all
into student values(1021,'Sai',10)
into student values(1022,'Adams',20)
into student values(1023,'Jones',30)
into course values(10,'Oracle',2500)
into course values(20,'Java',6000)
into course values(40,'PHP',4500)
select * from Dual;

Equi Join
=======
SELECT * FROM STUDENT S,COURSE C WHERE S.CID=C.CID AND C.CID=20;
SELECT * FROM STUDENT S,COURSE C WHERE S.CID=C.CID AND S.CID=20;
SELECT * FROM EMPP E, DEPT D WHERE E. DEPTNO=D.DEPTNO AND D.LOC='CHICAGO';
SELECT * FROM EMPP E, DEPT D WHERE E. DEPTNO=D.DEPTNO AND LOC='CHICAGO';

select fee_student.* from fee_student;

CONSTRAINTS
--==============================================================================

--Alter
--=====
create table TITE(RNo int,SName varchar2(20));
desc TITE;
alter table TITE add column Departments varchar2(20) first;--not supported in oracle.

--PRIMARY KEY
---------------------
create table stu_prime(sid int primary key,sname varchar2(20),sage int);--column level
insert into stu_prime values(10,'Bibhu',20);
insert into stu_prime values(10,'Kamal',20);--error
insert into stu_prime values(null,'Bibhu',20);--error

create table stu_prime2(sid int primary key,sname varchar2(20) primary key,sage int);--error,cause of a table can contain only 1 primary key.

create table stu_prime3(sid int,sname varchar2(20),sage int,primary key(sid,sname));
insert into stu_prime3 values(10,'Bibhu',20);
insert into stu_prime3 values(10,'Bibhu',20);--error
insert into stu_prime3 values(10,'Kamal',20);
insert into stu_prime3 values(null,'Bibhu',20);--error
insert into stu_prime3 values(Null,'Null',20);--error

select * from stu_prime3;

--FOREIGN KEY
--===========
create table parent(sid int primary key,sname varchar(20),sage int);
create table child(cid references parent(sid),cname varchar(20),cage int);
insert into parent values(10,'Bibhu',30);
insert into parent values(20,'Kamal',30);
insert into child values(10,'Bibhu',30);
insert into child values(10,'Kamal',20);
insert into child values(30,'Bibhu',50);--error cause of 30 is not available on parent table
insert into child values(null,'Gopal',14);
insert into child values(20,'Basant',34);
select * from  child;
delete from parent where sid=10;--cannot delete cause of child record depends on it.
update child set cid=30 where cname='Ganesh';--error,coz 30 is not available in parent table 
update child set cid=20 where cname='Ganesh';

drop table parent;--error cause child key depends on it.

drop table child;
drop table parent;

--On Delete Cascade

create table parent2(sid int primary key,sname varchar(20),sage int);
create table child2(cid references parent2(sid)on delete cascade,cname varchar(20),cage int);
insert into parent2 values(10,'Bibhu',30);
insert into parent2 values(20,'Kamal',30);
insert into child2 values(10,'Bibhu',30);
insert into child2 values(10,'Kamal',20);
insert into child2 values(null,'Gopal',14);
insert into child2 values(20,'Basant',34);
select * from parent2;
select * from child2;
delete from parent2 where sid=20;
select * from child2;

--On Delete set null

create table parent3(sid int primary key,sname varchar(20),sage int);
create table child3(cid references parent3(sid)on delete set null,cname varchar(20),cage int);
insert into parent3 values(10,'Bibhu',30);
insert into parent3 values(20,'Kamal',30);
insert into child3 values(10,'Bibhu',30);
insert into child3 values(10,'Kamal',20);
insert into child3 values(null,'Gopal',14);
insert into child3 values(20,'Basant',34);
select * from parent3;
select * from child3;
delete from parent3 where sid=20;
select * from child3;--only 20 sid reference columns will be set null automatically but not all columns

--ADD/DROP CONSTRAINTS ON EXISTING TABLE
--======================================
--Add/drop Unique
--===============
create table stu_uniq4(sid int,sname varchar2(20),sage int);
desc stu_uniq4;
alter table stu_uniq4 add constraint st_uni unique(sid);
alter table stu_uniq4 add unique(sage);
insert into stu_uniq4 values(10,'Bibhu',34);
insert into stu_uniq4 values(10,'Kamal',25);--error

select * from dict;
select * from dictionary;
desc user_objects;
SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME='EMPLOYEES';
select * from user_objects;
desc user_tables;
select * from user_tables;
SELECT * FROM USER_TABLES WHERE TABLE_NAME='EMPLOYEES';
desc user_constraints;
desc user_cons_columns;
select * from user_constraints;
SELECT COLUMN_NAME,CONSTRAINT_NAME FROM USER_CONS_COLUMNS WHERE TABLE_NAME='PARENT4';
SELECT CONSTRAINT_NAME,CONSTRAINT_TYPE FROM USER_CONSTRAINTS WHERE TABLE_NAME='STU_PRIME4';

alter table stu_uniq4 drop constraint st_uni;
select * from stu_uniq4;
insert into stu_uniq4 values(10,'Kamal',35);


--Add/drop Primary Key
--====================
create table stu_prime4(sid int,sname varchar2(20),sage int);
desc stu_prime4;
alter table stu_prime4 add constraint st_pri primary key(sid);
alter table stu_prime4 add primary key(sage);
insert into stu_prime4 values(10,'Bibhu',34);
insert into stu_prime4 values(10,'Kamal',25);--error
insert into stu_prime4 values(null,'Khushi',17);--error

alter table stu_prime4 drop constraint st_pri;
desc stu_prime4;
select * from stu_prime4;
insert into stu_prime4 values(10,'Bibhu',34);
insert into stu_prime4 values(null,'Bibhu',34);


--Add/drop Check
--==============
create table stu_chk4(sid int,sname varchar2(20),sage int);
desc stu_chk4;
alter table stu_chk4 add constraint st_chk check(sage>10);
insert into stu_chk4 values(10,'Bibhu',34);
insert into stu_chk4 values(14,'Kamal',10);--error
insert into stu_chk4 values(33,'Khushi',null);--error
select * from stu_chk4;

alter table stu_chk4 drop constraint st_chk;
insert into stu_chk4 values(23,'Animesh',7);
select * from stu_chk4;

--Add/drop Not Null
--=================
create table stu_nn3(sid int,sname varchar2(20),sage int);
desc stu_nn3;
alter table stu_nn3 modify sid int not null;--in this case system generates a default constraint name internally.
alter table stu_nn3 modify sname constraint st_n not null;
insert into stu_nn values(10,'Bibhu',23);
insert into stu_nn values(null,'Bibhu',23);--error
insert into stu_nn values(null,'null',20);--error

alter table stu_nn3 drop constraint st_n;
desc stu_nn3;

select * from user_constraints;
alter table stu_nn3 drop constraint SYS_C007491 ;
desc stu_nn3;--by default system generated a default constraint name internally.


--Add/drop Foreign Key
--====================
create table parent4(sid int,sname varchar(20),sage int);
alter table parent4 add constraint pk primary key(sid);
create table child4(cid int,cname varchar(20),cage int);

alter table child4 add constraint ch_fk foreign key(cid) references parent4(sid) on delete cascade; 

insert into parent4 values(10,'Bibhu',30);
insert into parent4 values(20,'Kamal',30);
insert into child4 values(10,'Bibhu',30);
insert into child4 values(10,'Kamal',20);
insert into child4 values(30,'Bibhu',50);--error cause of 30 is not available on parent table
insert into child4 values(null,'Gopal',14);
insert into child4 values(20,'Basant',34);
select * from  child4;
delete from parent4 where sid=10;
select * from parent4;
select * from child4;
update child4 set cid=30 where cname='Gopal';--error cause of parent key not found. 
update child4 set cid=20 where cname='Gopal';
select * from child4;

alter table parent4 drop constraint pk;--error cause of child table depends on it.

alter table child4 drop constraint ck_fk;--error

alter table parent4 drop constraint pk cascade;--parent key along foreign key is deleted successfully.

--RENAME A CONSTRAINT
--===================
select * from user_constraints;
alter table stu_nn2 rename constraint SYS_C007463 to abc_def;

create table abc(aid int,aname varchar2(20));
alter table abc add constraint c_nm primary key(aid);

alter table abc rename constraint c_nm to c_nm2;
alter table abc drop constraint c_nm;--error cannot find the constraint name;
alter table abc drop constraint c_nm2;
--Same constraint name we cannot use that are alredy exists in database before.

--ENABLE/DISABLE CONSTRAINTS
--==========================
create table chk_ed(cid int,cname varchar2(20),csal decimal(10,2));
alter table chk_ed add constraint bibhu check(csal>5000);
insert into chk_ed values(10,'bibhu',6000);
insert into chk_ed values(14,'ayush',4000);--error

alter table chk_ed disable constraint bibhu;

insert into chk_ed values(11,'Kamal',2000);
select * from chk_ed;

alter table chk_ed enable constraint bibhu;--error case of the table contains the data that does not satisfy check condition
alter table chk_ed enable novalidate constraint bibhu;
insert into chk_ed values(23,'Raj',3000);--error
insert into chk_ed values(20,'Raj',7000);
delete from chk_ed where cid=11;

alter table chk_ed disable constraint bibhu;
alter table chk_ed enable constraint bibhu;--no error cause of the table contains all data satisfy check condition

--Enable/disable primary key
--==========================
create table prime_ed(pid int,pname varchar2(20),psal decimal(10,2));
alter table prime_ed add constraint primee primary key(pid);
insert into prime_ed values(10,'bibhu',6000);
insert into prime_ed values(10,'ayush',4000);--error
insert into prime_ed values(null,'ayush',4000);--error

alter table prime_ed disable constraint primee;

insert into prime_ed values(null,'Kamal',2000);
select * from prime_ed;

alter table prime_ed enable constraint primee;--error case of the table contains the data that does not satisfy check condition
alter table prime_ed enable novalidate constraint primee;
insert into prime_ed values(null,'Kamal',2000);--error
insert into prime_ed values(87,'Kamal',2000);
select * from prime_ed;
delete from prime_ed where pname='Kamal';

alter table prime_ed disable constraint primee;
alter table prime_ed enable constraint primee;--no error cause of the table contains all data satisfy check condition

--DEFAULT KEY
--===========
create table def(did int,dname varchar2(20),dsal number(10,2) default 5000);
insert into def values(10,'Bibhu',4000);
insert into def values(14,'Kabita',null);--default does not work here.
select * from def;
insert into def(did,dname) values(34,'Kamal');

create table def2(did int,dname varchar2(20),dsal number(10,2));
insert into def2 values(10,'Bibhu',4000);
insert into def2(did,dname) values(34,'Kamal');
select * from def2;
alter table def2 modify dsal default 500;
insert into def2(did,dname) values(30,'Khushii');
select * from def2;

alter table def2 modify dsal default null;
insert into def2(did,dname) values(23,'Raghu');
select * from def2;

desc user_tab_columns;
select * from user_tab_columns;
SELECT COLUMN_NAME,DATA_DEFAULT FROM USER_TAB_COLUMNS WHERE TABLE_NAME='DEF2';

TCL(TRANSACTIONAL CONTROL STATEMENT)
--==============================================================================
set autocommit off;
set autocommit 1;--works in mysql as well as oracle.
commit;
rollback;--we cannot rollback to a DDL statement.
savepoint s1;
rollback to s1;
--after creating savepoint if we create more than one sql statements then those all statements will be the under of savepoint.
--we cannot rollback a savepoint that is committed/ddl statements.

SUBQUERY
--==============================================================================

--SINGLE ROW SUBQUERY 
--====================
select * from empp;
--To display the senior most employee details.
select * from empp where hiredate=(select min(hiredate) from empp);
--To display who are getting the first high salary.
select * from empp where sal=(select max(sal) from empp);
--To display list of employee whose salary is more than the maximum salary of the job is SALESMAN.
select * from empp where sal>(select max(sal) from empp where job='SALESMAN');
--To display employee whose employee job is same as the job of the employee BLAKE.
select * from empp where job=(select job from empp where ename='BLAKE');
--To display employee whose employee job is same as the job of the employee BLAKE and who are earning salary more than BLAKEs salary.
select * from empp where job=(select job from empp where ename='BLAKE') and sal>(select sal from empp where ename='BLAKE');
--Display the employee details who are getting 2nd highest salary.
select * from empp where sal=(select max(sal) from empp where sal<(select max(sal) from empp));
--Display the employee details who are getting 3rd highest salary.
select * from empp where sal=(select max(sal) from empp where sal<(select max(sal) from empp where sal<(select max(sal) from empp)));
--To display no of employee of department numbers in which deptno no of employee is less than the no of employee of deptno is 20.
select deptno,count(*) from empp group by deptno having count(*)<(select count(*) from empp where deptno=20);
--sum of salary of jobs.if sum of salary of jobs are more than sum of salary of the job is CLERK.
select job,sum(sal) from empp group by job having sum(sal)>(select sum(sal) from empp where job='CLERK'); 

--Subquery with Update
--====================
--To update with employee salary with max salary of emp table whose empno is 7900.
update empp set sal=(select max(sal) from empp)where empno=7900;
select * from empp;

--Subquery with Delete
--====================
--To delete Employee details from emp table whose job is same as the job of SCOTT.
delete from empp where job=(select job from empp where ename='SCOTT');
select * from empp;

--MULTIPLE ROW SUBQUERY
--======================
--To display employee details whose employee job is same as the job of the employee SMITH,CLARK.
select * from empp where job =(select job from empp where ename in('SMITH','CLARK'));--error cause of subquery returns more than one value.
select * from empp where job in(select job from empp where ename in('SMITH','CLARK'));
select * from empp where job in(select job from empp where ename='SMITH' or ename='CLARK');
--Display employee details who are getting min,max salaries.
select * from empp where sal in(select max(sal) from empp union select min(sal)from empp);
--To display the senior most employees from each deptno wise.
select * from empp where hiredate in(select min(hiredate) from empp group by deptno);
--To display employees whose salary is more than any SALESMAN salary.
select * from empp where sal>any(select sal from empp where job='SALESMAN');
--To display employees whose salary is more than all SALESMAN salary.
select * from empp where sal>all(select sal from empp where job='SALESMAN');
--To display employees who are earning highest salary from each job wise by using multiple row subquery.
select * from empp where sal in(select max(sal) from empp group by job);

--Multiple Row Sub Query
--==================
--Display employee whose job,mgr are same as the job,mgr of the employee SCOTT.
select * from empp where (job,mgr)in(select job,mgr from empp where ename='SCOTT');

select * from empp where(job,sal) in(select job,max(sal) from empp group by job);
--INLINE VIEW
--===========

--PSEUDO COLUMNS(Does not supported in MySQL)
------------------------------------------------------------------------

--Rowid
--=====
select rowid,ename from empp;
select rowid,ename from empp where ename='SMITH';--rowid are permanent id.

create table test(sno int,sname varchar2(10));
insert into test values(10,'A');
insert into test values(10,'A');
insert into test values(10,'A');
insert into test values(20,'B');
insert into test values(20,'B');
insert into test values(30,'C');
insert into test values(30,'C');
insert into test values(30,'C');
insert into test values(30,'C');
select * from test;
select rowid,sname from test;--pseudo columns are not supported in MySQL.
select max(rowid),sname from test;--error
select max(rowid),sname from test group by sname;
select min(rowid),sname from test group by sname;
delete from test where rowid not in(select max(rowid) from test group by sno);
select * from test;

--Rownum
--======
select * from empp;
select rownum,ename from empp;
--Fetch 1st row in table
select * from emp where rownum=1;
select * from empp limit 1;--for MySQL
--Fetch 2nd row
select * from empp where rownum 2;--error
select * from empp where rownum<=2 minus select * from empp where rownum=1;
select * from empp limit 1,1;--for MySQL.
--Fetch Last row
select * from empp where rownum<=14 minus select * from empp where rownum<=13;
select * from empp order by empno desc limit 1;
--Fetch first 5 rows
select * from empp where rownum<=5;
--Fetch 5th no of row
select * from empp where rownum<=5 minus select * from empp where rownum<=4;
select * from empp limit 5;--for MySQL
--Fetch 3rd no row to 9th no row
select * from empp where rownum<=9 minus select * from empp where rownum<3;
--Fetch last 2 rows
select * from empp where rownum<=14 minus select * from empp where rownum<=12;
select * from empp minus select * from empp where rownum<=(select count(*)-2 from empp);

--INLINE VIEW
--===========

--Using column alias names in where clause condition
----------------------------------------------------

--display employee whose employee annual salary is more than 10000.
select ename,sal,sal*12 Annu_Sal from empp;
select ename,sal,sal*12 Annu_Sal from empp where Annu_sal>10000;--error we cannot use column alias name in where clause condition.
select * from(select ename,sal,sal*12 Annu_sal from empp) where Annu_sal>10000;

--Using order by clause in subquery
-------------------------------------------------
--display five highest salaries of employee by using rownum and inline view
select * from empp where rownum<=5 order by sal desc;--error
select * from (select * from empp order by sal desc) where rownum<=5;
--display 5th highest salary of employee by using rownum and inline view
select * from(select * from empp order by sal desc)where rownum<=5
minus 
select * from(select * from empp order by sal desc)where rownum<=4;

--Using Rownum Alias Name
---------------------------------------

--display 3rd position row from emp table by using rownum alias name along with inline view.
select * from empp;
select * from(select rownum r,ename,sal from empp) where r=3;
select * from(select rownum r,empp.* from empp) where r=3;
--display 1st,3rd,5th,7th,9th rows from empp table by using rownum alias name along with inline view.
select * from(select rownum r,empp.* from empp)where r in(1,3,5,9);
--display even position rows from empp table by using rownum alias name along with inline view.
select * from(select rownum r,empp.* from empp) where mod(r,2)=0;
--display 1st row and last row from empp table by using rownum alias name along with inline view.
select * from (select rownum r,empp.* from empp)where r=1
or
r=(select count(*) from empp);

--ANALYTICAL FUNCTIONS
--====================

--Without Partition By
--====================
select * from empp;
select ename,sal,row_number()over(order by sal desc) Ranks from empp;
select ename,sal,rank()over(order by sal desc) Ranks from empp;
select ename,sal,dense_rank()over(order by sal desc) Ranks from empp;

--With Partition By
--=================
select ename,sal,deptno,rank()over(partition by deptno order by sal desc) Ranks from empp;
select ename,sal,deptno,dense_rank()over(partition by deptno order by sal desc) Ranks from empp;
--display 3rd higest salary employee details from emp table in deptno wise by using dense_rank() along with inline view.
select * from(select ename,sal,deptno,dense_rank()over(partition by deptno order by sal desc) R from empp)where R=3;
--display the 4th senior most employee from each job wise 
select * from(select ename,sal,job,hiredate,dense_rank() over(partition by job order by hiredate asc) R from empp) where R=4;

--CORELATED SUBQUERY
--==================

--Find 1st highest highest salary
select * from empp;
select * from empp e1 where 0=(select count(distinct sal) from empp e2 where e2.sal>e1.sal);
select * from empp where sal=(select max(sal) from empp);
select * from(select * from empp order by sal desc ) where rownum=1;
--Find 3rd highest highest salary
select * from empp;
select * from empp e1 where 2=(select count(distinct sal) from empp e2 where e2.sal>e1.sal);
select * from empp where sal=(select max(sal) from empp where sal<(select max(sal) from empp where sal<(select max(sal) from empp)));
select * from(select * from empp order by sal desc ) where rownum<=3
minus 
select * from(select * from empp order by sal desc ) where rownum<=2;
--Find lowest salary 
select * from empp e1 where 0=(select count(distinct sal) from empp e2 where e2.sal<e1.sal);
--Find 3rd lowest salary 
select * from empp e1 where 2=(select count(distinct sal) from empp e2 where e2.sal<e1.sal);
--Find top 3rd highest salaries
select * from empp e1 where 3>(select count(distinct sal) from empp e2 where e2.sal>e1.sal);
--Find top 3rd lowest salaries
select * from empp e1 where 3>(select count(distinct sal) from empp e2 where e2.sal<e1.sal);

--Similarly in mysql we can find the nth highest/lowest salaries.

--Exists
--======

--Display the department details in which department employee are working.
select * from dept;
select * from dept d where exists(select deptno from empp e where e.deptno=d.deptno);
select * from dept where not exists(select deptno from empp where empp.deptno=dept.deptno);

--SCALAR SUBQUERY
--===============
select (select count(*) from empp)as EmppTotal,(select count(*) from dept)as DeptTotal from dual;--After select space is mandatory otherwise will show error.
select (select sum(sal) from empp where deptno=10) as "10",(select sum(sal) from empp where deptno=20) as "20",
(select sum(sal) from empp where deptno=20)as "30" from dual;


DATABASE SECURITY
--==============================================================================

--TCL
--===
/*SQL> create user c##def identified by defpwd;
User created.

SQL> conn
Enter user-name: c##def/defpwd
ERROR:
ORA-01045: user C##DEF lacks CREATE SESSION privilege; logon denied
Warning: You are no longer connected to ORACLE.

SQL> grant connect to c##def;
SP2-0640: Not connected

SQL> conn
Enter user-name: c##def/defpwd
ERROR:
ORA-01045: user C##DEF lacks CREATE SESSION privilege; logon denied

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> create user jilu identified by jilu;
create user jilu identified by jilu
*ERROR at line 1:

SQL> grant connect to c##def;
Grant succeeded.

SQL> conn
Enter user-name: c##def/defpwd
Connected.

SQL> create table tite(deptid int,deptname varchar2(20));
create table tite(deptid int,deptname varchar2(20))
*
ERROR at line 1:
ORA-01031: insufficient privileges

SQL> grant create table to c##def;
grant create table to c##def
*
ERROR at line 1:
ORA-01031: insufficient privileges

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> grant create table to c##def;
Grant succeeded.

SQL> conn
Enter user-name: c##def/defpwd
Connected.

SQL> create table tite(deptid int,deptname varchar2(20));
Table created.

SQL> insert into tite values(10,'CSE');
insert into tite values(10,'CSE')
            *
ERROR at line 1:
ORA-01950: no privileges on tablespace 'USERS'

QL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> grant unlimited tablespace to c##def;
Grant succeeded.

SQL> conn
Enter user-name: c##def/defpwd
Connected.

SQL> insert into tite values(101,'CSE');
1 row created.

SQL> commit;
Commit complete.

SQL> select * from tite;

    DEPTID DEPTNAME
---------- --------------------
       101 CSE

SQL> update tite set deptid=100 where deptname='CSE';
1 row updated.

SQL> commit;
Commit complete.

SQL> select * from tite;

    DEPTID DEPTNAME
---------- --------------------
       100 CSE
       
SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> grant dba to c##def; after that we will become the owner of this user.
Grant succeeded.

Changing password
=================
Process 1
-------------

SQL> conn
Enter user-name: c##def/defpwd
Connected.

SQL> Alter user c##def identified by defpwd2;
User altered.

SQL> conn
Enter user-name: c##def/defpwd
ERROR:
ORA-01017: invalid username/password; logon denied
Warning: You are no longer connected to ORACLE.

SQL> conn
Enter user-name: c##def/defpwd2
Connected.

Process 2
-------------
SQL> password
Changing password for C##DEF
Old password:defpwd2
New password:defpwd
Retype new password:defpwd
Password changed

SQL> conn
Enter user-name: c##def/defpwd
Connected.

PRIVILEGES
==========
once we granting DBA to an user thatg means we will privide all the privileges.
we cannot drop an currently login user.

System Privilege
----------------------
SQL> create user c##mno identified by mnopwd;
User created.

SQL> grant connect to c##mno;
Grant succeeded.

SQL> conn
Enter user-name: c##mno/mnopwd
Connected.

SQL> select * from session_privs;
PRIVILEGE
----------------------------------------
CREATE SESSION
SET CONTAINER

SQL> create table tite(deptid int,deptno varchar2(20));
create table tite(deptid int,deptno varchar2(20))
*
ERROR at line 1:
ORA-01031: insufficient privileges

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> grant create table to c##mno;
Grant succeeded.

SQL> conn
Enter user-name: c##mno/mnopwd
Connected.

SQL> create table tite(deptid int,deptno varchar2(20));
Table created.

SQL> select * from session_privs;
PRIVILEGE
---------------
CREATE SESSION
CREATE TABLE
SET CONTAINER

SQL> insert into tite values(101,'CSE');
insert into tite values(101,'CSE')
*ERROR at line 1:
ORA-01950: no privileges on tablespace 'USERS'

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> grant unlimited tablespace to c##mno;
Grant succeeded.

SQL> conn
Enter user-name: c##mno/mnopwd
Connected.
SQL> insert into tite values(100,'CSE');
1 row created.

SQL> select * from session_privs;

PRIVILEGE
--------------------
CREATE SESSION
UNLIMITED TABLESPACE
CREATE TABLE
SET CONTAINER

SQL> create view v1 as select * from tite;
create view v1 as select * from tite
            *
ERROR at line 1:
ORA-01031: insufficient privileges

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> grant create view to c##mno;
Grant succeeded.

SQL> conn
Enter user-name: c##mno/mnopwd
Connected.
SQL> create view v1 as select * from session_privs;
View created.

SQL> select * from tab;

TNAME   TABTYPE  CLUSTERID
-----   -------  ---------
TITE     TABLE     (null)
V1       VIEW      (null)

SQL> select * from session_privs;

PRIVILEGE
--------------------
CREATE SESSION
UNLIMITED TABLESPACE
CREATE TABLE
CREATE VIEW
SET CONTAINER

SQL> create synonym s1 for tite;
create synonym s1 for tite
*
ERROR at line 1:
ORA-01031: insufficient privileges

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> grant create synonym to c##mno;
Grant succeeded.

SQL> conn
Enter user-name: c##mno/mnopwd
Connected.

SQL> select * from session_privs;

PRIVILEGE
--------------------
CREATE SESSION
UNLIMITED TABLESPACE
CREATE TABLE
CREATE SYNONYM
CREATE VIEW
SET CONTAINER

6 rows selected.

SQL> create synonym s1 for tite;
Synonym created.

SQL> select * from tab;

TNAME  TABTYPE  CLUSTERID
-----  -------  ---------
TITE    TABLE    (null)
V1      VIEW     (null)
S1      SYNONYM  (null)

Object Privileges
-----------------------

SQL> conn
Enter user-name: c##abc
Enter password:
Connected.

SQL> select * from c##mno.tite;

DEPTID DEPTNO
----------  ------------
100          CSE

SQL> select * from tite;
no rows selected

SQL> insert into c##mno.tite values(101,'EEE');
1 row created.

SQL> select * from c##mno.tite;

DEPTID  DEPTNO
------  ------
100     CSE
101     EEE

SQL> delete from c##mno.tite where deptid=100;
1 row deleted.

SQL> select * from c##mno.tite;

DEPTID DEPTNO
------ ------
101    EEE

SQL> conn
Enter user-name: c##mno/mnopwd
Connected.

SQL> select * from tite;

DEPTID DEPTNO
------ ------
101    EEE

SQL> grant all on tite to c##def;
Grant succeeded.

Admin to User
-------------------
SQL> conn
Enter user-name: c##mno/mnopwd
Connected.

SQL> set lines 500
SQL> desc user_tab_privs_recd;
 Name
                 Null?    Type
-------------    -----    ----
OWNER                    VARCHAR2(128)
TABLE_NAME               VARCHAR2(128)
GRANTOR                  VARCHAR2(128)
PRIVILEGE                VARCHAR2(40)
GRANTABLE                VARCHAR2(3)
HIERARCHY                VARCHAR2(3)
COMMON                   VARCHAR2(3)
TYPE                     VARCHAR2(24)
INHERITED                VARCHAR2(3)

SQL> select grantor,privilege,table_name from user_tab_privs_recd;
no rows selected

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> grant all on tite to c##mno;
Grant succeeded.

SQL> conn
Enter user-name: c##mno/mnopwd
Connected.
SQL> select grantor,privilege,table_name from user_tab_privs_recd;

GRANTOR    PRIVILEGE         TABLE_NAME
-------            ----------------         -------------------
C##ABC     ALTER                       TITE
C##ABC     DELETE                     TITE
C##ABC     INDEX                        TITE
C##ABC     INSERT                      TITE
C##ABC     SELECT                      TITE
C##ABC     UPDATE                     TITE
C##ABC     REFERENCES            TITE
C##ABC     READ                         TITE
C##ABC     ON COMMIT REFRESH TITE
C##ABC     QUERY REWRITE      TITE
C##ABC     DEBUG                       TITE
C##ABC     FLASHBACK              TITE
12 rows selected.

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> select grantor,privilege,table_name,grantee from user_tab_privs_made;

GRANTOR     GRANTEE     PRIVILEGE         TABLE_NAME
-------             --------------     ----------------         -------------------
C##ABC      C##MNO      ALTER             TITE                                                                                                                      
C##ABC      C##MNO      DELETE            TITE    
C##ABC      C##MNO      INDEX             TITE
C##ABC      C##MNO      UPDATE            TITE
C##ABC      C##MNO      REFERENCES        TITE  
C##ABC      C##MNO      READ              TITE
C##ABC      C##MNO      ON COMMIT REFRESH TITE
C##ABC      C##MNO      QUERY REWRITE     TITE
C##ABC      C##MNO      FLASHBACK         TITE
C##ABC      PUBLIC      INHERIT PRIVILEGES C##ABC

12 rows selected.

SQL> revoke all on tite from c##mno;
Revoke succeeded.

SQL>  select grantor,privilege,table_name,grantee from user_tab_privs_made;

GRANTOR      PRIVILEGE     TABLE_NAME        GRANTEE
-------      ---------     ----------        -------
C##ABC        PUBLIC      INHERIT PRIVILEGES C##ABC                                                                                        INHERIT PRIVILEGES                     PUBLIC

SQL> select grantor,privilege,table_name,grantee from user_tab_privs_made;                                                                PUBLIC

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> desc user_tab_privs_made;
 
Name         nULL?      Type      GRANTEE
                                                                        
TABLE_NAME           VARCHAR2(128)
GRANTOR              VARCHAR2(128)
PRIVILEGE            VARCHAR2(40)
GRANTABLE            VARCHAR2(3)
HIERARCHY            VARCHAR2(3)
COMMON               VARCHAR2(3)
TYPE                 VARCHAR2(24)
INHERITED            VARCHAR2(3)

--------------------------------------------------------------------------------

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> create user c##kabita identified by kabita;
User created.

SQL> create user c##bibhu identified by bibhu;
User created.

SQL> grant connect to c##kabita;
Grant succeeded.

SQL> grant connect to c##bibhu;
Grant succeeded.

SQL> conn
Enter user-name: c##kabita/kabita
Connected.

SQL> select * from session_privs;

   PRIVILEGE
---------------
CREATE SESSION
SET CONTAINER

SQL> select * from c##abc.tite;
select * from c##abc.tite
                     *
ERROR at line 1:
ORA-00942: table or view does not exist

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> grant select on tite to c##kabita;
Grant succeeded.

SQL> conn
Enter user-name: c##kabita/kabita
Connected.

SQL> select * from c##abc.tite;
no rows selected

SQL> conn
Enter user-name: c##bibhu/bibhu
Connected.

SQL> select * from c##abc.tite;
select * from c##abc.tite
                     *
ERROR at line 1:
ORA-00942: table or view does not exist


SQL> conn
Enter user-name: c##kabita/kabita
Connected.
SQL> grant select on c##abc.tite to c##bibhu;
grant select on c##abc.tite to c##bibhu
                       *
ERROR at line 1:
ORA-01031: insufficient privileges

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> revoke seelct on tite from c##kabita;
Revoke Succeed

SQL> grant select on tite to c##kabita with grant option;
Grant succeeded.

SQL> conn
Enter user-name: c##kabita/kabita
Connected.

SQL> grant select on c##abc.tite to c##bibhu;
Grant succeeded.

SQL> conn
Enter user-name: c##bibhu/bibhu
Connected.

SQL> select tite from c##abc.tite;
select tite from c##abc.tite
       *
ERROR at line 1:
ORA-00904: "TITE": invalid identifier


SQL> select * from c##abc.tite;
no rows selected

Role
====
SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> create role R1;
create role R1
            *
ERROR at line 1:
ORA-65096: invalid common user or role name

SQL> create role c##R1;
Role created.

SQL> grant create view,create synonym to c##R1;
Grant succeeded.

SQL> grant c##R1 to c##kabita,c##bibhu;
Grant succeeded.

SQL> conn
Enter user-name: c##kabita/kabita
Connected.

SQL> select * from session_privs;

   PRIVILEGE
---------------
CREATE SESSION
CREATE SYNONYM
CREATE VIEW
SET CONTAINER

SQL> conn
Enter user-name: c##bibhu/bibhu
Connected.

SQL> select * from session_privs;

  PRIVILEGE
--------------
CREATE SESSION
CREATE SYNONYM
CREATE VIEW
SET CONTAINER

To view system privilege related to role
==============================
SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> desc role_sys_privs;
 Name           Null?   Type
 --------           ------    -------
 ROLE                   VARCHAR2(128)
 PRIVILEGE              VARCHAR2(40)
 ADMIN_OPTION           VARCHAR2(3)
 COMMON                 VARCHAR2(3)
 INHERITED              VARCHAR2(3)

SQL> select role,privilege from role_sys_privs where role='c##R1';
no rows selected

SQL> conn
Enter user-name: c##kabita/kabita
Connected.

SQL> select role,privilege from role_sys_privs where role='c##R1';
no rows selected

To view object privilege related to role
========================================

SQL> desc role_tab_privs;

 Name             Null?    Type
------            -----    ----
 ROLE                      VARCHAR2(128)
 OWNER                     VARCHAR2(128)                                                                                                                                   
 TABLE_NAME                VARCHAR2(128)                                                                                                                                       
 COLUMN_NAME               VARCHAR2(128)
 PRIVILEGE                 VARCHAR2(40)
 GRANTABLE                 VARCHAR2(3)                                                                                                                                                      
 COMMON                    VARCHAR2(3)
 INHERITED                 VARCHAR2(3)                                                                                                                                     
 
SQL> select role,privilege,table_name from role_TAB_privs where role='c##R1';
no rows selected

TO VIEW ROLES GRANTED TO AN USER
================================
SQL> conn
Enter user-name: c##kabita/kabita
Connected.

SQL> desc user_role_privs;
 Name              Null?    Type
 ----              -----    ----
 USERNAME                   VARCHAR2(128)
 GRANTED_ROLE               VARCHAR2(128)
 ADMIN_OPTION               VARCHAR2(3)
 DELEGATE_OPTION            VARCHAR2(3)
 DEFAULT_ROLE               VARCHAR2(3)
 OS_GRANTED                 VARCHAR2(3)
 COMMON                     VARCHAR2(3)
 INHERITED                  VARCHAR2(3)
 
SQL> select username,granted_role from user_role_privs ;
USERNAME           GRANTED_ROLE
--------           ------------
C##KABITA           C##R1
C##KABITA           CONNECT

Drop a Role
===========
SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> drop role c##R1;
Role dropped.                                                                                                                                                           
                                                                                                                                                            
*/

Synonyms
================================================================================
/*
Private Synonym
----------------

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> create user c##synonym identified by synonym;
User created.

SQL> grant connect to c##synonym;
Grant succeeded.

SQL> grant unlimited tablespace,create table to c##synonym;
Grant succeeded.

SQL> conn
Enter user-name: c##synonym/synonym
Connected.

SQL> create table College_Details(cid int,cname varchar2(20),noOfStudents int);
Table created.

SQL>  insert into College_Details values(1901,'TITE',2000);
1 row created.

SQL> create synonym s1 for College_details;
create synonym s1 for College_details
*
ERROR at line 1:
ORA-01031: insufficient privileges

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> grant create synonym to c##synonym;
Grant succeeded.

SQL> conn
Enter user-name: c##synonym/synonym
Connected.

SQL> select * from session_privs;

PRIVILEGE
----------------------------------------
CREATE SESSION
UNLIMITED TABLESPACE
CREATE TABLE
CREATE SYNONYM
SET CONTAINER

SQL> create synonym s1 for College_details;
Synonym created.

SQL> select * from s1;

 CID  CNAME   NOOFSTUDENTS
----- -----   ------------
 1901 TITE     2000

SQL> insert into s1 values(1902,'RITE',2400);
1 row created.

SQL> select * from s1;

 CID  CNAME   NOOFSTUDENTS
----- -----   ------------
 1901 TITE     2000
 1902 RITE     2400

SQL> update s1 set noofstudents=2100 where cid=1901;
1 row updated.

SQL> select * from s1;

 CID  CNAME   NOOFSTUDENTS
----- -----   ------------
 1901 TITE     2100
 1902 RITE     2400

SQL> delete from s1 where cid=1901;
1 row deleted.

SQL> select * from s1;

 CID  CNAME   NOOFSTUDENTS
----- -----   ------------
1902  RITE     2400

--Public Synonym
================
SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> create public synonym ps1 for c##synonym.College_Details;
Synonym created.

SQL> select * from ps1;

CID   CNAME    NOOFSTUDENTS
---   -----    ------------
1902  RITE      2400

SQL> conn
Enter user-name: c##mno/mnopwd
Connected.

SQL> select * from ps1;
select * from ps1
              *
ERROR at line 1:
ORA-00942: table or view does not exist

SQL> conn
Enter user-name: c##synonym/synonym
Connected.

SQL> select * from ps1;

CID   CNAME    NOOFSTUDENTS
---   -----    ------------
1902  RITE      2400

SQL> conn
Enter user-name: c##kabita/kabita
Connected.

SQL> select * from ps1;
select * from ps1
              *
ERROR at line 1:
ORA-00942: table or view does not exist

--To show private synonyms
----------------------------------------

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> desc user_synonyms;
 Name                    Null?       Type
 ----                    -----        ----
 SYNONYM_NAME            NOT NULL    VARCHAR2(128)
 TABLE_OWNER                          VARCHAR2(128)
 TABLE_NAME              NOT NULL    VARCHAR2(128)
 DB_LINK                              VARCHAR2(128)
 ORIGIN_CON_ID                        NUMBER

SQL> select synonym_name,table_name from user_synonyms;
no rows selected

SQL> conn
Enter user-name: c##synonym/synonym
Connected.

SQL> desc user_synonyms;
  Name                    Null?       Type
 ----                    -----        ----
 SYNONYM_NAME            NOT NULL    VARCHAR2(128)
 TABLE_OWNER                          VARCHAR2(128)
 TABLE_NAME              NOT NULL    VARCHAR2(128)
 DB_LINK                              VARCHAR2(128)
 ORIGIN_CON_ID                        NUMBER

SQL> select synonym_name,table_name from user_synonyms;

SYNONYM_NAME       TABLE_NAME
------------       ----------
S1                 COLLEGE_DETAILS

--To show public synonyms
-------------------------
SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> desc all_synonyms;
 Name                    Null?       Type
 ----                    -----        ----
 OWNER                               VARCHAR2(128)
 SYNONYM_NAME                         VARCHAR2(128)
 TABLE_OWNER                          VARCHAR2(128)
 TABLE_NAME                           VARCHAR2(128)
 DB_LINK                              VARCHAR2(128)
 ORIGIN_CON_ID                        NUMBER

SQL> select synonym_name,table_name from all_synonyms where table_name='Colllege_Details';
no rows selected

SQL> conn
Enter user-name: c##synonym/synonym
Connected.

SQL> select synonym_name,table_name from all_synonyms where table_name='College_Details';
no rows selected

--Drop a Synonym
================

SQL> drop synonym s1;
Synonym dropped.

SQL> select synonym_name,table_name from user_synonyms;
no rows selected

SQL> drop public synonym ps1;
drop public synonym ps1
                    *
ERROR at line 1:
ORA-01031: insufficient privileges


SQL> select * from ps1;
 CID  CNAME    NOOFSTUDENTS
----- -----    ------------
 1902 RITE      2400

SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> drop public synonym ps1;
Synonym dropped.

SQL>  select synonym_name,table_name from all_synonyms where table_name='College_Details';
no rows selected*/

--Synonyms are not supported in MySQL.

VIEW IN ORACLE
================================================================================

--SIMPLE VIEW
=============

select * from empp;
CREATE TABLE EMPP2(EMPNO NUMBER(4) NOT NULL,ENAME VARCHAR2(10),JOB VARCHAR2(9),MGR NUMBER(4),
HIREDATE DATE,SAL NUMBER(7, 2),COMM NUMBER(7, 2),DEPTNO NUMBER(2));
insert into empp2 select * from empp;
select * from empp2;

--Create a view to access complete data from a table.
create view v1 as select * from empp2;
select * from v1;
insert into v1 values(7890,'RAJ','ANALYST',7777,'12-AUG-83',9999,200,40);--base table will store these values but not view will store.
select * from empp2;
select * from v1;
update v1 set ename='KALMAL' where empno=7890;
delete from v1 where empno=7369;
insert into v1 values(null,'RAHUL','ANALYST',7788,'10-APR-81',9990,600,30);--error coz empno is not null.

--Create a view to access partial data from a table.
create view v2 as select empno,ename,sal from empp2;
select * from v2;
insert into v2 values(1234,'Jilu',9091);
insert into v2 values(4567,'Jilu','CLERK',9091);--error 
update v2 set empno=7000 where ename='RAHUL';
select * from v2;
delete from v2 where empno=7890;
insert into v2 values(null,'Bibhu',8888);--error

--Create a view to display employee whose salary is 3000.
create view v3 as select empno,ename,sal from empp2 where sal=3000;
select * from v3;
insert into v3 values(1222,'BIKASH',2820);
select * from empp2;

--With read only
================
create view v4 as select empno,ename,sal from empp2 with read only;
select * from v4;
insert into v4 values(2345,'Khushi',9000);--error cause it does not support DML operations.
delete from v4 where empno=1222;--error
update v4 set empno=1111 where ename='BIKASH';--error

--With Check Option
===================
create view v5 as select empno,ename,sal from empp2 where sal=6000 with check option;
select * from v5;
insert into v5 values(2222,'Kabita',8000);--error cause of only sal of 6000 that we can insert.
insert into v5 values(2222,'Kabita',6000);
select * from v5;
update v5 set sal=8000 where empno=2222;--error
delete from v5 where empno=2222;--Does not create any error.

--COMPLEX VIEW
==============
select * from tab;
desc student;
desc student77;
select * from student7;
select * from student77;
insert into student7 values(16,'Kabita','F');

create view v10 as select * from student7 union select * from student77;
select * from v10;
insert into v10 values (17,'Khushi','F');--error
update v10 set sex='M' where sid=16;-error
delete from v10 where sid=16;--error

create view v11 as select deptno,sum(sal) from empp group by deptno;-error coz we must have to alias name for aggregate function.
create view v11 as select deptno,sum(sal) TotalSal from empp group by deptno;
select * from v11;

select * from empp;
select * from dept;
create view v12 as select e.empno,e.ename,e.job,e.sal,d.dname,d.loc from empp e inner join dept d on e.deptno=d.deptno;
select * from v12;
update v12 set sal=9000 where empno=7934;--error
delete from v12 where empno=7934;--error
insert into v12 values(8888,'PRAKASH','CLERK',8000,'SALES','DALLAS');--error

--Force VIEW
============
select * from tab;
create view fv1 as select * from fview;--error cannot be created.
create force view fv1 as select * from fview;
select * from fv1;
desc fv1;
--To activate this force view we have to create a table named fview.
create table fview(fid int,fyear number(10));
insert into fview values(11,2002);
insert into fview values(22,2020);
select * from fview;
select * from fv1;
desc fv1;

--SHow All Views
================
desc user_views;
select view_name from user_views;
select view_name,text from user_views;

--Drop a View
=============
drop view v1;
drop view fv1;--syntax is same for all views.

--Alter a View
==============
select * from v2;
alter view v2 as select empno,ename,hiredate from empp2;--error
alter view v2 compile;
select * from v2;
/*(we cannot alter a view coz if we alter a view then database recompiles it whether it is valid or invalid. 
The main disadvantage is that Database invalidates the local objects that depenedent on that view)*/

--Rename a view
===============
rename v2 to v22;
select * from v2;
select * from v22;

--MATERIALIZED VIEWS
====================
select * from tite;

/*
SQL> desc tite;
 Name            Null?    Type
 -----           -----    ----
 RNO                      NUMBER(38)
 SNAME                    VARCHAR2(20)

SQL> create view vv as select * from tite;
View created.

SQL> create materialized view mv1 as select * from tite; (Here there is no need of a primary key on a base table)
Materialized view created.

SQL> insert into tite values(22,'Bibhu');
1 row created.

SQL> select * from tite;

 RNO SNAME
 --- -----
 22  Bibhu

SQL> select * from vv;

 RNO SNAME
 --- -----
 22  Bibhu

SQL> select * from mv1;(We need to refresh it for updation)
no rows selected

SQL> execute dbms_mview.refresh('mv1');(refreshing using on demand)(it is a pre defined plSQL command so we have to execute it using 'execute' command)
PL/SQL procedure successfully completed.

SQL> select * from mv1;

 RNO SNAME
 --- -----
 22  Bibhu

SQL> insert into tite values(33,'Khushi');
1 row created.

SQL> select * from vv;

 RNO SNAME
 --- -----
 22  Bibhu
 33  Khushi

SQL> select * from mv1;

 RNO SNAME    
 --- -----   (here it did not update so we have to refresh it)
 22  Bibhu

SQL> execute dbms_mview.refresh('mv1');
PL/SQL procedure successfully completed.

SQL> select * from mv1;

 RNO SNAME
 --- -----  (every time if we perform any modification on a base table every time we have to refresh the materialized view)
 22  Bibhu
 33  Khushi

SQL> update tite set rno=11 where sname='Bibhu';
1 row updated.

SQL> select * from vv;

 RNO SNAME
 --- -----
 11  Bibhu
 33  Khushi

SQL> select * from mv1;

 RNO SNAME
 --- -----
 22  Bibhu
 33  Khushi
 
SQL> execute dbms_mview.refresh('mv1');
PL/SQL procedure successfully completed.

SQL> select * from mv1;

 RNO SNAME
 --- -----
 11  Bibhu
 33  Khushi

SQL> drop table tite;
Table dropped.

SQL> purge recyclebin;
Recyclebin purged.

SQL> select * from vv;(now we can say it as a force view)
select * from vv
              *
ERROR at line 1:
ORA-04063: view "C##ABC.VV" has errors

SQL> select view_name from user_views;

VIEW_NAME
---------
V10
V3
V4
V5
V11
V12
V22
VV------> it exists still deletion of base table.(i.e if base table is deleted then the corresponding view wont be deleted it will act as a force view after deleting the base table.)
8 rows selected.

SQL> select * from mv1;(after deletion of base table still the data is available in materialized view because it is an independent object and it can store data of its own)

RNO SNAME
--- -----
11  Bibhu
33  Khushi

SQL> desc user_mviews;
 Name                        Null?          Type
 --------------------------------------------------------
 OWNER                       NOT NULL       VARCHAR2(128)
 MVIEW_NAME                  NOT NULL       VARCHAR2(128)
 CONTAINER_NAME              NOT NULL       VARCHAR2(128)
 QUERY                                      LONG
 QUERY_LEN                                  NUMBER(38)
 UPDATABLE                                  VARCHAR2(1)
 UPDATE_LOG                                 VARCHAR2(128)
 MASTER_ROLLBACK_SEG                        VARCHAR2(128)
 MASTER_LINK                                VARCHAR2(128)
 REWRITE_ENABLED                            VARCHAR2(1)
 REWRITE_CAPABILITY                         VARCHAR2(9)
 REFRESH_MODE                               VARCHAR2(9)
 REFRESH_METHOD                             VARCHAR2(8)
 BUILD_MODE                                 VARCHAR2(9)
 FAST_REFRESHABLE                           VARCHAR2(18)
 LAST_REFRESH_TYPE                          VARCHAR2(8)
 LAST_REFRESH_DATE                          DATE
 LAST_REFRESH_END_TIME                      DATE
 STALENESS                                  VARCHAR2(19)
 AFTER_FAST_REFRESH                         VARCHAR2(19)
 UNKNOWN_PREBUILT                           VARCHAR2(1)
 UNKNOWN_PLSQL_FUNC                         VARCHAR2(1)
 UNKNOWN_EXTERNAL_TABLE                     VARCHAR2(1)
 UNKNOWN_CONSIDER_FRESH                     VARCHAR2(1)
 UNKNOWN_IMPORT                             VARCHAR2(1)
 UNKNOWN_TRUSTED_FD                         VARCHAR2(1)
 COMPILE_STATE                              VARCHAR2(19)
 USE_NO_INDEX                               VARCHAR2(1)
 STALE_SINCE                                DATE
 NUM_PCT_TABLES                             NUMBER
 NUM_FRESH_PCT_REGIONS                      NUMBER
 NUM_STALE_PCT_REGIONS                      NUMBER
 SEGMENT_CREATED                            VARCHAR2(3)
 EVALUATION_EDITION                         VARCHAR2(128)
 UNUSABLE_BEFORE                            VARCHAR2(128)
 UNUSABLE_BEGINNING                         VARCHAR2(128)
 DEFAULT_COLLATION                          VARCHAR2(100)
 ON_QUERY_COMPUTATION                       VARCHAR2(1)

SQL> select mview_name from user_mviews;

MVIEW_NAME
----------
MV1

SQL> select * from tab;

TNAME             TABTYPE        CLUSTERID
------------------------------------------
V10               VIEW
EMPP2             TABLE
V3                VIEW
V4                VIEW
V5                VIEW
STUDENT           TABLE                                                                                                                         TABLE
V11               VIEW
V12               VIEW
FVIEW             TABLE
V22               VIEW                                                                                                                               VIEW
MV1               TABLE -------->(materialized view is same as a table because it can store data of its own)
GRADUATES         TABLE

SQL> select * from user_mviews;

Owner     MVIEW_NAME   CONTAINER_NAME     QUERY            QUERY_LEN     UPDATABLE    UPDATE_LOG   MASTER_ROLLBACK_SEG      
----------------------------------------------------------------------------------------------------------------------
C##ABC    MV1	        MV1	          select * from tite	18	          N			   null        null

MASTER_LINK  REWRITE_ENABLED  REWRITE_CAPABILITY  REFRESH_MODE   REFRESH_METHOD   BUILD_MODE  FAST_REFRESHABLE  LAST_REFRESH_TYPE                          
--------------------------------------------------------------------------------------------------------------------------------- 
null         N	              GENERAL	          DEMAND	     FORCE	          IMMEDIATE   NO	            COMPLETE
 
LAST_REFRESH_DATE   LAST_REFRESH_END_TIME    STALENESS      AFTER_FAST_REFRESH    UNKNOWN_PREBUILT    UNKNOWN_PLSQL_FUNC                         
------------------------------------------------------------------------------------------------------------------------
02-AUG-22	        02-AUG-22	           NEEDS_COMPILE	NEEDS_COMPILE	        N	                  N
 
UNKNOWN_EXTERNAL_TABLE   UNKNOWN_CONSIDER_FRESH    UNKNOWN_IMPORT     UNKNOWN_TRUSTED_FD  COMPILE_STATE   USE_NO_INDEX                               
---------------------------------------------------------------------------------------------------------------------- 
N	                      N                           	N	            N                 NEEDS_COMPILE	     N		
 
NUM_PCT_TABLES  NUM_FRESH_PCT_REGIONS  NUM_STALE_PCT_REGIONS SEGMENT_CREATED   EVALUATION_EDITION   UNUSABLE_BEFORE  
-------------------------------------------------------------------------------------------------------------------
0               null                   null                   YES               null                 null

UNUSABLE_BEGINNING  DEFAULT_COLLATION       ON_QUERY_COMPUTATION 
----------------------------------------------------------------
null                USING_NLS_COMP	         N 

*/

--On Commit
===========
create table tite2(sno int,sname varchar2(20));
insert into tite2 values(11,'Bibhu');
/*

SQL> create view vv2 as select * from tite2;
View created.

SQL> select * from vv2;

SNO SNAME
--- -----
11  Bibhu

SQL>  create materialized view mv2 refresh on commit as select * from tite2; (error cause of base table must have a primary key)
 create materialized view mv2 refresh on commit as select * from tite2
                                                                 *
ERROR at line 1:
ORA-12054: cannot set the ON COMMIT refresh attribute for the materialized view

SQL> alter table tite2 add constraint mp_key primary key(sno);
Table altered.

SQL> create materialized view mv2 refresh on commit as select * from tite2;
Materialized view created.

SQL> select * from mv2;
no rows selected

SQL> insert into tite2 values(22,'Khushi');
1 row created.

SQL> select * from tite2;

SNO SNAME
--- -----
11  Bibhu
22  Khushi

SQL> select * from vv2;

SNO SNAME
--- -----
11  Bibhu
22  Khushi

SQL> select * from mv2;
SNO SNAME
--- -----
11  Bibhu

SQL> commit;
Commit complete.

SQL> select * from mv2;

SNO SNAME
--- -----
11  Bibhu
22  Khushi

SQL> delete from tite2 where sno=11;
1 row deleted.

SQL> select * from tite2;

SNO SNAME
--- -----
22  Khushi

SQL> select * from vv2;

SNO SNAME
--- -----
22  Khushi

SQL> select * from mv2;

SNO SNAME
--- -----
11  Bibhu
22  Khushi

SQL> commit;
Commit complete.

SQL> select * from mv2;

SNO SNAME
--- -----
22  Khushi

*/
--Drop a materialized view
==========================
/*
SQL> drop materialized view mv1;

Materialized view dropped.

SQL> select mview_name from user_mviews;

MVIEW_NAME
----------
MV2

*/

--PARTITION TABLE
================================================================================

--Range partition
=================
create table part1(name varchar2(20),job varchar2(20),salary number(10,2))partition by range(salary)
(partition p1 values less than(1000),partition p2 values less than (5000),partition p3 values less than (9000));

desc part1;
insert into part1 values('Bibhu','JavaFSD',4000);
insert into part1 values('Rahul','PythonFSD',800);
insert into part1 values('Kamal','DBAdministrator',8000);
insert into part1 values('Babul','Web Developer',300);
insert into part1 values('Ganesh','SoftwareTester',6000);
select * from part1;
select * from part1 partition(p2);
select * from part1 partition(p3);
select * from part1 partition(p1);

--List partition
================
create table part2(cid int,sname varchar2(20),cname varchar2(20)) partition by list(cname)
(partition p1 values('core java','advanced java','frameworks'),partition p2 values('html','css','javascript','angular'),
partition p3 values('mysql','oracle'),partition others values(default));

insert into part2 values(101,'Bibhu','frameworks');
insert into part2 values(100,'Ganesh','oracle');
insert into part2 values(109,'Rajesh','cpp');
insert into part2 values(108,'puspa','core java');
insert into part2 values(104,'papul','angular');
insert into part2 values(105,'subha','python');

select * from part2;
select * from part2 partition(p1);
select * from part2 partition(p2);
select * from part2 partition(p3);
select * from part2 partition(others);

--Hash Partition
================
create table part3(sname varchar2(20),ssal number(10,2))partition by hash(ssal)partitions 5;
desc user_tab_partitions;
select partition_name from user_tab_partitions;

--Adding a new partition
========================
alter table part1 add partition p4 values less than(12000);
select partition_name from user_tab_partitions;

--Drop a Partition
==================
alter table part1 drop partition p4;
select partition_name from user_tab_partitions;

--Check table is partitioned or not
===================================
desc user_tables;

/*
SQL> SELECT PARTITIONED FROM USER_TABLES WHERE TABLE_NAME='PART1';

PAR
---
YES

SQL> SELECT PARTITIONED FROM USER_TABLES WHERE TABLE_NAME='EMPP';';
 
PAR
---
NO

*/

ORACLE SEQUENCE
================================================================================
/*
SQL> create sequence sq1 start with 1 minvalue 1 increment by 1 maxvalue 3;
Sequence created.

SQL> create table seq(sno int,sname varchar2(20));
Table created.

SQL> insert into seq values(sq1.nextval,'&sname');
Enter value for sname: Kamal
old   1: insert into seq values(sq1.nextval,'&sname')
new   1: insert into seq values(sq1.nextval,'Kamal')
1 row created.

SQL> /
Enter value for sname: Bibhu
old   1: insert into seq values(sq1.nextval,'&sname')
new   1: insert into seq values(sq1.nextval,'Bibhu')
1 row created.

SQL> /
Enter value for sname: Jilu
old   1: insert into seq values(sq1.nextval,'&sname')
new   1: insert into seq values(sq1.nextval,'Jilu')

1 row created.

SQL> /
Enter value for sname: Khushii
old   1: insert into seq values(sq1.nextval,'&sname')
new   1: insert into seq values(sq1.nextval,'Khushii')
insert into seq values(sq1.nextval,'Khushii')
                       *
ERROR at line 1:
ORA-08004: sequence SQ1.NEXTVAL exceeds MAXVALUE and cannot be instantiated

SQL> select * from seq;

SNO SNAME
--- -----
1   Kamal
2   Bibhu
3   Jilu */

Altering a Sequence
=====================
/*
SQL> alter sequence sq1 maxvalue 5;
Sequence altered.

SQL> insert into seq values(sq1.nextval,'&sname');
Enter value for sname: Rahul
old   1: insert into seq values(sq1.nextval,'&sname')
new   1: insert into seq values(sq1.nextval,'Rahul')
1 row created.

SQL> /
Enter value for sname: Gabar
old   1: insert into seq values(sq1.nextval,'&sname')
new   1: insert into seq values(sq1.nextval,'Gabar')
1 row created.

SQL> /
Enter value for sname: Gill
old   1: insert into seq values(sq1.nextval,'&sname')
new   1: insert into seq values(sq1.nextval,'Gill')
insert into seq values(sq1.nextval,'Gill')
                       *
ERROR at line 1:
ORA-08004: sequence SQ1.NEXTVAL exceeds MAXVALUE and cannot be instantiated

SQL> select * from seq;

SNO SNAME
--- -----
1   Kamal
2   Bibhu
3   Jilu 
4   Rahul
5   Gabar

SQL>  alter sequence sq1 cache 2;
Sequence altered.
*/


SQL> create sequence sq2 start with 1 minvalue 1 increment by 1 maxvalue 3 cycle cache 2;
Sequence created.

SQL> create table seq2(sno int,sname varchar2(20));
Table created.

SQL> insert into seq2 values(sq2.nextval,'&sname');
Enter value for sname: A
old   1: insert into seq2 values(sq2.nextval,'&sname')
new   1: insert into seq2 values(sq2.nextval,'A')
1 row created.

SQL> /
Enter value for sname: B
old   1: insert into seq2 values(sq2.nextval,'&sname')
new   1: insert into seq2 values(sq2.nextval,'B')
1 row created.

SQL> /
Enter value for sname: C
old   1: insert into seq2 values(sq2.nextval,'&sname')
new   1: insert into seq2 values(sq2.nextval,'C')
1 row created.

SQL> /
Enter value for sname: D
old   1: insert into seq2 values(sq2.nextval,'&sname')
new   1: insert into seq2 values(sq2.nextval,'D')
1 row created.

SQL> /
Enter value for sname: E
old   1: insert into seq2 values(sq2.nextval,'&sname')
new   1: insert into seq2 values(sq2.nextval,'E')
1 row created.

SQL> /
Enter value for sname: F
old   1: insert into seq2 values(sq2.nextval,'&sname')
new   1: insert into seq2 values(sq2.nextval,'F')
1 row created.

SQL> /
Enter value for sname: G
old   1: insert into seq2 values(sq2.nextval,'&sname')
new   1: insert into seq2 values(sq2.nextval,'G')
1 row created.

SQL> select * from seq2;

SNO SNAME
--- -----
1    A
2    B
3    C
1    D
2    E
3    F
1    G
7 rows selected.



SQL> create sequence sq3 start with 3 minvalue 1 increment by 1 maxvalue 5 cycle cache 2;
Sequence created.

SQL> create table seq3(sno int,sname varchar2(20));
Table created.

SQL> insert into seq3 values(sq3.nextval,'&sname');
Enter value for sname: A
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'A')
1 row created.

SQL> /
Enter value for sname: B
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'B')
1 row created.

SQL> /
Enter value for sname: C
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'C')
1 row created.

SQL> /
Enter value for sname: D
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'D')
1 row created.

SQL> /
Enter value for sname: E
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'E')
1 row created.

SQL> /
Enter value for sname: F
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'F')
1 row created.

SQL> /
Enter value for sname: G
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'G')
1 row created.

SQL> /
Enter value for sname: H
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'H')
1 row created.

SQL> /
Enter value for sname: I
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'I')
1 row created.

SQL> /
Enter value for sname: J
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'J')
1 row created.

SQL> /
Enter value for sname: K
old   1: insert into seq3 values(sq3.nextval,'&sname')
new   1: insert into seq3 values(sq3.nextval,'K')
1 row created.

SQL> select * from seq3;

SNO SNAME
--- -----
3    A
4    B
5    C
1    D
2    E
3    F
4    G
5    H
1    I
2    J
3    K
11 rows selected.

View Sequences
=============
/*

SQL> desc user_sequences;
 Name                    Null?       Type
 -------------           -----       -------------
 SEQUENCE_NAME           NOT NULL    VARCHAR2(128)
 MIN_VALUE                           NUMBER
 MAX_VALUE                           NUMBER
 INCREMENT_BY            NOT NULL    NUMBER
 CYCLE_FLAG                          VARCHAR2(1)
 ORDER_FLAG                          VARCHAR2(1)
 CACHE_SIZE              NOT NULL    NUMBER
 LAST_NUMBER             NOT NULL    NUMBER
 SCALE_FLAG                          VARCHAR2(1)
 EXTEND_FLAG                         VARCHAR2(1)
 SHARDED_FLAG                        VARCHAR2(1)
 SESSION_FLAG                        VARCHAR2(1)
 KEEP_VALUE                          VARCHAR2(1)

SQL> select sequence_name from user_sequences;

SEQUENCE_NAME
-------------
SQ1
SQ2
SQ3

*/
Drop a Sequence
=================
/*
SQL> drop sequence sq1;
Sequence dropped.

SQL> select sequence_name from user_sequences;

SEQUENCE_NAME
-------------
SQ2
SQ3
*/

LOCKING
================================================================================

--User System
=============
/*
SQL> conn
Enter user-name: system/Jilucse2002
Connected.

SQL> update c##abc.emp set eid=109 where ename='kabita';   --->1
1 row updated.

SQL> commit;    --->3
Commit complete.

SQL> select * from c##abc.emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000           34
       103 kajal                       30000                           40
       107 Pratap                    78200          0              40
       111 Supriya                  12000       3450          20
       100 Raj                          42000                          40
       109 kabita                     30000                          40
6 rows selected.


--User c##abc
=============
SQL> conn
Enter user-name: c##abc/abcpwd
Connected.

SQL> select * from emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                     30000                    40
       107 Pratap                    78200          0         40
       111 Supriya                   12000       3450         20
       100 Raj                       42000                    40
       208 kabita                    30000                    40
6 rows selected.

SQL> update emp set eid=209 where ename='kabita'; (wont update coz it is locked by the user system)    --->2
_                       (after releasing using commit in system it will be updated)
1 row updated.    --->4

SQL> select * from emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                     30000                    40
       107 Pratap                    78200          0         40
       111 Supriya                   12000       3450         20
       100 Raj                       42000                    40
       209 kabita                    30000                    40
6 rows selected.

*/
select * from emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                       30000                         40
       107 Pratap                    78200          0            40
       111 Supriya                  12000       3450         20
       100 Raj                         42000                         40
       109 kabita                    30000                         40
(cause of commit)


--User System
=============
/*
SQL> update c##abc.emp set eid=200 where ename='kabita'; --->1
1 row updated.

SQL> rollback;    ---3
Rollback complete.

SQL> select * from c##abc.emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                     30000                    40
       107 Pratap                    78200          0         40
       111 Supriya                   12000       3450         20
       100 Raj                       42000                    40
       109 kabita                    30000                    40
6 rows selected.


--User c##abc
=============

SQL> select * from emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                     30000                    40
       107 Pratap                    78200          0         40
       111 Supriya                   12000       3450         20
       100 Raj                       42000                    40
       109 kabita                    30000                    40

6 rows selected.

SQL> update emp set eid=400 where ename='kabita';   --->2
_
1 row updated.

SQL> select * from emp;    --->4

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                     30000                    40
       107 Pratap                    78200          0         40
       111 Supriya                   12000       3450         20
       100 Raj                       42000                    40
       400 kabita                    30000                    40
6 rows selected.
*/

select * from emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                     30000                    40
       107 Pratap                    78200          0         40
       111 Supriya                   12000       3450         20
       100 Raj                       42000                    40
       109 kabita                    30000                    40
(cause of Rollback)

--Deadlock
==========

--User System
=============
/*

SQL> update c##abc.emp set eid=200 where ename='Raj';    --->1
1 row updated.

SQL> update c##abc.emp set eid=400 where ename='kabita';   --->3 (locked by user c##abc)
_
update c##abc.emp set eid=400 where ename='kabita'    --->5 (after locking user c##abc then deadlock error message will print)  
                                    *
ERROR at line 1:
ORA-00060: deadlock detected while waiting for resource


SQL> commit;        --->6
Commit complete.

SQL> select * from c##abc.emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                     30000                    40
       107 Pratap                    78200          0         40
       111 Supriya                   12000       3450         20
       200 Raj                       42000                    40
       109 kabita                    30000                    40
6 rows selected.


--User c##abc
=============

SQL> select * from emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                     30000                    40
       107 Pratap                    78200          0         40
       111 Supriya                   12000       3450         20
       100 Raj                       42000                    40
       109 kabita                    30000                    40
6 rows selected.

SQL> update emp set eid=300 where ename='kabita';    --->2
1 row updated.

SQL> update emp set eid=500 where ename='Raj';   --->4  (locked by user system)
_
1 row updated.

SQL> select * from emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                     30000                    40
       107 Pratap                    78200          0         40
       111 Supriya                   12000       3450         20
       500 Raj                       42000                    40
       300 kabita                    30000                    40

6 rows selected.
*/

select * from emp;

       EID ENAME                      ESAL      EXTRA       EAGE
---------- -------------------- ---------- ---------- ----------
       101 Bibhu                     25600       2000         34
       103 kajal                     30000                    40
       107 Pratap                    78200          0         40
       111 Supriya                   12000       3450         20
       200 Raj                       42000                    40
       109 kabita  

Table Lock
===========
/*
--Share Mode
============
--User System
-------------
SQL> lock table c##abc.emp in share mode;   --->1
Table(s) Locked.

SQL> update c##abc.emp set ename='nnn' where eage=40;    --->3
_
4 rows updated.   --->5


--User c##abc
-------------
SQL> lock table emp in share mode;    --->2
Table(s) Locked.

SQL> commit;   --->4
Commit complete.

Exclusive Mode
================
--User System
-------------------
SQL> lock table c##abc.emp in exclusive mode;      --->1
Table(s) Locked.

SQL> rollback;     --->3
Rollback complete.

--User c##abc
=============
SQL> lock table emp in exclusive mode;   --->2
_
Table(s) Locked.     --->4

--(In Rollback case Same)
*/

INDEXES
================================================================================

--Table Scan
------------
select * from empp where sal=3000;

--Index scan automatically
--------------------------
/*
SQL> create table chk_index(sno int primary key,sname varchar2(20),sid int unique);
Table created.

SQL> desc user_ind_columns;
 Name                                      Null?    Type
 ----------------------------------------- -------- -------------
 INDEX_NAME                                         VARCHAR2(128)
 TABLE_NAME                                         VARCHAR2(128)
 COLUMN_NAME                                        VARCHAR2(4000)
 COLUMN_POSITION                                    NUMBER
 COLUMN_LENGTH                                      NUMBER
 CHAR_LENGTH                                        NUMBER
 DESCEND                                            VARCHAR2(4)
 COLLATED_COLUMN_ID                                 NUMBER
 
SQL> select column_name,index_name from user_ind_columns where table_name='chk_index';
no rows selected

SQL> SELECT COLUMN_NAME,INDEX_NAME FROM USER_IND_COLUMNS WHERE TABLE_NAME='CHK_INDEX';

COLUMN_NAME      INDEX_NAME
-----------      ----------
SNO              SYS_C007581
SID              SYS_C007582

*/
B-TREE INDEX
=============

Simple Index
-------------
/*
SQL> create index ind1 on empp(sal);
Index created.

select * from empp where eid=7782;(index wont be activated here)
select * from empp where sal=3000;(index will activate here coz sal is an indexed column)
*/

Composite Index
===============
/*
SQL> create index ind2 on empp(deptno,job);
Index created.

SQL> SELECT COLUMN_NAME,INDEX_NAME FROM USER_IND_COLUMNS WHERE TABLE_NAME='EMPP';
COLUMN_NAME    INDEX_NAME
-----------    ----------
SAL            IND1
DEPTNO         IND2
JOB            IND2

select * from empp where deptno=10; (index scan)
select * from empp where deptno=10 and job='CLERK'; (index scan)
select * from empp where job='CLERK'; (table scan)

*/
Unique Index
=============
/*                            
SQL> select * from dept;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        10 ACCOUNTING     NEW YORK
        20 RESEARCH       DALLAS
        30 SALES          CHICAGO
        40 OPERATIONS     BOSTON

SQL> insert into dept values(50,'SALES','USA');
1 row created.

SQL> select * from dept;

    DEPTNO DNAME          LOC
---------- -------------- -------------
        50 SALES          USA
        10 ACCOUNTING     NEW YORK
        20 RESEARCH       DALLAS
        30 SALES          CHICAGO
        40 OPERATIONS     BOSTON

SQL> create unique index ind4 on dept(dname);
create unique index ind4 on dept(dname)
                            *
ERROR at line 1:
ORA-01452: cannot CREATE UNIQUE INDEX; duplicate keys found

SQL> delete from dept where deptno=50;
1 row deleted.

SQL> create unique index ind4 on dept(dname);
Index created.

SQL> SELECT COLUMN_NAME,INDEX_NAME FROM USER_IND_COLUMNS WHERE TABLE_NAME='DEPT';

COLUMN_NAME        INDEX_NAME
-----------        ----------
DNAME              IND4


SQL> INSERT INTO DEPT VALUES(50,'SALES','LONDON');
INSERT INTO DEPT VALUES(50,'SALES','LONDON')
*
ERROR at line 1:
ORA-00001: unique constraint (C##ABC.IND4) violated
*/
Functional Based Index
=======================
/*
SQL>  create index ind5 on empp(upper(ename));
Index created.

select * from empp where ename='smith'; (index wont be activated here)
select * from empp where ename='SMITH'; (index will activate here)
select * from empp where upper(ename) = 'Smith'; (index will activate here)
select * from empp where ename='KING'; (index will activate here)

*/
BITMAP INDEX
=============
/*
SQL> create bitmap index bm_ind on empp(job);  (Coz job has the lower cardinality as compare to empno)
Index created.

SQL> select * from empp where job='CLERK';   (bitmap index is activated & internally server will create a bitmap table)

SQL> desc user_indexes;
 
 Name                    Null?    Type           
----------------------- -------- -------------- 
INDEX_NAME              NOT NULL VARCHAR2(128)  
INDEX_TYPE                       VARCHAR2(27)   
TABLE_OWNER             NOT NULL VARCHAR2(128)  
TABLE_NAME              NOT NULL VARCHAR2(128)  
TABLE_TYPE                       VARCHAR2(11)   
UNIQUENESS                       VARCHAR2(9)    
COMPRESSION                      VARCHAR2(13)   
PREFIX_LENGTH                    NUMBER         
TABLESPACE_NAME                  VARCHAR2(30)   
INI_TRANS                        NUMBER         
MAX_TRANS                        NUMBER         
INITIAL_EXTENT                   NUMBER         
NEXT_EXTENT                      NUMBER         
MIN_EXTENTS                      NUMBER         
MAX_EXTENTS                      NUMBER         
PCT_INCREASE                     NUMBER         
PCT_THRESHOLD                    NUMBER         
INCLUDE_COLUMN                   NUMBER         
FREELISTS                        NUMBER         
FREELIST_GROUPS                  NUMBER         
PCT_FREE                         NUMBER         
LOGGING                          VARCHAR2(3)    
BLEVEL                           NUMBER         
LEAF_BLOCKS                      NUMBER         
DISTINCT_KEYS                    NUMBER         
AVG_LEAF_BLOCKS_PER_KEY          NUMBER         
AVG_DATA_BLOCKS_PER_KEY          NUMBER         
CLUSTERING_FACTOR                NUMBER         
STATUS                           VARCHAR2(8)    
NUM_ROWS                         NUMBER         
SAMPLE_SIZE                      NUMBER         
LAST_ANALYZED                    DATE           
DEGREE                           VARCHAR2(40)   
INSTANCES                        VARCHAR2(40)   
PARTITIONED                      VARCHAR2(3)    
TEMPORARY                        VARCHAR2(1)    
GENERATED                        VARCHAR2(1)    
SECONDARY                        VARCHAR2(1)    
BUFFER_POOL                      VARCHAR2(7)    
FLASH_CACHE                      VARCHAR2(7)    
CELL_FLASH_CACHE                 VARCHAR2(7)    
USER_STATS                       VARCHAR2(3)    
DURATION                         VARCHAR2(15)   
PCT_DIRECT_ACCESS                NUMBER         
ITYP_OWNER                       VARCHAR2(128)  
ITYP_NAME                        VARCHAR2(128)  
PARAMETERS                       VARCHAR2(1000) 
GLOBAL_STATS                     VARCHAR2(3)    
DOMIDX_STATUS                    VARCHAR2(12)   
DOMIDX_OPSTATUS                  VARCHAR2(6)    
FUNCIDX_STATUS                   VARCHAR2(8)    
JOIN_INDEX                       VARCHAR2(3)    
IOT_REDUNDANT_PKEY_ELIM          VARCHAR2(3)    
DROPPED                          VARCHAR2(3)    
VISIBILITY                       VARCHAR2(9)    
DOMIDX_MANAGEMENT                VARCHAR2(14)   
SEGMENT_CREATED                  VARCHAR2(3)    
ORPHANED_ENTRIES                 VARCHAR2(3)    
INDEXING                         VARCHAR2(7)    
AUTO                             VARCHAR2(3)    
CONSTRAINT_INDEX                 VARCHAR2(3)    


SQL> SELECT INDEX_NAME,INDEX_TYPE FROM USER_INDEXES ;

INDEX _NAME         INDEX TYPE
-----------         ----------
IND1	            NORMAL
IND2	            NORMAL
IND5	            FUNCTION-BASED NORMAL
BM_IND	            BITMAP
IND4	            NORMAL
SYS_C007455	        NORMAL
SYS_C007458	        NORMAL
SYS_C007459     	NORMAL
SYS_C007460	        NORMAL
SYS_C007476	        NORMAL
SYS_C007477	        NORMAL
SYS_C007478	        NORMAL
SYS_C007482	        NORMAL
SYS_C007484	        NORMAL
SYS_C007492	        NORMAL
PRIMEE	            NORMAL
MP_KEY	            NORMAL
SYS_C_SNAP$_2MP_KEY	NORMAL
SYS_C007581     	NORMAL
SYS_C007582	        NORMAL
20 rows selected.

SQL> SELECT INDEX_NAME,INDEX_TYPE FROM USER_INDEXES WHERE TABLE_NAME='EMPP';

INDEX_NAME  INDEX_TYPE
----------  ----------
IND1	     NORMAL
IND2	     NORMAL
IND5	     FUNCTION-BASED NORMAL
BM_IND       BITMAP                                                                                                                           BITMAP
*/
Drop an Index
==============
/*SQL> drop index ind1;
Index dropped.

SQL> SELECT INDEX_NAME,INDEX_TYPE FROM USER_INDEXES WHERE TABLE_NAME='EMPP';

INDEX_NAME  INDEX_TYPE
----------  ----------
IND2	     NORMAL
IND5	     FUNCTION-BASED NORMAL
BM_IND       BITMAP 
*/

CLUSTER
================================================================================
/*

SQL> create cluster clst1(deptno int);
Cluster created.

SQL> create table department1(sid int,sname varchar2(20),deptno int)cluster clst1(deptno);
Table created.

SQL> create table department2(deptno int,name varchar2(20),dname varchar2(20))cluster clst1(deptno);
Table created.

SQL> insert into department1 values(1901,'Bibhu',10);
insert into department1 values(1901,'Bibhu',10)
            *
ERROR at line 1:
ORA-02032: clustered tables cannot be used before the cluster index is built


SQL> create index ind_clst1 on cluster clst1;
Index created.

SQL> insert into department1 values(1901,'Bibhu',10);
1 row created.

SQL>  insert into department1 values(1903,'Ram',40);
1 row created.

SQL>  insert into department1 values(1900,'Suresh',30);
1 row created.

SQL> commit;
Commit complete.


SQL> insert into department2 values(50,'Suresh','Suresh');
1 row created.

SQL>  insert into department2 values(30,'Jilu','ECE');
1 row created.

SQL> select * from department1;

       SID SNAME                    DEPTNO
---------- -------------------- ----------
      1903 Ram                         40
      1900 Suresh                     30
      1901 Bibhu                       10

SQL> select * from department2;

    DEPTNO NAME                 DNAME
---------- -------------------- --------
        30 Jilu                 ECE
        50 Suresh               Suresh
        

SQL> select rowid,sid,sname,deptno from department1;

ROWID                     SID SNAME                    DEPTNO
------------------ ---------- -------------------- ----------
AAASPTAAHAAAAPDAAA       1903 Ram                          40
AAASPTAAHAAAAPFAAA       1900 Suresh                       30      ---->same rowid
AAASPTAAHAAAAPHAAA       1901 Bibhu                        10

SQL>  select rowid,deptno,name,dname from department2;

ROWID                  DEPTNO NAME                 DNAME
------------------ ---------- -------------------- --------------------
AAASPTAAHAAAAPFAAA         30 Jilu                 ECE             ---->same rowid
AAASPTAAHAAAAPGAAA         50 Suresh               Suresh

SQL> desc user_tables;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 TABLE_NAME                                NOT NULL VARCHAR2(128)
 TABLESPACE_NAME                                    VARCHAR2(30)
 CLUSTER_NAME                                       VARCHAR2(128)
 IOT_NAME                                           VARCHAR2(128)
 STATUS                                             VARCHAR2(8)
 PCT_FREE                                           NUMBER
 PCT_USED                                           NUMBER
 INI_TRANS                                          NUMBER
 MAX_TRANS                                          NUMBER
 INITIAL_EXTENT                                     NUMBER
 NEXT_EXTENT                                        NUMBER
 MIN_EXTENTS                                        NUMBER
 MAX_EXTENTS                                        NUMBER
 PCT_INCREASE                                       NUMBER
 FREELISTS                                          NUMBER
 FREELIST_GROUPS                                    NUMBER
 LOGGING                                            VARCHAR2(3)
 BACKED_UP                                          VARCHAR2(1)
 NUM_ROWS                                           NUMBER
 BLOCKS                                             NUMBER
 EMPTY_BLOCKS                                       NUMBER
 AVG_SPACE                                          NUMBER
 CHAIN_CNT                                          NUMBER
 AVG_ROW_LEN                                        NUMBER
 AVG_SPACE_FREELIST_BLOCKS                          NUMBER
 NUM_FREELIST_BLOCKS                                NUMBER
 DEGREE                                             VARCHAR2(10)
 INSTANCES                                          VARCHAR2(10)
 CACHE                                              VARCHAR2(5)
 TABLE_LOCK                                         VARCHAR2(8)
 SAMPLE_SIZE                                        NUMBER
 LAST_ANALYZED                                      DATE
 PARTITIONED                                        VARCHAR2(3)
 IOT_TYPE                                           VARCHAR2(12)
 TEMPORARY                                          VARCHAR2(1)
 SECONDARY                                          VARCHAR2(1)
 NESTED                                             VARCHAR2(3)
 BUFFER_POOL                                        VARCHAR2(7)
 FLASH_CACHE                                        VARCHAR2(7)
 CELL_FLASH_CACHE                                   VARCHAR2(7)
 ROW_MOVEMENT                                       VARCHAR2(8)
 GLOBAL_STATS                                       VARCHAR2(3)
 USER_STATS                                         VARCHAR2(3)
 DURATION                                           VARCHAR2(15)
 SKIP_CORRUPT                                       VARCHAR2(8)
 MONITORING                                         VARCHAR2(3)
 CLUSTER_OWNER                                      VARCHAR2(128)
 DEPENDENCIES                                       VARCHAR2(8)
 COMPRESSION                                        VARCHAR2(8)
 COMPRESS_FOR                                       VARCHAR2(30)
 DROPPED                                            VARCHAR2(3)
 READ_ONLY                                          VARCHAR2(3)
 SEGMENT_CREATED                                    VARCHAR2(3)
 RESULT_CACHE                                       VARCHAR2(7)
 CLUSTERING                                         VARCHAR2(3)
 ACTIVITY_TRACKING                                  VARCHAR2(23)
 DML_TIMESTAMP                                      VARCHAR2(25)
 HAS_IDENTITY                                       VARCHAR2(3)
 CONTAINER_DATA                                     VARCHAR2(3)
 INMEMORY                                           VARCHAR2(8)
 INMEMORY_PRIORITY                                  VARCHAR2(8)
 INMEMORY_DISTRIBUTE                                VARCHAR2(15)
 INMEMORY_COMPRESSION                               VARCHAR2(17)
 INMEMORY_DUPLICATE                                 VARCHAR2(13)
 DEFAULT_COLLATION                                  VARCHAR2(100)
 DUPLICATED                                         VARCHAR2(1)
 SHARDED                                            VARCHAR2(1)
 EXTERNAL                                           VARCHAR2(3)
 HYBRID                                             VARCHAR2(3)
 CELLMEMORY                                         VARCHAR2(24)
 CONTAINERS_DEFAULT                                 VARCHAR2(3)
 CONTAINER_MAP                                      VARCHAR2(3)
 EXTENDED_DATA_LINK                                 VARCHAR2(3)
 EXTENDED_DATA_LINK_MAP                             VARCHAR2(3)
 INMEMORY_SERVICE                                   VARCHAR2(12)
 INMEMORY_SERVICE_NAME                              VARCHAR2(1000)
 CONTAINER_MAP_OBJECT                               VARCHAR2(3)
 MEMOPTIMIZE_READ                                   VARCHAR2(8)
 MEMOPTIMIZE_WRITE                                  VARCHAR2(8)
 HAS_SENSITIVE_COLUMN                               VARCHAR2(3)
 ADMIT_NULL                                         VARCHAR2(3)
 DATA_LINK_DML_ENABLED                              VARCHAR2(3)
 LOGICAL_REPLICATION                                VARCHAR2(8)
 
 
 SQL> SELECT TABLE_NAME,CLUSTER_NAME FROM USER_TABLES WHERE CLUSTER_NAME='CLST1';

TABLE_NAME          CLUSTER_NAME
-----------         ------------
DEPARTMENT1         CLST1
DEPARTMENT2         CLST1

SQL> desc user_clusters;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 CLUSTER_NAME                              NOT NULL VARCHAR2(128)
 TABLESPACE_NAME                           NOT NULL VARCHAR2(30)
 PCT_FREE                                           NUMBER
 PCT_USED                                           NUMBER
 KEY_SIZE                                           NUMBER
 INI_TRANS                                 NOT NULL NUMBER
 MAX_TRANS                                 NOT NULL NUMBER
 INITIAL_EXTENT                                     NUMBER
 NEXT_EXTENT                                        NUMBER
 MIN_EXTENTS                               NOT NULL NUMBER
 MAX_EXTENTS                               NOT NULL NUMBER
 PCT_INCREASE                                       NUMBER
 FREELISTS                                          NUMBER
 FREELIST_GROUPS                                    NUMBER
 AVG_BLOCKS_PER_KEY                                 NUMBER
 CLUSTER_TYPE                                       VARCHAR2(5)
 FUNCTION                                           VARCHAR2(15)
 HASHKEYS                                           NUMBER
 DEGREE                                             VARCHAR2(10)
 INSTANCES                                          VARCHAR2(10)
 CACHE                                              VARCHAR2(5)
 BUFFER_POOL                                        VARCHAR2(7)
 FLASH_CACHE                                        VARCHAR2(7)
 CELL_FLASH_CACHE                                   VARCHAR2(7)
 SINGLE_TABLE                                       VARCHAR2(5)
 DEPENDENCIES                                       VARCHAR2(8)

SQL> SELECT CLUSTER_NAME FROM USER_CLUSTERS;

CLUSTER_NAME
------------
CLST1

SQL> select * from department1 d1,department2 d2 where d1.deptno=d2.deptno;

SID   SNAME   DEPTNO   DEPTNO   NAME    DNAME
---   -----   ------   ------   ----    -----
1900 Suresh     30       30     Jilu    ECE    

        
*/
Drop a Cluster
===============
/*
SQL> drop cluster clst1;
drop cluster clst1
*
ERROR at line 1:
ORA-00951: cluster not empty

SQL> drop cluster clst1 including tables;
Cluster dropped.

SQL> desc department1;
ERROR:
ORA-04043: object department1 does not exist

SQL> SELECT TABLE_NAME,CLUSTER_NAME FROM USER_TABLES WHERE CLUSTER_NAME='CLST1';
no rows selected
*/

USER DEFINED DATA TYPE
================================================================================

Composite/Object Type
----------------------------------
/*
SQL> create type course_details as object(cid number(10),cname varchar2(20),cfee number(20));
  2  /
Type created.

SQL> create table stu_udf(sno int,sname varchar2(20),course course_details);
Table created.

SQL> desc stu_udf;
 Name                                      Null?    Type
 ------------------------------------- -------- ----------------------------
 SNO                                                    NUMBER(38)
 SNAME                                               VARCHAR2(20)
 COURSE                                             COURSE_DETAILS

SQL> insert into stu_udf values(10,'Bibhudatta',course_details(1901,'JavaFSD',12000));
1 row created.

SQL> insert into stu_udf values(10,'Bibhudatta',course_details(1905,'PythonFSD',14000));
1 row created.

SQL> insert into stu_udf values(30,'Sourav',course_details(1910,'WebDeveloper',15000));
1 row created.

SQL> insert into stu_udf values(40,'Mahesh',course_details(1920,'DataScientist',55000));
1 row created.

SQL> select * from stu_udf;

SNO  SNAME        COURSE(CID, CNAME, CFEE)
---  -----        --------------------------------------
10   Bibhudatta   COURSE_DETAILS(1901, 'JavaFSD', 12000)
10   Bibhudatta   COURSE_DETAILS(1905, 'PythonFSD', 14000)
30   Sourav       COURSE_DETAILS(1910, 'WebDeveloper', 15000)
40   Mahesh       COURSE_DETAILS(1920, 'DataScientist', 55000)


SQL> select s.sno,s.sname,s.course.cid Course_Id,s.course.cname Course_Names,s.course.cfee Course_fee from stu_udf s;

       SNO SNAME                 COURSE_ID COURSE_NAMES         COURSE_FEE
---------- -------------------- ---------- -------------------- ----------
        10 Bibhudatta                 1901 JavaFSD                   12000
        10 Bibhudatta                 1905 PythonFSD                 14000
        30 Sourav                     1910 WebDeveloper              15000
        40 Mahesh                     1920 DataScientist             55000

SQL> update stu_udf s set s.sno=20,s.sname='Ganesh' where s.course.cid=1901;
1 row updated.

SQL>  select s.sno,s.sname,s.course.cid Course_Id,s.course.cname Course_Names,s.course.cfee Course_fee from stu_udf s;

       SNO SNAME                 COURSE_ID COURSE_NAMES         COURSE_FEE
---------- -------------------- ---------- -------------------- ----------
        20 Ganesh                     1901 JavaFSD                   12000
        10 Bibhudatta                 1905 PythonFSD                 14000
        30 Sourav                     1910 WebDeveloper              15000
        40 Mahesh                     1920 DataScientist             55000

SQL> delete from stu_udf s where s.sno=20;
1 row deleted.

SQL>  select s.sno,s.sname,s.course.cid Course_Id,s.course.cname Course_Names,s.course.cfee Course_fee from stu_udf s;

       SNO SNAME                 COURSE_ID COURSE_NAMES         COURSE_FEE
---------- -------------------- ---------- -------------------- ----------
        10 Bibhudatta                 1905 PythonFSD                 14000
        30 Sourav                     1910 WebDeveloper              15000
        40 Mahesh                     1920 DataScientist             55000

SQL> commit;
Commit complete.
*/

VARRAY
=======
/*

SQL> create type MOBNOLIST is varray(3) of varchar2(20);  (maximun contains 3 values)
  2  /
Type created.

SQL> create table shop(sid int,sname varchar2(20),saddress varchar2(20),mlist mobnolist);
Table created.

SQL> desc shop;
 Name                    Null?    Type
 ----------------------- -------- ------------
 SID                              NUMBER(38)
 SNAME                            VARCHAR2(20)
 SADDRESS                         VARCHAR2(20)
 MLIST                            MOBNOLIST

SQL> insert into shop values(1901,'T-Point','Bhadrak',mobnolist('Iphone','OnePlus'));
1 row created.

SQL> insert into shop values(1905,'Maa-Ambika','Balasore',mobnolist('Redmi','OnePlus','Oppo'));
1 row created.

SQL> insert into shop values(1900,'Zero-Point','Bhubaneswar',mobnolist('Iphone','Vivo','Nokia','Asus'));
insert into shop values(1900,'Zero-Point','Bhubaneswar',mobnolist('Iphone','Vivo','Nokia','Asus'))
                                                        *
ERROR at line 1:
ORA-22909: exceeded maximum VARRAY limit

SQL> select * from shop;

SID    SNAME       SADDRESS       MLIST
---    -----       --------       -------------------------------------
1901   T-Point     Bhadrak        MOBNOLIST('Iphone', 'OnePlus')
1905   Maa-Ambika  Balasore       MOBNOLIST('Redmi', 'OnePlus', 'Oppo')
 
*/
Nested Table
=============
/*

SQL> create type nest_tb as object(ccity varchar2(20),cstate varchar2(20));
  2  /
Type created.

SQL> create type cust_addr as table of nest_tb;
  2  /
Type created.

SQL> create table customer(cid int,cname varchar2(20),caddress cust_addr)nested table caddress store as CADD;
Table created.

SQL> insert into customer values(1901,'Bibhu',cust_addr(nest_tb('Hyderabad','Telengana')));
1 row created.

SQL> insert into customer values(1909,'Ganesh',cust_addr(nest_tb('Bhubaneswar','Odisha'),nest_tb('Bangalore','Karnataka')));
1 row created.

SQL> select * from customer;

CID   CNAME         CADDRESS(CCITY, CSTATE)
-----   ----------         --------------------------------------
1901  Bibhu         CUST_ADDR(NEST_TB('Hyderabad', 'Telengana'))
1909  Ganesh        CUST_ADDR(NEST_TB('Bhubaneswar', 'Odisha'), NEST_TB('Bangalore', 'Karnataka'))


SQL> select * from table (select c.cid,c.caddress as Customer_City from customer c where c.cid=1901);
select * from table (select c.cid,c.caddress as Customer_City from customer c where c.cid=1901)
                     *
ERROR at line 1:
ORA-02324: more than one column in the SELECT list of THE subquery


SQL> select * from table (select c.caddress as Customer_City from customer c where c.cid=1901);

CCITY                            CSTATE
--------                            -----------
Hyderabad                  Telengana

SQL>  select * from table (select c.cname as Customer_City from customer c where c.cid=1901);
 select * from table (select c.cname as Customer_City from customer c where c.cid=1901)
               *
ERROR at line 1:
ORA-22905: cannot access rows from a non-nested table item

SQL>  select * from table (select caddress as Customer_City from customer c where c.cid=1909);

CCITY                CSTATE
-----                ------
Bhubaneswar          Odisha
Bangalore            Karnataka

SQL>  select * from table (select caddress as Customer_City from customer c where c.cid=1909)where ccity='Bangalore';

CCITY                CSTATE
-----                ------
Bangalore            Karnataka

SQL> select * from customer;

CID   CNAME         CADDRESS(CCITY, CSTATE)
---   -----         -----------------------
1901  Bibhu         CUST_ADDR(NEST_TB('Hyderabad', 'Telengana'))
1909  Ganesh        CUST_ADDR(NEST_TB('Bhubaneswar', 'Odisha'), NEST_TB('Bangalore', 'Karnataka'))

SQL> update customer set cid=1902 where cname='Ganesh';
1 row updated.

SQL> update table(select caddress from customer where cid=1901)set ccity='SR Nagar';
1 row updated.

SQL> select * from customer;

CID    CNAME     CADDRESS(CCITY, CSTATE)
---    -----     -----------------------
1901   Bibhu     CUST_ADDR(NEST_TB('SR Nagar', 'Telengana'))
1902   Ganesh    CUST_ADDR(NEST_TB('Bhubaneswar', 'Odisha'), NEST_TB('Bangalore', 'Karnataka'))

SQL> update table(select caddress from customer where cid=1902)set ccity='Mangalore' where cstate='Karnataka';
1 row updated.

SQL> select * from customer;

CID    CNAME      CADDRESS(CCITY, CSTATE)
---    -----      -----------------------
1901   Bibhu       CUST_ADDR(NEST_TB('SR Nagar', 'Telengana'))
1902   Ganesh     CUST_ADDR(NEST_TB('Bhubaneswar', 'Odisha'), NEST_TB('Mangalore', 'Karnataka'))


SQL> delete from table(select caddress from customer where cid=1902)where cstate='Odisha';
1 row deleted.

SQL> select * from customer;

CID   CNAME       CADDRESS(CCITY, CSTATE)
---   -----       ----------------------- 
1901  Bibhu       CUST_ADDR(NEST_TB('SR Nagar', 'Telengana'))
1902  Ganesh      CUST_ADDR(NEST_TB('Mangalore', 'Karnataka'))

SQL> insert into table(select caddress from customer where cid=1901)values('Cuttack','Odisha');
1 row created.

SQL> select * from customer;

CID  CNAME     CADDRESS(CCITY, CSTATE)
---  -----     -----------------------
1901 Bibhu     CUST_ADDR(NEST_TB('SR Nagar', 'Telengana'), NEST_TB('Cuttack', 'Odisha'))
1902 Ganesh    CUST_ADDR(NEST_TB('Mangalore', 'Karnataka'))


SQL> desc user_types;
 Name                                                                                                              Null?    Type
 ----------------------------------------------------------------------------------------------------------------- -------- ----------------------------------------------------------------------------
 TYPE_NAME                                                                                                         NOT NULL VARCHAR2(128)
 TYPE_OID                                                                                                          NOT NULL RAW(16)
 TYPECODE                                                                                                                   VARCHAR2(128)
 ATTRIBUTES                                                                                                                 NUMBER
 METHODS                                                                                                                    NUMBER
 PREDEFINED                                                                                                                 VARCHAR2(3)
 INCOMPLETE                                                                                                                 VARCHAR2(3)
 FINAL                                                                                                                      VARCHAR2(3)
 INSTANTIABLE                                                                                                               VARCHAR2(3)
 PERSISTABLE                                                                                                                VARCHAR2(3)
 SUPERTYPE_OWNER                                                                                                            VARCHAR2(128)
 SUPERTYPE_NAME                                                                                                             VARCHAR2(128)
 LOCAL_ATTRIBUTES                                                                                                           NUMBER
 LOCAL_METHODS                                                                                                              NUMBER
 TYPEID                                                                                                                     RAW(16)

SQL> select type_name from user_types;

TYPE_NAME
---------
COURSE_DETAILS
MOBNOLIST
CUST_ADDR
NEST_TB

SQL> drop type course_details;
drop type course_details
*
ERROR at line 1:
ORA-02303: cannot drop or replace a type with type or table dependents

SQL> drop type course_details force;
Type dropped.

SQL>  select type_name from user_types;

TYPE_NAME
---------
MOBNOLIST
CUST_ADDR
NEST_TB
*/


===================================================================================================================================

                                                    ** PL/SQL TUTORIAL **
                                                       ~~~~~~~~~~~~~~~~
SQL> BEGIN
  2  dbms_output.put_line('Welcome to PL/SQL Tutorial');
  3  END;
  4  /     -- only / symbol is allowed.it is used to execute a PL/SQL Block.
PL/SQL procedure successfully completed.

SQL> set serveroutput on;
SQL> /
Welcome to PL/SQL Tuitorial
PL/SQL procedure successfully completed.

SQL> set serveroutput off

SQL> /
PL/SQL procedure successfully completed.

/*

SQL> DECLARE
  2  X int:=12;   --We have to initialize the variables in execution block.
  3  Y int:=20;
  4  BEGIN
  5  dbms_output.put_line('Value of X:'||X||'& Value of Y:'||Y);
  6  END;
  7  /
Enter value for value: 12
old   5: dbms_output.put_line('Value of X:'||X||'& Value of Y:'||Y);
new   5: dbms_output.put_line('Value of X:'||X||'12 of Y:'||Y);

PL/SQL procedure successfully completed.
*/

SQL>  DECLARE
  2  X int;
  3  Y int;
  4  BEGIN
  5  X:=12;
  6  Y:=20;
  7  dbms_output.put_line('Value of X is '||x||'& Value of Y is '||y);
  8  END;
  9  /
Enter value for value:
old   7: dbms_output.put_line('Value of X is '||x||'and Value of Y is '||y);
new   7: dbms_output.put_line('Value of X is '||x||' and Value of Y is '||y);

PL/SQL procedure successfully completed.

SQL> set serveroutput on;
SQL> /
Enter value for value:
old   7: dbms_output.put_line('Value of X is '||x||'and Value of Y is '||y);  --variable name is not case sensitive.
new   7: dbms_output.put_line('Value of X is '||x||'and Value of Y is '||y);
Value of X is 12 and Value of Y is 20

PL/SQL procedure successfully completed.

/*

SQL>  DECLARE
  2   X int;
  3  Y int;
  4  BEGIN
  5  x:=&x;
  6  y:=&y;
  7   dbms_output.put_line('Value of X is '||x||' and Value of Y is '||y);
  8  END;
  9  /
Enter value for x: 12
old   5: x:=&x;
new   5: x:=12;
Enter value for y: 20
old   6: y:=&y;
new   6: y:=20;
Value of X is 12 and Value of Y is 20

PL/SQL procedure successfully completed.

SQL> set verify off;
SQL> /
Enter value for x: 12
Enter value for y: 34
Value of X is 12 and Value of Y is 34

PL/SQL procedure successfully completed.

SQL> set verify on;
SQL> /
Enter value for x: 122
old   5: x:=&x;
new   5: x:=122;
Enter value for y: 344
old   6: y:=&y;
new   6: y:=344;
Value of X is 122 and Value of Y is 344

PL/SQL procedure successfully completed.
*/


--Sum O f 2 Numbers
===================
DECLARE
  X int;
  Y int;
  Z int;
BEGIN
  X:=12;
  Y:=20;
  Z:=x+y;
 dbms_output.put_line(Z);
END;

set serveroutput on;

--A variable must be declared before used it.
=============================================
DECLARE
  X int:=10;
  Y int:=20;
  Z int:=X+100;
  R int;
BEGIN
  R:=x+y;
 dbms_output.put_line(Z);
END;


DECLARE
  Y int:=20;
  Z int:=X+100;
  X int:=10;
  R int;                    --Error
BEGIN
  R:=x+y;
 dbms_output.put_line(Z);
END;

set serveroutput on;

--multiple variables of same data type cannot be declared in one statement
==========================================================================
DECLARE
  X ,Y, Z int;
  R int;                    --Error
BEGIN
  R:=x+y+z;
 dbms_output.put_line(R);
END;
       
--SELECT INTO STATEMENT
================================================================================
select * from empp;

DECLARE
v_Ename varchar2(20);
v_Sal int;
BEGIN
select ENAME,SAl into v_ename,v_sal from empp where empno=&empno ;
dbms_output.put_line('Employee Name     Employee Salary');
dbms_output.put_line('=============     ===============');
dbms_output.put_line(v_Ename||'              '||v_sal);
END;


DECLARE
v_maxsal int;
BEGIN
select max(sal) into v_maxsal from empp;
dbms_output.put_line('Maximun Salary');
dbms_output.put_line('==============');
dbms_output.put_line(v_maxsal);
END;

DECLARE
v_maxsal varchar2(20);          --Also works fine.
BEGIN
select max(sal) into v_maxsal from empp;
dbms_output.put_line('Maximun Salary');
dbms_output.put_line('==============');
dbms_output.put_line(v_maxsal);
END;

--VARIABLE ATTRIBUTES/ANCHOR NOTATION
================================================================================

--Column level attribute
--------------------------------
DECLARE
v_Ename empp.ename%type;
v_Sal empp.sal%type;
BEGIN
select ENAME,SAl into v_ename,v_sal from empp where empno=&empno;
dbms_output.put_line('Employee Name     Employee Salary');
dbms_output.put_line('=============     ===============');
dbms_output.put_line(v_Ename||'              '||v_sal);
END;

--Row level attribute
----------------------------
DECLARE
aa empp%rowtype;
BEGIN
select ENAME,SAl into aa.ename,aa.sal from empp where empno=&empno;
dbms_output.put_line('Employee Name     Employee Salary');
dbms_output.put_line('=============     ===============');
dbms_output.put_line(aa.ename||'              '||aa.sal);
END;

DECLARE
aa empp%rowtype;
BEGIN
select Ename,sal into aa.ename,aa.sal from empp where empno=&empno;  --Job will not show here.
dbms_output.put_line('Employee Name     Employee Job');
dbms_output.put_line('=============     ===============');
dbms_output.put_line(aa.ename||'              '||aa.job);
END;

DECLARE
aa empp%rowtype;
BEGIN
select * into aa from empp where empno=&empno;  --Job will not show here.
dbms_output.put_line('Employee Name     Employee Job     Employee Salary');
dbms_output.put_line('=============     ============     ===============     ');
dbms_output.put_line(aa.ename||'              '||aa.job||'        '||aa.sal);
END;

DECLARE
aa empp%rowtype;
BEGIN
select * into aa from empp where empno=7839;  --Job will  show here.
dbms_output.put_line('Employee Name     Employee Job     Employee Salary');
dbms_output.put_line('=============     ============     ===============     ');
dbms_output.put_line(aa.ename||'              '||aa.job||'        '||aa.sal);
END;

PL/SQL CURSORS
================================================================================

EXPLICIT CURSOR
================

--Fetch single row using cursor
-------------------------------------------
select * from empp;

DECLARE
Cursor C1 is select ename,sal from empp;
v_Ename varchar2(20);
v_Sal number(10);
BEGIN
Open C1;
Fetch C1 into v_Ename,v_Sal;
dbms_output.put_line(v_Ename||','||v_Sal);
Close C1;
END;


DECLARE
Cursor C1 is select ename,sal from empp;
v_Ename Empp.Ename%type;
v_Sal Empp.Sal%type;
BEGIN
Open C1;
Fetch C1 into v_Ename,v_Sal;
dbms_output.put_line(v_Ename||','||v_Sal);
Close C1;
END;


DECLARE 
Cursor C2 is select * from empp;
v_empno Empp.empno%type;
v_ename Empp.ename%type;
v_job Empp.job%type;
v_mgr Empp.mgr%type;
v_hiredate Empp.hiredate%type;
v_sal Empp.Sal%type;
v_comm Empp.comm%type;
v_deptno Empp.deptno%type;
BEGIN
Open C2;
Fetch C2 into v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno;
dbms_output.put_line(v_empno||','||v_ename||','||v_job||','||v_mgr||','||v_hiredate||','||v_sal||','||v_comm||','||v_deptno);
Close C2;
END;


DECLARE
v_empno Empp.empno%type;
v_ename Empp.ename%type;
v_job Empp.job%type;
v_mgr Empp.mgr%type;
v_hiredate Empp.hiredate%type;
v_sal Empp.Sal%type;
v_comm Empp.comm%type;
v_deptno Empp.deptno%type;
Cursor C2 is select * from empp;
BEGIN
Open C2;
Fetch C2 into v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno;
dbms_output.put_line(v_empno||','||v_ename||','||v_job||','||v_mgr||','||v_hiredate||','||v_sal||','||v_comm||','||v_deptno);
Close C2;
END;

--Fetch Multiple rows using Simple Loop
=======================================
DECLARE
Cursor C1 is select ename,sal from empp;
v_Ename Empp.Ename%type;
v_Sal Empp.Sal%type;
BEGIN
Open C1;
loop
Fetch C1 into v_Ename,v_Sal;
exit when C1%notfound;
dbms_output.put_line(v_Ename||','||v_Sal);
END LOOP;
Close C1;
END;


DECLARE
v_empno Empp.empno%type;
v_ename Empp.ename%type;
v_job Empp.job%type;
v_mgr Empp.mgr%type;
v_hiredate Empp.hiredate%type;
v_sal Empp.Sal%type;
v_comm Empp.comm%type;
v_deptno Empp.deptno%type;
Cursor C2 is select * from empp;
BEGIN
Open C2;
loop
Fetch C2 into v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno;
exit when c2%notfound;
dbms_output.put_line(v_empno||','||v_ename||','||v_job||','||v_mgr||','||v_hiredate||','||v_sal||','||v_comm||','||v_deptno);
END LOOP;
Close C2;
END;

--Fetch Multiple rows using while Loop
======================================
DECLARE Cursor C1 is select ename,sal from empp;
v_Ename Empp.Ename%type;
v_Sal Empp.Sal%type;
BEGIN
Open C1;
Fetch C1 into v_Ename,v_Sal; --fetch only 1st row.
while(c1%found)loop
dbms_output.put_line(v_Ename||','||v_Sal);
Fetch C1 into v_Ename,v_Sal; --fetch upto last row.
END LOOP;
Close C1;
END;


DECLARE
v_empno Empp.empno%type;
v_ename Empp.ename%type;
v_job Empp.job%type;
v_mgr Empp.mgr%type;
v_hiredate Empp.hiredate%type;
v_sal Empp.Sal%type;
v_comm Empp.comm%type;
v_deptno Empp.deptno%type;
Cursor C2 is select * from empp;
BEGIN
Open C2;
Fetch C2 into v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno;
while(c2%found)loop
dbms_output.put_line(v_empno||','||v_ename||','||v_job||','||v_mgr||','||v_hiredate||','||v_sal||','||v_comm||','||v_deptno);
Fetch C2 into v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno;
END LOOP;
Close C2;
END;

--Fetch Multiple rows using for Loop
====================================
DECLARE Cursor C1 is select ename,sal from empp;
BEGIN
for i in c1
LOOP
dbms_output.put_line(i.Ename||','||i.Sal);
END LOOP;
END;

DECLARE Cursor C2 is select * from empp;
BEGIN
for i in c2 loop
dbms_output.put_line(i.empno||','||i.ename||','||i.job||','||i.mgr||','||i.hiredate||','||i.sal||','||i.comm||','||i.deptno);
END LOOP;
END;

--Fetch 5 highest salaries from empp table using cursor
=======================================================
select * from(select * from empp order by sal desc) where rownum<=5;

DECLARE Cursor C1 is select ename,sal from empp order by sal desc;
v_Ename Empp.Ename%type;
v_Sal Empp.Sal%type;
BEGIN
Open C1;
loop
Fetch C1 into v_Ename,v_Sal;
exit when C1%rowcount>5;
dbms_output.put_line(v_Ename||','||v_Sal);
END LOOP;
Close C1;
END;


DECLARE
v_empno Empp.empno%type;
v_ename Empp.ename%type;
v_job Empp.job%type;
v_mgr Empp.mgr%type;
v_hiredate Empp.hiredate%type;
v_sal Empp.Sal%type;
v_comm Empp.comm%type;
v_deptno Empp.deptno%type;
Cursor C2 is select * from empp order by sal desc;
BEGIN
Open C2;
loop
Fetch C2 into v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno;
exit when c2%rowcount>5;
dbms_output.put_line(v_empno||','||v_ename||','||v_job||','||v_mgr||','||v_hiredate||','||v_sal||','||v_comm||','||v_deptno);
END LOOP;
Close C2;
END;

--Fetch even position rows from empp table using cursor
=======================================================
select * from(select rownum r,empp.* from empp)where mod(r,2)=0;

DECLARE Cursor C1 is select ename,sal from empp;
v_Ename Empp.Ename%type;
v_Sal Empp.Sal%type;
BEGIN
Open C1;
loop
Fetch C1 into v_Ename,v_Sal;
exit when C1%notfound;
if mod(c1%rowcount,2)=0 then
dbms_output.put_line(v_Ename||','||v_Sal);
end if;
END LOOP;
Close C1;
END;


DECLARE
v_empno Empp.empno%type;
v_ename Empp.ename%type;
v_job Empp.job%type;
v_mgr Empp.mgr%type;
v_hiredate Empp.hiredate%type;
v_sal Empp.Sal%type;
v_comm Empp.comm%type;
v_deptno Empp.deptno%type;
Cursor C2 is select * from empp;
BEGIN
Open C2;
loop
Fetch C2 into v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno;
exit when c2%notfound;
if mod(c2%rowcount,2)=0 then
dbms_output.put_line(v_empno||','||v_ename||','||v_job||','||v_mgr||','||v_hiredate||','||v_sal||','||v_comm||','||v_deptno);
end if;
END LOOP;
Close C2;
END;

--Fetch 9th position row from empp table using cursor
=====================================================
select * from empp;
select * from empp where rownum<10 minus select * from empp where rownum<9;

DECLARE Cursor C1 is select ename,sal from empp;
v_Ename Empp.Ename%type;
v_Sal Empp.Sal%type;
BEGIN
Open C1;
loop
Fetch C1 into v_Ename,v_Sal;
exit when C1%notfound;
if c1%rowcount=9 then
dbms_output.put_line(v_Ename||','||v_Sal);
end if;
END LOOP;
Close C1;
END;


DECLARE
v_empno Empp.empno%type;
v_ename Empp.ename%type;
v_job Empp.job%type;
v_mgr Empp.mgr%type;
v_hiredate Empp.hiredate%type;
v_sal Empp.Sal%type;
v_comm Empp.comm%type;
v_deptno Empp.deptno%type;
Cursor C2 is select * from empp;
BEGIN
Open C2;
loop
Fetch C2 into v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno;
exit when c2%notfound;
if c2%rowcount=9 then
dbms_output.put_line(v_empno||','||v_ename||','||v_job||','||v_mgr||','||v_hiredate||','||v_sal||','||v_comm||','||v_deptno);
end if;
END LOOP;
Close C2;
END;

--Parameterized Cursor
======================

--Fetch Employee details based on given deptno
------------------------------------------------------------------
DECLARE Cursor C1(p_deptno number) is select ename,sal from empp where deptno=p_deptno;
v_Ename Empp.Ename%type;
v_Sal Empp.Sal%type;
BEGIN
Open C1(&p_deptno);
loop
Fetch C1 into v_Ename,v_Sal;
exit when C1%notfound;
dbms_output.put_line(v_Ename||','||v_Sal);
END LOOP;
Close C1;
END;


DECLARE
v_empno Empp.empno%type;
v_ename Empp.ename%type;
v_job Empp.job%type;
v_mgr Empp.mgr%type;
v_hiredate Empp.hiredate%type;
v_sal Empp.Sal%type;
v_comm Empp.comm%type;
v_deptno Empp.deptno%type;
Cursor C2(p_deptno number) is select * from empp where deptno=p_deptno;
BEGIN
Open C2(&p_deptno);
loop
Fetch C2 into v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno;
exit when c2%notfound;
dbms_output.put_line(v_empno||','||v_ename||','||v_job||','||v_mgr||','||v_hiredate||','||v_sal||','||v_comm||','||v_deptno);
END LOOP;
Close C2;
END;

--Accept empno as parameter and check whether the corresponding data exists in the table or not
----------------------------------------------------------------------------------------------------------------------------------------
DECLARE Cursor C1(p_empno number) is select ename,sal from empp where empno=p_empno;
v_Ename Empp.Ename%type;
v_Sal Empp.Sal%type;
BEGIN
Open C1(&p_empno);
Fetch C1 into v_Ename,v_Sal;
if(c1%found) then
dbms_output.put_line('Employee Exists.Employee Details:'||v_Ename||','||v_Sal);
else
dbms_output.put_line('Employee does not exist');
end if;
Close C1;
END;


DECLARE
v_empno Empp.empno%type;
v_ename Empp.ename%type;
v_job Empp.job%type;
v_mgr Empp.mgr%type;
v_hiredate Empp.hiredate%type;
v_sal Empp.Sal%type;
v_comm Empp.comm%type;
v_deptno Empp.deptno%type;
Cursor C2(p_empno number) is select * from empp where empno=p_empno;
BEGIN
Open C2(&p_empno);
Fetch C2 into v_empno,v_ename,v_job,v_mgr,v_hiredate,v_sal,v_comm,v_deptno;
if(c2%found) then
dbms_output.put_line('Employee Exists.Employee Details:'||v_empno||','||v_ename||','||v_job||','||v_mgr||','||v_hiredate||','||v_sal||','||v_comm||','||v_deptno);
else
dbms_output.put_line('Employee does not exist');
end if;
Close C2;
END;

IMPLICIT CURSOR
==============
create table empp3 as select * from empp;
select * from empp3;

DECLARE 
v_empno empp3.empno%type;
BEGIN
v_empno:=&v_empno;
Delete from empp3 where empno=v_empno;
if sql%found then
dbms_output.put_line('Employee Record is Deleted Successfully');
else
dbms_output.put_line('Employee Record is Not Found');
end if;
end;


DECLARE 
v_empno empp3.empno%type;
BEGIN
v_empno:=&v_empno;
update empp3 set deptno=40 where empno=v_empno;
if sql%found then
dbms_output.put_line('Employee Record is Updated Successfully');
else
dbms_output.put_line('Employee Record is Not Found');
end if;
end;

DECLARE 
v_deptno empp3.deptno%type;
BEGIN
v_deptno:=&v_deptno;
update empp3 set sal=4000 where deptno=v_deptno;
if sql%found then
dbms_output.put_line(sql%rowcount||' Employee Record is Updated Successfully');
else
dbms_output.put_line('Employee Record is Not Found');
end if;
end;


DECLARE
v_empno Empp3.empno%type;
v_ename Empp3.ename%type;
v_job Empp3.job%type;
v_mgr Empp3.mgr%type;
v_hiredate Empp3.hiredate%type;
v_sal Empp3.Sal%type;
v_comm Empp3.comm%type;
v_deptno Empp3.deptno%type;
BEGIN
insert into empp3 values(&v_empno,'&v_ename','&v_job',&v_mgr,'&v_hiredate',&v_sal,&v_comm,&v_deptno);
if(sql%found) then
dbms_output.put_line('Employee Record is Inserted Successfully');
else
dbms_output.put_line('Invalid Records');
end if;
END;

--Reference Cursor
==================

--Weak Reference Cursor
-----------------------------------
DECLARE
wc1 sys_refcursor;
i empp%rowtype;
BEGIN
open wc1 for select * from empp where deptno=10;
loop 
fetch wc1 into i;
exit when wc1%notfound;
dbms_output.put_line(i.Ename||','||i.job||','||i.sal);
end loop;
close wc1;
end;


DECLARE
wc1 sys_refcursor;
i empp%rowtype;
aa number(10);
BEGIN
open wc1 for select * from empp where deptno=20;
loop 
fetch wc1 into i;
exit when wc1%notfound;
aa:=wc1%rowcount;
dbms_output.put_line(i.Ename||','||i.job||','||i.sal);
end loop;
dbms_output.put_line('No of Records Fetched:'||aa);
close wc1;
end;


--Strong Reference Cursor
------------------------------------
DECLARE
type st_refcur is ref cursor return empp%rowtype;
sc1 st_refcur;
i empp%rowtype;
BEGIN
open sc1 for select * from empp where deptno=10;
loop 
fetch sc1 into i;
exit when sc1%notfound;
dbms_output.put_line(i.Ename||','||i.job||','||i.sal);
end loop;
close sc1;
end;

--Fetching Rows from multiple table using weak reference cursor
------------------------------------------------------------------------------------------
select * from empp;
select * from dept;

DECLARE 
wc2 sys_refcursor;
i empp%rowtype;
j dept%rowtype;
v_deptno number(10):=&v_deptno;
BEGIN
if v_deptno=10 then
open wc2 for select * from empp where deptno=10;
loop
fetch wc2 into i;
exit when wc2%notfound;
dbms_output.put_line(i.ename||','||i.sal||','||i.deptno);
end loop;
elsif v_deptno=20 then
open wc2 for select * from dept where deptno=20;
loop
fetch wc2 into j;
exit when wc2%notfound;
dbms_output.put_line(j.dname||','||j.loc||','||j.deptno);
end loop;
close wc2;
end if;
end;


--Fetching Rows from multiple table using strong reference cursor is not possible
----------------------------------------------------------------------------------------------------------------
DECLARE 
type st_refcur is ref cursor return empp%rowtype;
sc2 st_refcur;
i empp%rowtype;
j dept%rowtype;
v_deptno number(10):=&v_deptno;
BEGIN
if v_deptno=10 then
open sc2 for select * from empp where deptno=10;            -- Error
loop
fetch sc2 into i;
exit when wc2%notfound;
dbms_output.put_line(i.ename||','||i.sal||','||i.deptno);
end loop;
elsif v_deptno=20 then
open sc2 for select * from dept where deptno=20;
loop
fetch sc2 into j;
exit when sc2%notfound;
dbms_output.put_line(j.dname||','||j.loc||','||j.deptno);
end loop;
close sc2;
end if;
end;


PL/SQL EXCEPTIONS
================================================================================

--System Defined Exception
=====================

--No_Data_Found
~~~~~~~~~~~
select * from Empp;

DECLARE
v_Ename varchar2(20);
v_Sal int;
BEGIN
select ENAME,SAl into v_ename,v_sal from empp where empno=&empno;
dbms_output.put_line('Employee Name     Employee Salary');
dbms_output.put_line('=============     ===============');
dbms_output.put_line(v_Ename||'              '||v_sal);
END;


DECLARE
v_Ename varchar2(20);
v_Sal int;
BEGIN
select ENAME,SAl into v_ename,v_sal from empp where empno=&empno;
dbms_output.put_line('Employee Name     Employee Salary');
dbms_output.put_line('=============     ===============');
dbms_output.put_line(v_Ename||'              '||v_sal);
Exception
When no_data_found then
dbms_output.put_line('Data Does not Exist');
END;

--Too Many Values
~~~~~~~~~~~~
create table c1(cid int,cname varchar2(20));
insert into c1 values(11,'Java Full Stack');
create table c2(cid int,cname varchar2(20));
insert into c2 values(100,'WebDev');
insert into c2 values(300,'DevOps');
insert into c2 values(500,'AWS');

DECLARE
v_cid c1.cid%type;
v_cname c1.cname%type;
BEGIN
Select cid,cname into v_cid,v_cname from c1;
dbms_output.put_line(v_cid||','||v_cname);
end;

DECLARE
v_cid c2.cid%type;
v_cname c2.cname%type;
BEGIN
Select cid,cname into v_cid,v_cname from c2;
dbms_output.put_line(v_cid||','||v_cname);
EXCEPTION
when too_many_rows then
dbms_output.put_line('Retrieval of Too Many Values Are not Possible');
end;

--Zero Divide
~~~~~~~~~~~~~
DECLARE
X number:=&x;
Y Number:=&y;
Z Number;
BEGIN
z:=x/y;
dbms_output.put_line(z);
EXCEPTION 
when zero_divide then
dbms_output.put_line('Second Value Cannot be Zero');
END;

--Invalid Cursor
~~~~~~~~~~
DECLARE
Cursor cc is select ename,sal from empp;
v_ename empp.ename%type;
v_sal empp.sal%type;
BEGIN
Fetch cc into v_ename,v_sal;
dbms_output.put_line(v_ename||','||v_sal);
close cc;
EXCEPTION
when invalid_cursor then
dbms_output.put_line('First You must have to open the cursor before performing any operations on that cursor');
end;


DECLARE
Cursor cc is select ename,sal from empp;
v_ename empp.ename%type;
v_sal empp.sal%type;
BEGIN
loop
Fetch cc into v_ename,v_sal;
exit when cc%notfound ;
dbms_output.put_line(v_ename||','||v_sal);
end loop;
close cc;
EXCEPTION
when invalid_cursor then
dbms_output.put_line('First You must have to open the cursor before performing any operations on that cursor');
end;

--Cursor Already Open
~~~~~~~~~~~~~~~~~~~~~
DECLARE
Cursor cc is select ename,sal from empp;
v_ename empp.ename%type;
v_sal empp.sal%type;
BEGIN
loop
open cc;
Fetch cc into v_ename,v_sal;
exit when cc%notfound ;
dbms_output.put_line(v_ename||','||v_sal);
end loop;
open cc;
EXCEPTION
when cursor_already_open then
dbms_output.put_line('You must have to close the cursor before reopening it.');
end;

--Matching Exception
~~~~~~~~~~~~~
DECLARE
Cursor cc is select ename,sal from empp;
v_ename empp.ename%type;
v_sal empp.sal%type;
BEGIN
loop
open cc;
Fetch cc into v_ename,v_sal;
exit when cc%notfound ;
dbms_output.put_line(v_ename||','||v_sal);
end loop;
open cc;
EXCEPTION
when invalid_cursor then
dbms_output.put_line('First You must have to open the cursor before performing any operations on that cursor');
when others then
dbms_output.put_line('You must have to close the cursor before reopening it.');
end;

--SQLCODE & SQLERRM
~~~~~~~~~~~~~~~~~~~
DECLARE
X number:=&x;
Y Number:=&y;
Z Number;
BEGIN
z:=x/y;
dbms_output.put_line(z);
EXCEPTION 
when others then
dbms_output.put_line(SQLCODE||'          '||SQLERRM);
END;


--User Defined Exception
======================================

--Raise
~~~~~
Declare
x number:=&x;
y number:=&y;
z number;
EX Exception;
BEGIN
if y=0 then
Raise EX;
else
z:=x/y;
dbms_output.put_line('Addition Result:'||z);
end if;
EXCEPTION
when Ex then
dbms_output.put_line('Second Value cannot be Zero');
END;


--Raise Application Error
~~~~~~~~~~~~~~~~
Declare
x number:=&x;
y number:=&y;
z number;
EX Exception;
BEGIN
if y=0 then
raise ex;
else
z:=x/y;
dbms_output.put_line('Addition Result:'||z);
end if;
EXCEPTION
when ex then
Raise_Application_Error(-20059,'Division by Zero Error Occurs');
END;

--Matching Exception
====================
DECLARE
v_empno number:=&v_empno;
v_Ename varchar2(20);
v_Sal int;
Ex Exception;
BEGIN
if v_empno<=0 then
raise Ex;
else
select ENAME,SAl into v_ename,v_sal from empp where empno=v_empno;
dbms_output.put_line('Employee Name     Employee Salary');
dbms_output.put_line('=============     ===============');
dbms_output.put_line(v_Ename||'              '||v_sal);
end if;
Exception
when Ex then
dbms_output.put_line('Empno must be greater than or equal to Zero');
When no_data_found then
dbms_output.put_line('Data Does not Exist');
when others then
dbms_output.put_line('Error !!!');
END;

--Error Propagation
===================
Declare
str varchar2(3):='Bibhu';    --Exception has occured in declaration block.
BEGIN
dbms_output.put_line('Your Name is:'||str);
EXCEPTION
when value_error then
dbms_output.put_line('String length is Greater than the Variable Size');
END;


Declare
str varchar2(3);
BEGIN
str:='Bibhu';                                 --In this case exception has occured in execution block but not in declaration block.
dbms_output.put_line('Your Name is:'||str);   --In this case Exception is handled by inner block
EXCEPTION
when value_error then
dbms_output.put_line('String length is Greater than the Variable Size');
END;


BEGIN 
Declare                                                                                        
str varchar2(3):='Bibhu';                                                           (In this case Exception is handled by Outer block)
BEGIN 
dbms_output.put_line('Your Name is:'||str);              
EXCEPTION                                           
when value_error then                                       (Inner Block)  | (Outer Block)
dbms_output.put_line('Error Occurs in Declaration Block');                
END;                                                 
EXCEPTION                                                                    
when value_error then                                                        
dbms_output.put_line('String length is Greater than the Variable Size');      
END; 

 
--UnNamed Exception
===================
DECLARE
X Exception;
Pragma Exception_init(X,-2291);
BEGIN
Insert into empp3(empno,ename,sal,deptno) values(1122,'Kamal',7890,50);
EXCEPTION
when x then
dbms_output.put_line('Not Allowed into Emp Table Bacause Parent key Not Found');  
END;


DECLARE
X Exception;
Pragma Exception_init(X,-2291);
BEGIN
Insert into empp3(empno,ename,sal,deptno) values(1122,'Kamal',7890,50);
raise X;
EXCEPTION
when x then
dbms_output.put_line('Not Allowed into Emp Table Bacause Parent key Not Found');  
END;

select * from empp3;

ORACLE SUB BLOCKS
================================================================================

A) STORED PROCEDURE
   ==================
1)
create procedure proc1 as
BEGIN
dbms_output.put_line('Welcome to Stored Procedures');
END;

execute proc1;
exec proc1;

Begin
proc1;
END;

2)
create or replace procedure proc2 is
a number:=10;
b number:=20;
BEGIN
dbms_output.put_line('Addition Result:'||(a+b));
END;

exec proc2;

3)
create or replace procedure proc3 is
a number:=&a;
b number:=&b;
BEGIN
dbms_output.put_line('Addition Result:'||(a+b));
END;

exec proc3;

4)
create or replace procedure proc4(a number,b number) is
BEGIN
dbms_output.put_line('Addition Result:'||(a+b));
END;

exec proc4(10,30);
exec proc4(&a,&b);

--Show All Procedures
=====================
select count(*) from all_procedures;--same --stores all predefined procedures.
select count(*) from dba_procedures;--same

select * from user_procedures;
SELECT OBJECT_NAME FROM USER_PROCEDURES;

desc user_objects; --stores all object information like procedure,function,package & trigger.
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='PROCEDURE'; 

desc user_source;
SELECT TEXT FROM USER_SOURCE WHERE NAME='PROC1';

5)
select * from empp;

create procedure proc5(v_empno in number)
is
v_ename empp.ename%type;
v_sal empp.sal%type;
BEGIN
select ename,sal into v_ename,v_sal from empp where empno=v_empno;
dbms_output.put_line(v_ename||','||v_sal);
EXCEPTION
when no_data_found then
dbms_output.put_line('Employee Data Does not Exist.');
END proc5;

exec proc5(&v_empno);

drop procedure proc5;

--Ex Of In Parameter
====================
6)
create or replace procedure proc6(a in number,b in number) is
BEGIN
dbms_output.put_line('Addition Result:'||(a+b));
END;

exec proc6(10,30);
exec proc6(&a,&b);

--Ex Of Out Parameter
====================
7)
create procedure proc7(a in number,b in number,c out number)
as
BEGIN
c:=a+b;
END;

var cc number;
exec proc7(&a,&b,:cc);
print :cc;

var cc2 number;
exec proc7(400,200,:cc2);
print :cc2;

DECLARE
cc3 number;
BEGIN
proc7(&a,&b,cc3);
dbms_output.put_line('Addition Result:'||cc3);
END;


8)
create procedure proc8(a in number,b in number,c out number,d out number)
as
BEGIN
c:=a+b;
d:=a*b;
END;

var sum number;
var mul number;
exec proc8(&a,&b,:sum,:mul);
print :sum :mul;

DECLARE
ss number;
mm number;
BEGIN
proc8(&a,&b,ss,mm);
dbms_output.put_line('Addition Result:'||ss);
dbms_output.put_line('Multiplication Result:'||mm);
END;

--Create a stored procedure to input empno as a 'in' parameter and return that employee provident fund & professional tax
--at 5%,10% based on the employee basic salary by using'out' parameters =================================================
========================================================================
9)
create procedure proc9(v_empno in number,pf out number,pt out number)
as
v_sal number;
BEGIN
select sal into v_sal from empp where empno=v_empno;
pf:=(v_sal*0.05);
pt:=(v_sal*0.1);
END proc9;

var pp number;
var pp2 number;
exec proc9(&v_empno,:pp,:pp2);

print :pp :pp2;

DECLARE
ss number;
mm number;
BEGIN
proc9(&v_empno,ss,mm);
dbms_output.put_line('Provident Fund Result:'||ss);
dbms_output.put_line('Professional Tax Result:'||mm);
END;

--Ex Of In Out Parameter
========================
10)
create procedure proc10(x in out number)
as
BEGIN
x:=x*x*x;
END Proc10;

var res number;
exec :res :=15;
exec proc10(:res);
print :res;

--Write a procedure to accept Employee Number and display Corresponding Employee Net Salary.
11)
create procedure proc_emp(Tempno empp.empno%type)
as
Tcomm empp.comm%type;
Tsal empp.sal%type;
NetSal number;
Ex Exception;
BEGIN
select comm,sal into Tcomm,Tsal from empp where empno=Tempno;
if Tcomm is null then
raise Ex;
else
NetSal:=Tcomm+Tsal;
dbms_output.put_line('Net Salary:'||NetSal);
End if;
EXCEPTION
when Ex then
   Raise_Application_error(-20001,'Given Employee is Not getting Any Commission.');
when no_data_found then
   Raise_application_error(-20002, 'Such Employee Number is Not Exist.');
END proc_emp;

exec proc_emp(&Tempno);

12)
create procedure proc12(age in number)
as
BEGIN
if age>=18 then
dbms_output.put_line('You are Eligible for Voting');
else
dbms_output.put_line('You are not Eligible for Voting');
end if;
end proc12;

exec proc12(&age);

--Drop a Procedure
==================
drop procedure proc1;
select object_name from user_procedures;


B) STORED FUNCTIONS
   =============================================================================
1)
create function fun1
return number
as
total number;
BEGIN
select count(*) into total from empp;
return total;
end;

select fun1() from dual;

DECLARE 
tt number;
BEGIN
tt:=fun1();
dbms_output.put_line('Total No Of Records:'||tt);
END;

SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='FUNCTION';
SELECT TEXT FROM USER_SOURCE WHERE NAME='FUN1';

2)
--Create a sf to input department name and return sum of salary of department ?
----------------------------------------------------------------------------------------------------------------
create function fun2(v_dname in varchar2)
return number 
as 
sum_sal number;
BEGIN
select sum(sal) into sum_sal from empp e,dept d where e.deptno=d.deptno and dname=v_dname;
return sum_sal;
END;

select fun2('&v_dname')from dual;

select * from dept;

DECLARE
op number;
BEGIN
op:=fun2('&v_dname');
dbms_output.put_line('Total Salary:'||op);
END;


create function fun22(v_deptno in number)
return number as 
sum_sal number;
BEGIN
select sum(sal) into sum_sal from empp where deptno=v_deptno group by deptno;
return sum_sal;
END;

select fun22(&v_deptno)from dual;

--Create a sf to return no.of employee in between given dates?
-------------------------------------------------------------------------------------
3)
create function fun3(sd in date,ed in date)
return number
as
tt number;
BEGIN
select count(*) into tt from empp where hiredate between sd and ed;
return tt;
end;

select fun3('&sd','&ed') from dual;
select * from empp;

--Create a sf to input empno and return that emp salary.
-----------------------------------------------------------------------------
4)
create function fun4(v_empno number) 
return number as
v_sal number;
BEGIN
select sal into v_sal from empp where empno=v_empno;
return v_sal;
end;

select fun4(&v_empno) from dual;

--Create a sf to input employee number and return that employee gross salary as per given conditions are
	i) hra -------- 10%||===============================================================================
	ii) da -------- 20%||
	iii) pf --------10%||
========================= 
5)
create Function fun5(v_empno number)
return number
as
v_sal number;
v_hra number(10,2);
v_da number(10,2);
v_pf number(10,2);
GrossSal number(10);
BEGIN
select sal into v_sal from empp where empno=v_empno;
v_hra:=v_sal*0.1;
v_da:=v_sal*0.2;
v_pf:=v_sal*0.1;
GrossSal:=v_hra+v_da+v_pf;
return GrossSal;
end fun5;

select fun5(&v_empno) from dual;

--Write a function to find simple interest
-------------------------------------------------------
6)
create function fun6(p in number,t in number,r in number)
return number as
SI number;
BEGIN
SI:=(p*t*r)/100;
return SI;
END;

select fun6(&p,&t,&r) from dual;

DECLARE 
SI number;
BEGIN
SI:=fun6(&p,&t,&r);
dbms_output.put_line('Simple Intrest:'||SI);
END;

--Create a sf to find experience of given employee 
--------------------------------------------------------------------
7)
create function fun7(v_empno number)
return varchar2
as
v_hiredate date;
exp number;
BEGIN
select hiredate into v_hiredate from empp where empno=v_empno;
exp:=round((sysdate-v_hiredate)/365);
return(v_empno||' Employee Has '||exp||' years of Experience');
EXCEPTION
when no_data_found then
return('Employee Data Does Not Exist');
END;

select fun7(&v_empno) from dual;


C) PACKAGES
    =============================================================================
   
1)
create or replace package pk1
as
num number:=500;
procedure sp1;
function sf1(A Number) return number;
END;

create package body pk1
is
procedure sp1
as
aa number;
BEGIN
aa:=num/100;
dbms_output.put_line('Procedure Execution Result:'||aa);
END sp1;
function sf1(A number) return number
as
BEGIN
return num*A;
END sf1;
END;

execute pk1.sp1;
select pk1.sf1(6) from dual;

--Find No of years of experience of a particular employee using procedure and find the net salary of a particular employee 
--using function----------------------------------------------------------------------------------------------------------------------------------------------------
---------------------|
2)
create package pk2
as
Result Varchar2(50);
procedure Exp(v_empno Empp.empno%type);
function NetSal(v_Empno Empp.empno%type)return varchar2;
END;

create package body pk2 as
procedure Exp(v_empno Empp.empno%type) as
Exper number;
v_hiredate date;
BEGIN
select hiredate into v_hiredate from empp where empno=v_empno;
Exper:=round((sysdate-v_hiredate)/365);
dbms_output.put_line(v_empno||' Employee has '||Exper||' years of Experience');
end exp;
function NetSal(v_Empno Empp.empno%type)return varchar2 as
BEGIN
select sal+nvl(comm,0) into result from empp where empno=v_empno;
return('Employee Number '||v_empno||'s Net Salary is:'||result);
end NetSal;
END;

exec pk2.Exp(&v_empno);
select pk2.NetSal(&v_empno) from dual;

--Function Overloading
======================
3)
create package pk3 as
function ff(a number,b number)return number;
function ff(a number,b number,c number)return number;
function ff(str1 varchar2,str2 varchar2)return varchar2;
function ff(str1 varchar2,str2 varchar2,str3 varchar2)return varchar2;
END;

create package body pk3 as
function ff(a number,b number)return number as
BEGIN
return a+b;
END ff;
function ff(a number,b number,c number)return number as
BEGIN
return a+b+c;
END ff;
function ff(str1 varchar2,str2 varchar2)return varchar2 as
BEGIN
return(str1||' '||str2);
END FF;
function ff(str1 varchar2,str2 varchar2,str3 varchar2)return varchar2 as
BEGIN
return(str1||' '||str2||' '||str3);
END FF;
END;

select pk3.ff(10,30) from dual;
select pk3.ff(10,30,40) from dual;
select pk3.ff('Bibhudatta','Behera') from dual;
select pk3.ff('Nirmal','Kumar','Behera') from dual;

--Drop A Package
================
drop package pk1; --If anyone we will delete then both will be deleted(package specification along with implementation.
drop package body pk1;
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='PACKAGE';


D) TRIGGERS
   =============================================================================
create table Employee10(eid int,ename varchar2(20),esal number(10));
insert into Employee10 values(12,'Bibhu',2000);
insert into Employee10 values(18,'Sameer',3000);
insert into Employee10 values(17,'Kamal',2000);
insert into Employee10 values(14,'Ganesh',5000);

desc user_triggers;
SELECT TRIGGER_NAME FROM USER_TRIGGERS WHERE TABLE_NAME='EMPLOYEE10';--Show all triggers on a particular table
SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='TRIGGER';--Show all triggers

--Statement Level Trigger
-----------------------------------
create trigger trig1 
after update on Employee10
BEGIN
dbms_output.put_line('Hello........');
END;

update Employee10 set esal=1500 where esal=2000;

--Row Level Trigger
---------------------------
drop trigger trig1;

create trigger trig1 
before update on Employee10
for each row
BEGIN
dbms_output.put_line('Hello........');
END;

update Employee10 set esal=1500 where esal=2000;
update Employee10 set esal=6000 where esal=5000;


--2)Create a Statement Trigger To restrict All DML Operations except update on Every Friday
===========================================================================================
create table Employee9 as select * from employee10;
2)
create trigger trig2 
after insert or delete  
on Employee9 
BEGIN
if to_char(sysdate,'DY')='FRI' then
Raise_Application_Error(-20023,'Restricted Insert/Delete Operations on Friday');
end if;
END;

select * from employee9;
insert into Employee9 values(15,'Sangita',9000);
update Employee9 set ename='Kabita' where eid=18;


-- 3)Implement a Trigger that after deleted rows on empp2 table those records will be inserted on backup table
----------------------------------------------------------------------------------------------------------------------------------------------------------
create table backup as select * from empp where 1=2;--If condition id false then only table structure will be copied not all rows.
select * from backup;

create trigger trig3 
after delete on empp2
for each row
BEGIN
insert into backup values(:old.empno,:old.ename,:old.job,:old.mgr,:old.hiredate,:old.sal,:old.comm,:old.deptno);
END;

select * from backup;
delete from empp2 where empno=7788;


-- 4) Implement a trigger using incr table that after insertion of salary into incr table that can be added to empp2 table 
--    if any matching empno found=================================================================
==========================
create table Incr(incr_id int,Amount number(10));

create trigger trig4 
before insert on Incr
for each row
BEGIN
update empp2 set sal=sal+:new.Amount where empno=:new.incr_id;
END;

select * from empp2;
insert into Incr values(2222,8000);
insert into Incr values(1234,8000);


5)
create trigger trig5
before insert on boy
for each row
BEGIN
if :new.bage<=0 then
:new.bage:=10;
end if;
end;

insert into boy values(100,'Roni',-16,'Ganjam');
select * from boy;


6)
create trigger trig6
before insert on DEPT
for each row
BEGIN
:new.dname:=upper(:new.dname);
:new.loc:=initcap(:new.loc);
END;

insert into dept values(50,'manager','londoN');
select * from dept;


7)
select * from employee9;

create trigger trig7 
before update or delete or insert
on employee9
for each row when(new.eid>=0)
DECLARE 
sal_diff number;
BEGIN
sal_diff:=:new.esal-:old.esal;
dbms_output.put_line('Old Salary:'||:old.esal);
dbms_output.put_line('New Salary:'||:new.esal);
dbms_output.put_line('Salary Difference:'||sal_diff);
END;
update employee9 set eid=33 where ename='Bibhu';


DECLARE
n number;
BEGIN
Update Employee9 set esal=esal+8000;
if sql%notfound then
dbms_output.put_line('No such Employee Updated');
elsif sql%found then
n:=sql%rowcount;
dbms_output.put_line(n|| 'Employee Records Updated');
END IF;
END;

select * from employee9;

select name from v$database; --return your database name that you currently connected.

                                               
                                                                **END OF ORACLE COURSE**
                                                            ~~~~~~~~~~~~~~~~~~~~~
                                                              ~~~~~~~~~~~~~~~~~~~
                                                               ~~~~~~~~~~~~~~~~~
                                                                  ~~~~~~~~~~~~~~~
                                                                    ~~~~~~~~~~~~~
                                                                      ~~~~~~~~~~~
                                                                        ~~~~~~~~~
                                                                          ~~~~~~~
                                                                            ~~~~~
                                                                              ~~~
                                                                                 ~
                                                                                           
                                                                 
                                                                                 
                                                                                 
                                                                                 
                                                                                 
                                                                                 
                                                                                
                                                                                
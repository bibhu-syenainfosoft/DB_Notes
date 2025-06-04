create or replace  package SyenaCRUDPack
is
Procedure Insert_Customer(cid in Syena_Employee.ID%type,
                    cname in Syena_Employee.Name%type,
                    csalary in Syena_Employee.Salary%type,
                    cjob_profile in Syena_Employee.Job_Profile%type);
Procedure Update_Customer(cname in Syena_Employee.Name%type,
                    csalary in Syena_Employee.Salary%type,
                    cjob_profile in Syena_Employee.Job_Profile%type,
                    cid in Syena_Employee.ID%type);
Procedure Delete_Customer(  cid in Syena_Employee.ID%type);
Procedure GetCustomerByID(  cid in Syena_Employee.ID%type,
                    cname out Syena_Employee.Name%type,
                    csalary out Syena_Employee.Salary%type,
                    cjob_profile out Syena_Employee.Job_Profile%type);
Procedure GetCustomer(cid out Syena_Employee.ID%type,
                    cname out Syena_Employee.Name%type,
                    csalary out Syena_Employee.Salary%type,
                    cjob_profile out Syena_Employee.Job_Profile%type); 
Procedure TotalCustomer(cid in Syena_Employee.ID%type,tcustomer out number);
End SyenaCRUDPack;

drop package SyenaCRUDPack;
drop package body SyenaCRUDPack;
--==========================================================                    
create or replace package body SyenaCRUDPack
is
Procedure Insert_Customer(cid in Syena_Employee.ID%type,
                    cname in Syena_Employee.Name%type,
                    csalary in Syena_Employee.Salary%type,
                    cjob_profile in Syena_Employee.Job_Profile%type)
is
BEGIN
insert into syena_employee values(cid,cname,csalary,cjob_profile);
           END Insert_Customer;

Procedure Update_Customer(cname in Syena_Employee.Name%type,
                     csalary in Syena_Employee.Salary%type,
                     cjob_profile in Syena_Employee.Job_Profile%type,
                     cid in Syena_Employee.ID%type)
is
BEGIN
update syena_employee set name=cname,salary=csalary,job_profile=cjob_profile where id=cid;
            END Update_Customer;

Procedure Delete_Customer(  cid in Syena_Employee.ID%type)
is  
BEGIN
delete from syena_employee where id=cid;
           END Delete_Customer; 

Procedure GetCustomerByID(  cid in Syena_Employee.ID%type,
                     cname out Syena_Employee.Name%type,
                     csalary out Syena_Employee.Salary%type,
                     cjob_profile out Syena_Employee.Job_Profile%type)
is
BEGIN
select Name,Salary,Job_Profile into cname,csalary,cjob_profile from syena_employee where id=cid;
          END GetCustomerByID;

Procedure GetCustomer(cid out Syena_Employee.ID%type,
                    cname out Syena_Employee.Name%type,
                    csalary out Syena_Employee.Salary%type,
                    cjob_profile out Syena_Employee.Job_Profile%type)
Is
I Syena_Employee%Rowtype;
BEGIN
select id,name,salary,job_profile into cid,cname,csalary,cjob_profile from syena_employee;
         END GetCustomer;
Procedure TotalCustomer(cid in Syena_Employee.ID%type,tcustomer out number)
is 
BEGIN
select count(*) into tcustomer from Syena_Employee where id=cid;
         END  TotalCustomer;
END SyenaCRUDPack;
===============================================================
select * from syena_Employee;






--SQL Developer shut-cut Keys
--===========================
--To Execute current/one line of query(Ctrl+Enter)
--To make the current line comment/to make a line uncommented(Ctrl+/)
--Selecting one line(Shift+down arrow)

--OracleHibernate
------------------------
select * from tab;
create table Employee(IDD integer,NAME2 varchar(20));
create table Employee(id number(10),name varchar2(20),salary number(20));

-------------------------------------------------------------------------------------------------------------------------------------
create table tite(Student_id int,student_name varchar(20),Student_RollNo int,Student_branch varchar(20));
create table tite2(Student_id number(10),student_name varchar2(20),Student_RollNo number(20),Student_branch varchar2(20));
create table tite22 as(select * from tite2);
select * from tite22;
create table customer(cust_id number(10),cust_nm varchar2(20),cust_age number(10));

insert into customer values(11,'Bibhu',23);
insert into customer values(22,'Goutam',24);
insert into customer values (33,'Nirmal',19);
insert into customer values(44,'Jagan',20);

insert into tite22 values(1901,'Raj',299,'CSE');
insert into tite22 values(1902,'Kamal',298,'Mech');
insert into tite22 values (1903,'Ayush',297,'ECE');
insert into tite22 values(1904,'Rahul',296,'CSE');
-- is same as
insert all
into tite22 values(1901,'Raj',299,'CSE')
into tite22 values(1902,'Kamal',298,'Mech')
into tite22 values (1903,'Ayush',297,'ECE')
into tite22 values(1904,'Rahul',296,'CSE')
select * from dual;

insert all
into tite22 values(1905,'Ravi',290,'EE')
into customer(cust_id,cust_nm,cust_age) values(55,'Rohit',29)
select * from dual;

select * from customer cross join tite22;

select * from customer;
select * from tite22;
create table cust_tite22 as(select customer.cust_id as id,customer.cust_nm as Name,customer.cust_age as Age,tite22.student_RollNo as RollNo,tite22.student_branch as Branch from customer,tite22 where customer.cust_id<33 and tite22.student_id< 1903);
select * from cust_tite23;
create table cust_tite23 as(select customer.cust_id as id,customer.cust_nm as Name,customer.cust_age as Age,tite22.student_RollNo as RollNo,tite22.student_branch as Branch from customer,tite22 where customer.cust_id<33);

alter table tite rename to student;
select * from student;
alter table student add abc int;

-- Global Temporary Table
-- ======================
create global temporary table gtt(id numeric(10),name varchar2(20));
-- Local Temporary Table
-- ======================
Declare local temporary table ltt(id numeric(10),name varchar2(20));

select cust_id,cust_nm from customer where cust_id>22;

select * from customer;
select * from tite22;
select distinct * from tite22;

insert into customer(cust_id,cust_nm) select student_id,student_name from tite22 where student_id >1902;
update customer set cust_age=27 where cust_id=1903;
update customer set cust_age=26 where cust_id=1904;
update customer set cust_id=(select student_id from tite22 where student_id=1905) where cust_id=55;
update customer set cust_id=(select student_id from tite22) where cust_id=22; -- will show error because select statement returns multiple records.

delete from customer where cust_id=1905;
truncate table tite22;
select distinct * from tite22 order by student_id;
select distinct * from tite22 order by student_id asc;
select distinct * from tite22 order by student_id desc;

create table product(Item varchar(20),Price number(10),Address varchar2(20));

insert all
into product values('Saree',380,'Puri')
into product values('T-Shirt',300,'Ganjam')
into product values('Saree',450,'Bhadrak')
into product values('Pent',300,'Balasore')
into product values('T-Shirt',270,'Puri')
into product values('Pent',380,'cuttack')
into product values('Saree',600,'Ganjam')
into product values('Trax',380,'Puri')
select * from dual;

select item,sum(price) as Total from product group by item;-- in Oracle it act as a type of case sensitive.
select item,sum(price) as Total from product ;-- Will show error.
select count(price) from product; -- Aggregate functions can execute without group by but group by can not execute without aggregate functions.
select item,address from product group by item;-- will show error.
select item,max(price) as Total from product group by item;
select item,sum(price) as Total from product group by item where sum(price) >300;-- Will show error bcoz where clause can not be used wth aggregate functions.
select item,sum(price) as Total from product group by item Having sum(price) >300;

create table product2(Item varchar(20),Price number(10),Address varchar2(20));

insert all
into product2 values('aa',380,'Puri')
into product2 values('bb',300,'Ganjam')
select * from dual;

create table product3(Item2 varchar(20),Price2 number(10),Address2 varchar2(20));

insert all
into product3 values('mm',380,'Puri')
into product3 values('nn',300,'Ganjam')
select * from dual;

select * from product union select * from product2;
select * from product2 union select * from product3;
select * from product2 union all select * from product3;

insert into product2 values('mm',380,'Puri');
insert into product3 values('aa',380,'Puri');
select * from product2;

select * from product2 intersect select * from product3;
select * from product2 minus select * from product3;
select item,price from product2 minus select * from product3;-- will show error.
select item,price from product2 minus select item2,price2 from product3;
select item2,price2 from product3 minus select item,price from product2;

-- Joins
-- =====

insert all
into stu_info values(11,'Bibhu',2)
into stu_info values(22,'Goutam',5)
into stu_info values(44,'Jagan',2)
into stu_info values(55,'Nirmal',4)
into stu_info values(33,'Satyam',5)

into stu_city values(99,'Ram',2,'Hyderabad')
into stu_city values(96,'Ayush',4,'Bangalore')
into stu_city values(33,'Kamal',2,'Hyderabad')
into stu_city values(97,'Ganesh',5,'Pune')
into stu_city values(55,'Raj',8,'Delhi')
into stu_city values(90,'Kamal',5,'Pune')
select * from dual ;

select * from stu_info;
select * from stu_city;
truncate table stu_city;

select distinct si.id as ID,si.Name,sc.city from stu_info si inner join stu_city sc on si.cid=sc.cid2;

insert into stu_info values(66,'Rahul',9);
insert into stu_info values(77,'Soumya',6);

select distinct si.id as ID,si.Name,sc.city from stu_info si left outer join stu_city sc on si.cid=sc.cid2;
select distinct si.id as ID,si.Name,sc.city from stu_info si right join stu_city sc on si.cid=sc.cid2;
select distinct si.id as ID,si.Name,sc.city from stu_info si full outer join stu_city sc on si.cid=sc.cid2;

select distinct si.id as ID,si.Name,sc.city from stu_info si, stu_city sc where si.cid=sc.cid2 order by id; -- Equi Join
select distinct si.id as ID,si.Name,sc.city from stu_info si join stu_city sc on si.cid=sc.cid2 order by id;-- Equi Join

select * from customer;
select a.cust_id as ID,b.cust_nm as Name,b.cust_age as Age from customer a,customer b where a.cust_age>b.cust_age;--Self Join

select * from customer cross join tite22;
select * from customer,tite22;-- Cross Join

-- ANTI JOIN
-- =========
insert into customer values (1901,'Raj',22);
insert into customer values(1903,'Abhi',29);

insert into tite22 values(11,'Ram',294,'CSE');
insert into tite22 values(33,'HAri',290,'Mech');
select c.cust_id,c.cust_nm from customer c where not exists(select 1 from tite22 where tite22.student_id=c.cust_id) order by c.cust_id;
select * from customer;

--SEMI JOIN
--=========
select c.cust_id,c.cust_nm from customer c where exists(select 1 from tite22 where tite22.student_id=c.cust_id) order by c.cust_id;

--Between
--=======
select * from customer;
select * from customer where cust_age between 20 and 24;

select * from customer where exists(select student_id from tite22 where student_id=1901);
select * from customer where not exists(select student_id from tite22 where student_id=1901);
 
--Change Password
--===============
alter user system identified by Jilucse2002;

--Constraints
--===========
create table employee(eid number(10) not null,enm varchar(20),salary number(10),constraint const unique(eid));

create table chk(id int not null,name2 varchar2(20),age int check(age between 10 and 20));
insert into chk values(201,'Bibhu',16);
insert into chk values(203,'Goutam',21);
create table emp2(Name2 Varchar2(20),salary int,constraint cc check(salary>=10000));
insert into emp2 values('Ramesh',1800);
insert into emp2 values('Ramesh',18000);

create table prime(id int not null,name2 varchar2(20),primary key(id));
create table prime2(id int not null primary key,name2 varchar2(20));
create table prime3(id int not null,name2 varchar2(20),constraint pr primary key(id));
create table prime4(id int not null,name2 varchar2(20));
alter table prime4 add constraint pr2 primary key(id);
alter table prime4 drop constraint pr2;
desc prime4;
alter table prime4 enable constraint pr2 ;
alter table prime4 disable constraint pr2 ;


--Tablespace & DataFile
-----------------------
select tablespace_name from user_tablespaces;
select  tablespace_name,file_name,bytes from dba_data_files;
create tablespace test datafile'C:\Oracle\oradata\ORCL\test11.dbf' size 50m; 
drop tablespace test including contents and datafiles;
drop tablespace test2;
alter tablespace test add datafile'C:\Oracle\oradata\ORCL\orclpdb\test22.dbf' size 40m;
alter tablespace test drop datafile'C:\Oracle\oradata\ORCL\orclpdb\test22.dbf' size 40m;


-- Tablespace,ROle,User
-----------------------
DESC USER_TABLESPACES;
SELECT TABLESPACE_NAME FROM USER_TABLESPACES;
DESC DBA_DATA_FILES;
SELECT TABLESPACE_NAME,FILE_NAME,BYTES FROM DBA_DATA_FILES;

create tablespace Jilu2 datafile'C:\Oracle\oradata\ORCL\orclpdb\jilu1.dbf' size 50m;
create tablespace test datafile'C:\Oracle\oradata\ORCL\test1.dbf' size 50m;

create user c##PQR identified by pqrpwd
default tablespace Jilu2
temporary tablespace Temp
Quota unlimited on Jilu2; 

drop tablespace jilu2;
drop tablespace Jilu2 including contents and datafiles; --same

create tablespace Jilu datafile'C:\Oracle\oradata\ORCL\orclpdb\jilu2.dbf' size 50m;
SELECT TABLESPACE_NAME,FILE_NAME,BYTES FROM DBA_DATA_FILES;

alter tablespace jilu add datafile'C:\Oracle\oradata\ORCL\orclpdb\jilu3.dbf' size 20m;
SELECT TABLESPACE_NAME,FILE_NAME,BYTES FROM DBA_DATA_FILES;

alter tablespace jilu drop datafile'C:\Oracle\oradata\ORCL\orclpdb\jilu3.dbf' size 20m;--error 
alter tablespace jilu drop datafile'C:\Oracle\oradata\ORCL\orclpdb\jilu3.dbf'; --same


--Character Functions
---------------------
select * from tite22;
select upper(student_name) from tite22;
select lower(student_name) from tite22;
select initcap(student_name) from tite22;
select student_id from tite22 where student_name='RAJ';
select student_id from tite22 where initcap(student_name)='raj';
select concat(student_name,student_branch) StuDetails from tite22;
select substr('I am Bibhudatt',2,3) from tite22;
select length('I am Bibhudatt') from tite22;
select student_name from tite22 where length(student_name)=4;
select instr('I am Bibhudatt','am') from tite22;
select lpad('I am Bibhudatt',6) from tite22;
select rpad('I am Bibhudatt',6) from tite22;
select replace('I am Bibhudatt','t') from tite22; 
select trim('   I am Bibhudatt   ') from tite22;

--Number Functions
------------------
select ceil(12.2) from tite22;
select floor(12.9) from tite22;
select round(12.289303,2) from tite22;
select power(5,2) from tite22;
select abs(-2333) from tite22;
select sqrt(9) from tite22;
select mod(5,9) from tite22;
select trunc(12.7292,2) from tite22;

--Conversion Functions
----------------------
create table employee2(emp_name varchar(20),emp_salary int,joining_date date,emp_country varchar(20));
insert into employee2(emp_name,joining_date,emp_country) values('Bibhu',to_date('2022-09-12','YYYY-MM-DD'),'IND');
insert into employee2(emp_name,joining_date,emp_country) values('Avesh',to_date('2021/11/14','YYYY/MM/DD'),'USA');
insert into employee2(emp_name,joining_date,emp_country) values('Bibhu','10-Aug-2010','UAE');

select * from employee2;
select emp_name,NVL(emp_salary,30000) as Emp_Sal from employee2;
select emp_name,Decode(Emp_country,'IND','India','USA','United States Of America','UAE','United Arab Emitares') as Emp_Address from employee2;

--Oracle Sequence
-----------------
create table stud(stu_id int primary key,stud_name varchar(20));
create sequence seq start with 10 increment by 1 maxvalue 20 minvalue 5 cycle cache 4 noorder;
insert into stud values(seq.nextval,'Animesh'); 
select * from stud;
insert into stud values(seq.nextval,'&stud_name');
truncate table stud;
create sequence seq2 start with 10 increment by 1 maxvalue 13 minvalue 8 nocycle cache 4 noorder;
insert into stud values(seq2.nextval,'&stud_name');

--EXECUTE A QUERY WRITTEN IN A NOTEPAD FILE
===========================================
select * from abc;
@'C:\Users\DELL\Desktop\About me some Imp things\DataBases\Oracle\jj.sql';
start 'C:\Users\DELL\Desktop\About me some Imp things\DataBases\Oracle\jj.sql';

@'C:\Users\DELL\Desktop\About me some Imp things\DataBases\Oracle\jilu.txt';

--DEFINE VARIABLE
=================
select * from dept;
define aa=40;
select * from dept where deptno=&aa;
define; --To see all the defined variables.
undefine aa;


================================================================ * =============================================================

                                                 ** PL/SQL TUTORIAL **
                                                    ===============

DECLARE
msg varchar2(20):='Hello Bibhudatt';
BEGIN
dbms_output.put_line(msg );
END;

set Serveroutput on;
 
--USER DEFINED SUBTYPE
----------------------
 DECLARE
 subtype nm is char(20);
 subtype br is varchar2(100);
 name nm;
 branch br;
 BEGIN
 name:='Bibhu';
 branch:='CSE';
 dbms_output.put_line(name||'s Branch is '||branch);
 END;
 
 --PL/SQL Variables
================================================================================
 DECLARE
 a integer:=10;
 b integer:=20;
 c integer;
 f real;
 BEGIN
 c:=a+b;
 dbms_output.put_line('Addition Result='||c);
 f:=100.0/3.0;
  dbms_output.put_line('Multiplication Result='||f);
END;
/

set serveroutput on;

--Variable Scope
----------------
DECLARE 
n1 integer:=10;
n2 integer:=20;
BEGIN
dbms_output.put_line('n3='||n3||' n2='||n2);--will show error.
DECLARE 
n3 integer:=30;
n4 integer:=40;
BEGIN
dbms_output.put_line('n1='||n1||' n4='||n4);
END;
END;

--Variable according to Database Table(Variable Attribute/Anchor Notations)
-----------------------------------------------------------------------------------------------------------

CREATE TABLE CUSTOMERS( ID INT NOT NULL,NAME VARCHAR(20) NOT NULL, AGE INT NOT NULL, 
ADDRESS CHAR (25),SALARY  DECIMAL (18, 2), PRIMARY KEY (ID) ); 

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
VALUES (1, 'Ramesh', 32, 'Ahmedabad', 2000.00 );  

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
VALUES (2, 'Khilan', 25, 'Delhi', 1500.00 );  

INSERT INTO CUSTOMERS (ID,NAME,AGE,ADDRESS,SALARY) 
VALUES (3, 'kaushik', 23, 'Kota', 2000.00 );

DECLARE 
c_id customers.id%type;
c_name customers.name%type;
c_age customers.age%type;
c_add customers.address%type;
c_sal customers.salary%type;
BEGIN
c_id:=&c_id;--used to take input from keyboard.
select id,name,age,address,salary into c_id,c_name,c_age,c_add,c_sal from customers where id=c_id;
dbms_output.put_line('Name:'||c_name||'Age:'||c_age||'Address:'||c_add||'Salary:'||c_sal);
END;


DECLARE    
cust customers.%ROW TYPE;  
BEGIN     
cust.id:= 2092;  
cust.name:= 'Jilu';  
cust.age:= 20;
cust.address:= 'Bhadrak';  
cust.salary:=35000;  
Insert into customers where (id,name,age,address,salary) Values (cust.id,cust.name,cust.age,cust.address,cust.salary);  
dbms_output.put_line('Row Inserted');    
END;  



DECLARE   
   pi constant number := 3.141592654;    
   radius number(5,2);   
   dia number(5,2);   
   circumference number(7, 2);  
   area number (10, 2);  
BEGIN   
   radius := 9.5;   
   dia := radius * 2;   
   circumference := 2.0 * pi * radius;  
   area := pi * radius * radius;   
   dbms_output.put_line('Radius: ' || radius);  
   dbms_output.put_line('Diameter: ' || dia);  
   dbms_output.put_line('Circumference: ' || circumference);  
   dbms_output.put_line('Area: ' || area);  
END;  

--CONTROL STATEMENT
================================================================================

--IF-THEN
---------
DECLARE 
a number(2):=10;
BEGIN
if(a<20)THEN 
dbms_output.put_line(a||' is less than 20');
END IF;
dbms_output.put_line('Value of a='||a);
END;


select * from customers;

DECLARE 
c_id customers.id%type:=2;
c_sal customers.salary%type;
BEGIN 
select id,salary into c_id,c_sal from customers where id=c_id;
if(c_sal<=1600)THEN
Update customers set salary=salary+500 where id=c_id;
dbms_output.put_line('Salary is Updated Successfully');
END IF;
END;

--IF-THEN-ELSE
--------------

DECLARE 
a number(2);
BEGIN
a:=&a;
if(a<20)THEN 
dbms_output.put_line(a||' is less than 20');
ELSE
dbms_output.put_line(a||' is greater than 20');
END IF;
dbms_output.put_line('Value of a= '||a);
END;

select * from customers;

DECLARE 
c_id customers.id%type;
c_sal customers.salary%type;
BEGIN
c_id:=&c_id;
select id,salary into c_id,c_sal from customers where id=c_id;
if(c_sal>=2400)THEN
Update customers set salary=salary+500 where id=c_id;
else
Update customers set salary=salary+200 where id=c_id;
dbms_output.put_line('Salary is Updated Successfully');
END IF;
END;

--IF-THEN-ELSIF-ELSE
-------------------------------

DECLARE 
a number(10);
BEGIN
a:=&a;
if((a>=1) and (a<=30))THEN 
dbms_output.put_line(a||' is in between 1 to 30');
ELSIF((a>=31) and (a<=60))THEN
dbms_output.put_line(a||' is in between 31 to 60');
ELSIF((a>=61) and (a<=100))THEN
dbms_output.put_line(a||' is in between 61 to 100');
ELSE
dbms_output.put_line('None Of The Condition is Matching.');
END IF;
dbms_output.put_line('Value of a= '||a);
END;

--PL/SQL CASE
============
DECLARE
grade char(1):='A';
BEGIN
CASE grade 
when 'O' then dbms_output.put_line('Outstanding');
when 'E' then dbms_output.put_line('Excellent');
when 'A' then dbms_output.put_line('Very Good');
when 'B' then dbms_output.put_line('Good');
when 'C' then dbms_output.put_line('Average');
else dbms_output.put_line('Failed');
END CASE;
End;

--PL/SQL Loops
================================================================================

--1.Exit/Basic Loop
--------------------------
DECLARE 
i number:=1;
BEGIN 
LOOP
EXIT WHEN i>10;
dbms_output.put_line(i);
i:=i+1;
END LOOP;
END;


DECLARE 
var1 NUMBER;
var2 NUMBER;
BEGIN
var1:=100;
var2:=1;
LOOP
dbms_output.put_line(var1*var2);
if(var2=10) THEN
Exit;
END IF;
var2:=var2+1;
END LOOP;
dbms_output.put_line('After Exit Value Of var2 : '||var2);
END;


DECLARE 
var1 NUMBER;
var2 NUMBER;
BEGIN
var1:=100;
var2:=1;
LOOP
dbms_output.put_line(var1*var2);
Exit when var2=10;
                    --If we put the the print statement here then the op goes upto 9 but not upto 10.
var2:=var2+1;
END LOOP;
dbms_output.put_line('After Exit Value Of var2 : '||var2);
END;


--2.While Loop
--------------------
DECLARE 
i number:=1;
BEGIN 
WHILE i<=10 
LOOP
dbms_output.put_line(i);
i:=i+1;
END LOOP;
END;



DECLARE 
i number:=1;
BEGIN 
WHILE(i<=10) LOOP
dbms_output.put_line(i);
i:=i+1;
END LOOP;
dbms_output.put_line('The Value Of i:'||i);
END;


DECLARE 
var1 NUMBER;
var2 NUMBER;
BEGIN
var1:=200;
var2:=1;
WHILE var2<=10
LOOP
dbms_output.put_line(var1*var2);
var2:=var2+1;
END LOOP;
dbms_output.put_line('After Exit Value Of var2 : '||var2);
END;



--3. For Loop
------------------

DECLARE 
k number;
BEGIN 
for k in 1..10
LOOP
dbms_output.put_line(k);
END LOOP;
dbms_output.put_line('After Execution Of Loop'||k);
END;


DECLARE 
var1 NUMBER;
var2 NUMBER;
BEGIN
var1:=200;
For var2 in reverse 1..10
LOOP
dbms_output.put_line(var1*var2);
END LOOP;
dbms_output.put_line('After Exit Value Of var2 : '||var2);
END;


DECLARE 
k number;
BEGIN 
for k in reverse 1..10 LOOP
dbms_output.put_line(k);
END LOOP;
dbms_output.put_line('After Execution Of Loop'||k);
END;


--Nested LOOPS
----------------------

DECLARE 
BEGIN 
for i in 1..10 LOOP
dbms_output.put_line(i);
for j in 1..5 LOOP
dbms_output.put_line(j);
END LOOP;
END LOOP;
END;


DECLARE 
i number:=1;
j number:=1;
BEGIN 
while i<=10 LOOP
dbms_output.put_line(i);
i:=i+1;
while j<=5 LOOP
dbms_output.put_line(j);
j:=j+1;
END LOOP;
END LOOP;
END;


--Continue
---------------

DECLARE 
k number;
BEGIN 
for k in  1..10 LOOP
if k=5 then 
Continue;
End IF;
dbms_output.put_line(k);
END LOOP;
END;

DECLARE 
k number;
BEGIN 
for k in  1..10 LOOP
if mod(k,2)!=0 then 
Continue;
End IF;
dbms_output.put_line(k);
END LOOP;
END;


--GOTO
----------

Declare 
k number:=30;
BEGIN
<<abc>>
while k<=50
LOOP
dbms_output.put_line(k);
k:=k+1;
if k=43 then
k:=k+1;
GOTO abc;
End IF;
END LOOP;
End;


--Pallindrome & Perfect Number
--------------------------------------------
DECLARE 
num number; 
p number;
rev Number:=0;
rem Number;
BEGIN
num:=&num;
p:=num;
while num>0 LOOP
rem:=MOD(num,10);
rev:=rem+rev*10;
num:=trunc(num/10);
END LOOP;
if p=rev then 
dbms_output.put_line(p||' is a Pallindrome Number.');
else
dbms_output.put_line(p||' is not a Pallindrome Number.');
END IF;
END;



DECLARE 
num number;
p number;
sum Number;
i number:=1;
BEGIN
num:=&num;
sum:=0;
while i<num LOOP
if mod(num,i)=0 then 
sum:=sum+i;
end if;
i:=i+1;
End LOOP;
if sum=num then
dbms_output.put_line(p||' is a Perfect Number.');
else
dbms_output.put_line(p||' is not a Perfect Number.');
END IF;
END;

--Oracle Stored Procedure
--===================
create or replace procedure proc1(id in int,name2 in varchar2)
is
begin 
insert into prime values(id,name2);
end;
/

Begin
proc1(101,'Bibhu2');
dbms_output.put_line('Data is Inserted Successfully');
End;
/

select * from prime;

exec proc1(102,'Kamal');
execute proc1(104,'Jilu');

drop procedure proc2;

create  procedure proc2(idd in int,namee in varchar2)
is
begin 
insert into prime2 values(idd,namee);
end;
/

Begin
proc2(102,'Bibhu');
dbms_output.put_line('Data is Inserted Successfully');
End;
/

select * from prime2;

set serveroutput on;

create  procedure proc3(idd in int)
is
begin 
update prime2 set name2='Nirmal' where id=idd;
end;

Begin
proc3(102);
dbms_output.put_line('Row Value is updated Successfully');
end;

select * from prime2;

--Oracle Stored Functions
--=======================
--Ex:1
--------
create function fun1(n1 in number,n2 in number)
return number
is
n3 number(10);
begin
n3:=n1*n2;
return n3;
end;

-- Call the function
-- ----------------------
declare 
nn number(8);
BEGIN
nn:=fun1(10,4);
dbms_output.put_line('Resultant Product Is : '||nn);
end;

select fun1(10,34) Result from dual;

--Ex:2
--------
--Delclare and defining and calling in one example.

Declare 
a number;
b number;
c number;
Function funMax(x in number,y in number)     --In This case This Function Name won't Be Stored In the Database.
return number 
is 
z number;
BEGIN
IF x>y THEN
z:=x;
ELSE
z:=y;
END IF;
return z;
END;

BEGIN        
a:=23;
b:=20;
c:=funMax(a,b);
dbms_output.put_line('Maximum Between 23 and 20 Is : '||c);
END;

SELECT OBJECT_NAME FROM USER_OBJECTS WHERE OBJECT_TYPE='FUNCTION';

--Ex:3
--------

create Function funMax2(x in number,y in number)
return number 
is 
z number;
BEGIN
IF x>y THEN
z:=x;
ELSE
z:=y;
END IF;
return z;
END;

Declare 
a number;
b number;
c number;
BEGIN
a:=23;
b:=20;
c:=funMax2(a,b);
dbms_output.put_line('Maximum Between 23 and 20 Is : '||c);
END;

--Ex:4
--------
select * from customer;

create function fun2
return number is
total number(10):=0;
BEGIN
select count(*) into total from customer;
return total;
END;

DECLARE 
res number(2);
BEGIN
res:=fun2();
dbms_output.put_line('Total No of Record s of Customer Table : '||res);
END;

drop function fun2;

--Recursive Function
-----------------------------
--When a program or subprogram is calls another subprogram i.e when a subprogram calls itself then it is called recursive function. 

DECLARE 
num number;
fact number;
Function factorial(n in number)
return number
IS
f number;
BEGIN 
IF n=0 THEN
f:=1;
ELSE
f:= n*factorial(n-1);
END IF;
return f;
END;

BEGIN
num:=7;
fact:=factorial(num);
dbms_output.put_line('Factorial of '||num||' is '||fact);
END;




-- PLSQL Advanced Concepts
--=====================
# This is my Local Repo


create table dynamicSQL(col1 varchar2(20),col2 number);
insert into dynamicSQL values('abc',78);
insert into dynamicSQL values('def',10);
insert into dynamicSQL values('ghi',99);
select * from dynamicSQL;

create view view1 as select * from dynamicSQL;

create procedure drop_table(tName in varchar2)
is 
BEGIN
execute immediate 'drop table '||tName;
END;
/

execute drop_table('dynamicSQL');

create procedure drop_object(oType in varchar2,oName in varchar2)
is 
BEGIN
execute immediate 'drop '||oType||' '||oName;
END;
/

execute drop_object('view','view1');

DECLARE 
query varchar2(400);
countn number;
BEGIN
query:='select count(*) from dynamicSQL';
Execute Immediate query into countn;
dbms_output.put_line('Total Employees are:'||countn);
END;
/


--Bind Variable 
--=============
-- There are 3 ways to print variables
--1. through DBMS_OUTPUT.PUT_LINE  
--2. through print
--3. through set autoprint on

variable abc number;
exec :abc :=10;

print :abc;

Begin
dbms_output.put_line(:abc);
END;
/

set autoprint on;

DECLARE 
query varchar2(400);
BEGIN
query:='insert into dynamicSQL values(:val1,:val2)';
Execute Immediate query using 'DB',34;
dbms_output.put_line('Data Inserted');
END;
/


--Bulk Collect into 
--=================
create type type1 as object(empno1 number,empno2 number,empno3 number);
create type emp_type is table of type1;
create table employee(ename varchar2(20),esal number,empno emp_type)nested table empno store as emp_bulk;
insert into employee values('Bibhu',23900,emp_type(type1(100,200,300)));
insert into employee values('Sahil',30000,emp_type(type1(10,20,40),type1(1,2,3)));
desc employee;
select * from employee;
drop type emp_type force;
drop table employee;
select type_name from user_types;

create table employees(ename varchar2(20),esal number);
insert into employees values('Bibhu',23000);
insert into employees values('Kamal',3000);
insert into employees values('Ganesh',34500);

create type emp_nos is table of number;
create table employee2(ename varchar2(20),esal number,empno emp_nos)nested table empno store as emp2_bulk;
insert into employee2 values('Bibhu',20900,emp_nos(10,20,30));
insert into employee2 values('Nirmal',29000,emp_nos(100,200,300,400));
insert into employee2 values('Khirod',32000,emp_nos(1,2));
select * from employee2;


DECLARE
cursor exp_cursor is select ename from employee2;
type emp_name is table of varchar2(20);
enm emp_name;
BEGIN
open exp_cursor;
LOOP
fetch exp_cursor bulk collect into enm;
exit when enm.COUNT=0;
for idx in enm.FIRST..enm.LAST
LOOP
dbms_output.put_line(idx||'-'||enm(idx));
END LOOP;
END LOOP;
close exp_cursor;
END;
/


DECLARE
cursor exp_cursor is select ename from employee2;
type emp_name is table of varchar2(20);
enm emp_name;
BEGIN
open exp_cursor;
fetch exp_cursor bulk collect into enm limit 2;
for idx in 1..enm.count
LOOP
dbms_output.put_line(idx||'-'||enm(idx));
END LOOP;
close exp_cursor;
END;
/


--PL/SQL Collections and its Methods
--==================================
create type emp_nos is table of number;
create table employee2(ename varchar2(20),esal number,empno emp_nos)nested table empno store as emp2_bulk;
insert into employee2 values('Bibhu',20900,emp_nos(10,20,30));
insert into employee2 values('Nirmal',29000,emp_nos(100,200,300,400));
insert into employee2 values('Khirod',32000,emp_nos(1,2));
select * from employee2;

DECLARE 
type type2 is table of number index by varchar2(20);
abc type2;
BEGIN
abc('num1'):=100;
abc('num2'):=200;
abc('num3'):=400;
abc('num4'):=300;
dbms_output.put_line(abc('num1'));
END;
/


DECLARE 
type type2 is table of number index by varchar2(20);
abc type2;
i varchar2(20);
BEGIN
abc('num1'):=100;
abc('num2'):=200;
abc('num3'):=400;
abc('num4'):=300;
i:=abc.First;
WHILE i is not null
LOOP
dbms_output.put_line(i||'-'||abc(i));
i:=abc.next(i);
END LOOP;
END;
/


DECLARE 
type type2 is table of number;
abc type2:=type2(10,20,30,40,50,60);
BEGIN
dbms_output.put_line(abc.Count);
END;
/

DECLARE 
type type2 is table of number;
abc type2:=type2(10,20,30,40,50,60);
BEGIN
IF abc.Count>9 then
dbms_output.put_line('The collection contains more than 5 elements');
END IF;
END;
/

DECLARE 
type type2 is table of number;
abc type2:=type2(10,20,30,40,50,60);
BEGIN
For i in 1..abc.COUNT
Loop
dbms_output.put_line(i||'-'||abc(i));
END LOOP;
END;
/

DECLARE 
type type2 is table of number;
abc type2:=type2(10,20,30,40,50,60);
BEGIN
IF abc.EXISTS(8) then 
dbms_output.put_line('The Data is present at index no 2 is:'||abc(2));
ELSE
dbms_output.put_line('The Data does not exist at the particular index');
END IF;
END;
/

DECLARE 
type type2 is table of number;
abc type2:=type2(10,20,30,40,50,60);
BEGIN
dbms_output.put_line('1st:'||abc.FIRST);
dbms_output.put_line('last:'||abc.LAST);
abc.DELETE(1);
abc.TRIM;
dbms_output.put_line('Now 1st:'||abc.FIRST);
dbms_output.put_line('Now last:'||abc.LAST);
END;
/

DECLARE 
type type2 is varray(10) of number;
abc type2:=type2(10,20,30,40,50,60);
BEGIN
dbms_output.put_line('Size:'||abc.LIMIT);
dbms_output.put_line('No of Elements:'||abc.COUNT);
END;
/


DECLARE 
type type2 is varray(10) of number;
abc type2:=type2();
BEGIN
abc.Extend;
abc(1):=22;
dbms_output.put_line('Size:'||abc.LIMIT);
dbms_output.put_line('No of Elements:'||abc.COUNT);
END;
/


DECLARE 
type type2 is table of number;
abc type2:=type2(10,20,30,40,50,60);
BEGIN
dbms_output.put_line('Index before 3rd index is:'||abc.PRIOR(3));
dbms_output.put_line('Value before 3rd index is:'||abc(abc.PRIOR(3)));
abc.DELETE(4);
dbms_output.put_line('Index after 3rd index is:'||abc.NEXT(3));
dbms_output.put_line('Value after 3rd index is:'||abc(abc.NEXT(3)));
END;
/


DECLARE 
type type2 is table of number;
abc type2:=type2(10,20,30,40,50,60);
BEGIN
ABC.DELETE(2);
dbms_output.put_line(abc.COUNT);
dbms_output.put_line(abc(2));
END;
/


DECLARE 
type type2 is table of number;
abc type2:=type2(10,20,30,40,50,60,70,80);
BEGIN
abc.DELETE(3,5);
For i in 1..abc.COUNT
Loop
IF abc.Exists(i) Then 
dbms_output.put_line(i||'-'||abc(i));
END IF;
END LOOP;
dbms_output.put_line(abc.COUNT);
END;
/



DECLARE 
type type2 is table of number;
abc type2:=type2();
BEGIN
abc.Extend;
abc(1):=22;
dbms_output.put_line('Element is:'||abc(1));
abc.Extend(5,1);
dbms_output.put_line('Element is:'||abc(1));
END;
/

DECLARE 
type type2 is table of number;
abc type2:=type2(10,20,30,40,50,60,70,80);
BEGIN
abc.TRIM;
abc.TRIM(3);
For i in 1..abc.COUNT
Loop
dbms_output.put_line(abc(i));
END LOOP;
END;
/

--FORALL Statement
--===============
create table forall1(col11 number);

DECLARE 
type my_array is table of number index by PLS_INTEGER;
var1 my_array;
total number;
BEGIN
FOR i in 1..10
LOOP
var1(i):=9*i;
END LOOP;
FORALL idx IN 1..10
insert into forall1 values(var1(idx));
select count(*) into total from forall1;
dbms_output.put_line( total||' recordes inserted');
END;
/

select * from forall1;
truncate table forall1;

DECLARE 
type type2 is table of number;
abc type2:=type2(10,20,30,40,50,60);
total number;
BEGIN
abc.DELETE(2,3);
FORALL idx IN INDICES OF abc
insert into forall1 values(abc(idx));
select count(*) into total from forall1;
dbms_output.put_line( total||' recordes inserted');
END;
/


DECLARE 
type type2 is table of number;
source_col type2:=type2(10,20,30,40,50,60);
total number;
type type3 is table of PLS_INTEGER index by PLS_INTEGER;
dest_col type3;
BEGIN
dest_col (1):=100;
dest_col (5):=300;
dest_col (10):=450;
FORALL idx IN VALUES OF dest_col
insert into forall1 values(source_col(idx));
select count(*) into total from forall1;
dbms_output.put_line( total||' recordes inserted');
END;
/

DECLARE 
type type2 is table of varchar2(100);
source_col type2;
query varchar2(4000);
BEGIN
query:='select ename from employees';
EXECUTE IMMEDIATE query bulk collect into source_col;
for idx in 1..source_col.COUNT LOOP
dbms_output.put_line(idx||'-'||source_col(idx));
END LOOP;
END ;
/

--Dynamic PL/SQL Block
--==================
DECLARE 
query varchar2(4000);
BEGIN
query:='DECLARE
              usernm varchar2(20);
              BEGIN
              select user into usernm from dual;
              dbms_output.put_line(''Current Username is:''||usernm);
              END;';
EXECUTE IMMEDIATE query;
END;
/

-- Oracle Type Record
--================
--Its like 'struct' concept in c programming

DECLARE 
Type type3 is  RECORD(col1 varchar2(20),col2  number);
var1 type3;
BEGIN
var1.col1:='Bibhu';
var1.col2:=22;
dbms_output.put_line(var1.col1||'  '||var1.col2);
END;
/


DECLARE 
Type type3 is  RECORD(col1 varchar2(20),col2  number);
var1 type3:=type3('Bibhu',23);
BEGIN
dbms_output.put_line(var1.col1||'  '||var1.col2);
END;
/

select * from employees;

DECLARE 
Type emp_recd_type is  RECORD(enm varchar2(20),sal  number);
emp_recd emp_recd_type;
BEGIN
select * into emp_recd from employees where esal=3000 ;
dbms_output.put_line(emp_recd.enm||'  '||emp_recd.sal);
END;
/


DECLARE 
Type emp_recd_type is  RECORD(enm varchar2(20) not null:='abc',sal  number);
emp_recd emp_recd_type;
BEGIN
emp_recd.sal:=100;
dbms_output.put_line(emp_recd.enm||'  '||emp_recd.sal);
END;
/

DECLARE 
Type emp_recd_type is  RECORD(enm emp.ename%type,sal  emp.esal%type);
emp_recd emp_recd_type;
BEGIN
select * into emp_recd from employees where esal=3000 ;
dbms_output.put_line(emp_recd.enm||'  '||emp_recd.sal);
END;
/









                                                         **END OF ORACLE COURSE**
                                                       ~~~~~~~~~~~~~~~~~~~~~
                                                        ~~~~~~~~~~~~~~~~~~~
                                                         ~~~~~~~~~~~~~~~~~~
                                                          ~~~~~~~~~~~~~~~~
                                                           ~~~~~~~~~~~~~~
                                                            ~~~~~~~~~~~~
                                                             ~~~~~~~~~~
                                                              ~~~~~~~~
                                                               ~~~~~~
                                                                ~~~~
                                                                 ~~
                                                                 ~
                                                                 
                                                                 
                                                                 
                                                                 
                                                                 

-- This project consists of a museum database. This database contains several tables such as:
-- sections, employees, role, salary, visitor, ticket, payment. The project also contains a 
-- list of functions applied to the database.

create table Section
(
idSection number(5) primary key,
category varchar2(50),
employeeNumber number(5),
exponateNumber number(5),
idManager number(5),
constraint idManager_fk foreign key(idManager) references Employee(idEmployee),
constraint category_ck check(category in('Nature Science','History','Archeology','Art'))
);

create table Employee
(
idEmployee number(5) primary key,
name varchar2(20),
surname varchar2(20),
sex varchar2(10),
age number(3),
employmentDate date,
email varchar2(20),
phoneNumber varchar2(20),
idBoss number(5),
idRole number(5),
constraint idRole_fk foreign key(idRole) references Role(idRole),
constraint name_nn check(name is not null),
constraint sex_ck check(sex in('feminine','masculine'))
);

create table Role
(
idRole number(5) primary key,
roleName varchar2(20),
constraint roleName_ck check(roleName in('Director','Section Manager','Guide','Caretaker'))
);

create table Salary
(
idSalary number(5) primary key,
grossSalary number(10),
netSalary number(10),
mealVouchers number(5),
idRole number(5),
constraint idRole_fk2 foreign key(idRole) references Role(idRole)
);

create table Visitor
(
idTypeVisitor number(5) primary key,
typeVisitor varchar2(20),
ticketPrice number(3),
constraint typeVisitor_ck check(typeVisitor in('Children','High School','College','Normal','Retired','Disabled'))
);

create table Ticket
(
idTicket number(5) primary key,
visitDate date,
idTypeVisitor number(5),
idTypePayment number(5),
constraint idTypeVisitor_fk foreign key(idTypeVisitor) references Visitor(idTypeVisitor),
constraint idPaymentType_fk foreign key(idTypePayment) references Payment(idTypePayment)
);

create table Payment
(
idTypePayment number(5) primary key,
typePayment varchar2(10),
constraint typePayment_ck check(typePayment in('Cash','Card'))
);

-- Examples of a few functions you can use in this database:

-- Adding a new personal identification number (pin) column in the Employee table:
alter table Employee add pin number(13);
describe Employee;

-- Editing the data type of the pin column from the Employee table:
alter table Employee modify cnp number(20);
describe Employee;

-- Deleting pin column from Employee table:
alter table Employee drop column cnp;
describe Employee;

-- Renaming the name of the Section table to Sections:
alter table Section rename to Sections; 
-- Or: 
rename Section to Sections;
describe Sections;

-- Adding a new constraint to the name column:
alter table Employee add constraint NAME_UQ unique(name);
select * from user_constraints;

-- Disabling the same constraint:
alter table Employee disable constraint NAME_UQ;
select * from user_constraints;

-- Deleting the constraint:
alter table Employee drop constraint NAME_UQ;
select * from user_constraints;

-- Adding data into the Sections table:
insert into Sections values (101, 'Nature Science', 53, 330, 2);
insert into Sections values (102, 'History', 42, 204, 3);
insert into Sections values (103, 'Archeology', 58, 245, 4);
insert into Sections values (104, 'Art', 61, 479, 5);
select * from Sections;

-- Adding data into the Employee table:
insert into Employee values (1, 'Anghel', 'Alexandra','Feminin', 45,
to_date('02.02.2017','dd.mm.yyyy'), 'anghel.alexandra23@gmail.com', '0721.234.545', null, 1);
insert into Employee values (2, 'Barbu', 'Marian','Masculine', 35,
to_date('02.05.2017','dd.mm.yyyy'), 'barbu.marian3@yahoo.com', '0765.551.490', 1, 2);
insert into Employee values (3, 'Dragan', 'Silviu','Masculine', 37,
to_date('05.03.2017','dd.mm.yyyy'), 'dragan.silviu78@hotmail.com', '0758.933.990', 1, 2);
insert into Employee values (4, 'Marinescu', 'Oana','Feminine', 29,
to_date('06.01.2018','dd.mm.yyyy'), 'marinescu.oana20@yahoo.com', '0767.873,890', 1, 2);
insert into Employee values (5, 'Grigore', 'Florin','Masculine', 57,
to_date('06.09.2017','dd.mm.yyyy'), 'grigore.florin98@yahoo.com', '0766.552.611', 1, 2);
select * from Employee;

-- Adding data into the Role table:
insert into Role values (1, 'Director');
insert into Role values (2, 'Section Manager');
insert into Role values (3, 'Guide');
insert into Role values (4, 'Caretaker');
select * from Role;

-- Adding data into the Salary table:
insert into Salary values (1,50000,60000,5000,1);
insert into Salary values (2,40000,50000,4000,2);
insert into Salary values (3,30000,50000,3000,3);
insert into Salary values (4,30000,40000,2000,4);
select * from Salary;

-- Adding data into the Visitor table:
insert into Visitor values (1,'Children',15);
insert into Visitor values (2,'High School',20);
insert into Visitor values (3,'College',30);
insert into Visitor values (4,'Normal',50);
insert into Visitor values (5,'Retired',25);
insert into Visitor values (6,'Disabled',15);
select * from Visitor;

-- Adding data into the Ticket table:
insert into Ticket values (1,to_date('06.09.2017','dd.mm.yyyy'),1,1);
insert into Ticket values (2,to_date('08.11.2017','dd.mm.yyyy'),3,2);
insert into Ticket values (3,to_date('17.10.2017','dd.mm.yyyy'),4,2);
insert into Ticket values (4,to_date('25.12.2017','dd.mm.yyyy'),2,1);
insert into Ticket values (5,to_date('12.06.2017','dd.mm.yyyy'),5,1);
insert into Ticket values (6,to_date('21.03.2017','dd.mm.yyyy'),6,2);
select * from Ticket;

-- Adding data into the Payment table:
insert into Payment values (1,'Cash');
insert into Payment values (2,'Card');
select * from Payment;

-- Update the name of the employee with ID = 1:
update Employee
set name='Chirita'
where idEmployee=1;
select name
from Employee
where idEmployee=1;

-- Deleting the employee with the name 'Grigore':
delete from Employee
where lower(NUME)='grigore';
select * from Employee;

drop table Sections cascade constraints;
flashback table Sections to before drop;

-- Union:
select surname
from Employee
where initcap(surname)='Oana'
union all
select category
from Sections
where lower(category)='Art';

-- Intersect:
select surname, age
from Employee
intersect
select surname, age
from Employee;

-- Subqueries:
update Visitor
set ticketPrice=ticketPrice*0.2
where ticketPrice in (select ticketPrice from Visitor where idTypeVisitor=4);

-- Single-row functions:
select * from Employee
where idEmployee in (select idEmployee from Employee where lower(name)='marinescu');

select idEmployee, name from Employee where name like upper('M%');

-- Group functions:
select MIN(ticketPrice), MAX(ticketPrice) from Visitor;

-- Junctions:
select s.category, s.idManager, a.idEmployee
from Sections s, Employee a
where s.idManager=a.idEmployee
order by NUME asc;

-- View:
create or replace view v_angajat_1
as select * from Employee
where idEmployee=1;
update v_angajat_1
set NUME='Minoiu';
select * from v_angajat_1

-- Index:
select * from Visitor
where ticketPrice between 10 and 50;
create index idx_PRET_BILET on Visitor(ticketPrice);
select * from Employee
where age between 20 and 60;
create index idx_VARSTA on Employee(age);
select * from user_indexes;

-- Synonym:
create synonym s for Sections;
create synonym a for Employee;
select * from user_synonyms;

-- Sequence:
create sequence s_angajat start with 1 increment by 1 maxvalue 100;
insert into Employee values (s_tari.nextval, '&name');
select * from user_sequences;

insert into Employee values (6, 'Pupaza', 'David','Masculine', 20,
to_date('06.01.2023','dd.mm.yyyy'), 'pupazadavid21@stud.ase.ro', '0000.000.000', 1, 4);
select * from Employee where name like upper('P%');

commit;
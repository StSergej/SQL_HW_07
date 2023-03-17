-- В базе данных “MyFunkDB” создать 3 таблицы. 
-- В 1-й содержатся имена и номера телефонов сотрудников некой компании.
-- Во 2-й содержатся данные об их зарплате, и должностях: главный директор, менеджер, рабочий.
-- В 3-й содержатся данные о семейном положении, дате рождения и где они проживают. 

use  MyFunkDB;

create table employees
(
	id_number smallint Not Null,
	full_name varchar(20) Not Null,
    telephone varchar(15) Not Null,
    primary key(id_number)
);

insert into employees(id_number, full_name, telephone)
values (1, 'Сергеев В.С.', '067-608-45-93'),
	   (2, 'Федоров А.Н.', '095-345-12-70'),
	   (3, 'Носов Б.А.', '073-777-45-88');

select * from employees;
------------------------
create table owns_data
(
	talon_number smallint Not Null,
	salary mediumint Not Null,
	position varchar(20) Not Null,
    primary key (talon_number)
);

alter table owns_data
add constraint FK_OwnEmployee
foreign key(talon_number) references employees(id_number);

insert into owns_data(talon_number, salary, position)
values (1, 35000, 'директор'),
	   (2, 22000, 'менеджер'),
	   (3, 20500, 'рабочий');	

select * from owns_data;
---------------------------

create table personals_data
(
	account_number smallint Not Null,
	family_status varchar(10) Not Null,
    birthday date Not Null,
    address varchar(50) Not Null,
    primary key (account_number)
);

alter table personals_data
add constraint FK_PersonEmployee
foreign key(account_number) references employees(id_number);

insert into personals_data(account_number, family_status, birthday, address)
values  (1, 'женат', '1975-03-02', 'Сумы, пр.Шевченко,78'),
		(2, 'женат', '1991-11-14', 'Сумы, ул.Киевская,33'),
		(3, 'холост', '1998-06-28', 'Сумы, ул.Одесская,12');

select * from personals_data;

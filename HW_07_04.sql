-- Создайте функции / процедуры для таких заданий:
-- 1) Требуется узнать контактные данные сотрудников (номера телефонов, место жительства).
-- 2) Требуется узнать информацию о дате рождения всех не женатых сотрудников и номера телефонов этих сотрудников.
-- 3) Требуется узнать информацию о дате рождения всех сотрудников с должностью менеджер и номера телефонов этих сотрудников.

use MyFunkDB;

select * from employees;

select * from owns_data;

select * from personals_data;


-- Требуется узнать контактные данные сотрудников (номера телефонов, место жительства)
DELIMITER /
create procedure getAllEmployees()
begin
    select id_number as id, full_name, telephone, address
		from employees as em
		INNER JOIN personals_data as pers on em.id_number = pers.account_number;
end /

call getAllEmployees(); /

drop procedure getAllEmployees; /
------------------------------------------

-- Требуется узнать информацию о дате рождения всех не женатых сотрудников и номера телефонов этих сотрудников.
create function birth(full_name varchar(20))
returns date
LANGUAGE SQL DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER
begin
	return(select birthday from personals_data
		where  family_status = 'холост');	
end /

drop function birth;/

create procedure private_data()
begin
	select full_name, birth(full_name) as birthday, family_status, telephone
		from employees as em
		INNER JOIN personals_data as pers on em.id_number = pers.account_number
		where birthday = birth(full_name);
end /

call private_data(); /

drop procedure private_data; /
------------------------------------------

-- Требуется узнать информацию о дате рождения всех сотрудников с должностью менеджер и номера телефонов этих сотрудников.
create procedure post()
begin
	select full_name, position, birthday, telephone
		from employees as em
		inner join personals_data as pers on pers.account_number = em.id_number
		inner join owns_data as ow on em.id_number = ow.talon_number
		where position = 'менеджер';
end /
        
call post(); /

drop procedure post; /
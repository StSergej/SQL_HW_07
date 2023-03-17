-- Используя базу данных carsshop создайте функцию для нахождения минимального возраста клиента,
-- затем сделайте выборку всех машин, которые он купил.

drop database carsshop; 

create database carsshop; 

use carsshop; 

create table marks(
   id int not null auto_increment primary key,
   mark varchar(20) unique
);

INSERT into marks(mark) values('Audi');
INSERT into marks(mark) values('BMW'); 
INSERT into marks(mark) values('Porsche');  
INSERT into marks(mark) values('VW');  

select * from marks;
---------------------

create table cars(
  id INT NOT NULL auto_increment primary key,
  mark_id INT NOT NULL,
  model varchar(20) NOT NULL,
  price INT NOT NULL,
  foreign key(mark_id) references marks(id)
);

insert into cars(mark_id, model, price) values (1, 'A5', 50000);
insert into cars(mark_id, model, price) values (2, 'M525', 78000);
insert into cars(mark_id, model, price) values (3, 'Caymen S', 88000);  
insert into cars(mark_id, model, price) values (3, 'Panamera', 100000);  
insert into cars(mark_id, model, price) values (4, 'Jetta', 35000);  

select * from cars;
---------------------

CREATE TABLE clients
(
	 id INT AUTO_INCREMENT NOT NULL,
     name VARCHAR(30),
     age TINYINT,
     phone VARCHAR(15),
     PRIMARY KEY (id)
); 

insert into clients(name, age, phone) 
values 
		('Petrenko Petr Petrovich', '35',  '(093)1231212'), 
		('Ivanenko Ivan Ivanovich', '22',  '(095)2313244'), 
		('Fedorova Anna Sergeevna', '28',  '(067)6457899'), 
		('Skorik Denis Vasiljevich', '53',  '(095)2313244'); 

select * from clients;
----------------------

create table orders(
     id int not null primary key auto_increment,
     client_id int not null,
     car_id int not null,
     foreign key(car_id) references cars(id),
     foreign key(client_id) references clients(id)
); 

insert into orders(client_id, car_id) 
		values(1, 2), (2, 1), (2, 5), (3, 3), (4, 4); 

select * from orders;
------------------------------------------------------

DELIMITER |
-- создайте функцию для нахождения минимального возраста клиента
CREATE FUNCTION minAge(mark VARCHAR(30)) 
RETURNS int
LANGUAGE SQL DETERMINISTIC CONTAINS SQL SQL SECURITY DEFINER
BEGIN
RETURN (SELECT age FROM clients 
        WHERE age = (SELECT min(age) FROM clients));
END|

-- сделайте выборку всех машин, которые он купил
select mark, model, price, name, minAge(mark) as  age 
from cars as c
	   INNER JOIN marks as m ON m.id = c.mark_id
       INNER JOIN orders as o ON c.id = o.car_id
       INNER JOIN clients as cl ON o.client_id = cl.id
	   WHERE age = minAge(mark);|

DROP FUNCTION minAge;|

DELIMITER ;
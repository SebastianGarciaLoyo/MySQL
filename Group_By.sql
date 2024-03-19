-- GROUP BY

drop schema if exists miprimerabasededatos;
create schema if not exists miprimerabasededatos default character set utf8;
show warnings;
use miprimerabasededatos;

drop table if exists coches;

create table if not exists coches(
	id int(11) not null auto_increment,
    marca varchar(45) not null,
    modelo varchar(45) not null,
    kilometros int(11) not null,
    primary key(id)
)
engine = InnoDB
auto_increment = 10
default character set = utf8;



insert into coches(id,marca,modelo,kilometros) values(1,"Renault", "Clio",10);
insert into coches(id,marca,modelo,kilometros) values(2,"Renault", "Megane",23000);
insert into coches(id,marca,modelo,kilometros) values(3,"Seat", "Ibiza",9000);
insert into coches(id,marca,modelo,kilometros) values(4,"Seat", "Leon",20);
insert into coches(id,marca,modelo,kilometros) values(5,"Opel", "Corsa",999);
insert into coches(id,marca,modelo,kilometros) values(6,"Renault", "Clio",34000);
insert into coches(id,marca,modelo,kilometros) values(7,"Seat", "Ibiza",2000);
insert into coches(id,marca,modelo,kilometros) values(8,"Seat", "Cordoba",99999);
insert into coches(id,marca,modelo,kilometros) values(9,"Renault", "Clio",88888);


-- primera forma de usar group by
select marca
from coches
group by marca;

-- segunda forma de usar group by

select marca, modelo
from coches
group by marca, modelo;

-- Funcion count con group by

select marca, count(*) as contador
from coches
group by marca
order by contador desc;

-- Funcion sum con group by

select marca, sum(kilometros)
from coches
group by marca;

-- Funcion MAX y MIN con group by

select marca, max(kilometros)
from coches
group by marca;

select marca, min(kilometros)
from coches
group by marca;

-- Funcion HAVING y group by

select fabricante.nombre, avg(producto.precio)
from producto
inner join fabricante
on producto.codigo_fabricante = fabricante.codigo
where fabricante.nombre != 'Seagate'
group by fabricante.codigo
having avg(producto.precio) >= 150;


select * from coches;



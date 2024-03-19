-- Indices En MySQL

/*
create index index_name 
	on table_name (column1, column2, ...);
*/

create database world;

use world;

create table tPopulationCity as
    select *
        from (
            select Name as cityName, Population, CountryCode
            from city
            order by Population desc
        ) as ciudades

        inner join (
            select Code, Name as CountryName, Continent
                from country
        ) as countryFilter on ciudades.CountryCode = countryFilter.Code

        where Continent <> 'Oceania' and Continent <> 'Antarctica';
        
select * from tPopulationCity;

select *
    from (
        select *
        from (
            select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
            from tPopulationCity
            where Continent = 'South America' or Continent = 'North America'
            order by Population desc
            limit 5
        ) as PopulationCitiesAmerica

        union

        select *
            from (
                select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
                from tPopulationCity
                where Continent = 'Europe'
                order by Population desc
                limit 5
            ) as PopulationCitiesEurope

        union

        select *
            from (
                select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
                from tPopulationCity
                where Continent = 'Asia'
                order by Population desc
                limit 5
            ) as PopulationCitiesAsia

        union

        select * 
            from (
                select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
                from tPopulationCity
                where Continent = 'Africa'
                order by Population desc
                limit 5
            ) as PopulationCitiesAfrica
    ) as orderCitiesPopulation
    order by Continent asc, CityName desc;



-- Crear indice
create index idx_name on country(name);

-- Borrar indice
drop index idx_name on country;

-- Indice unico sobre el nombre del Pais
create unique index idx_uno_name on country(name);

-- Indice para buscar un texto completo
-- create fulltext index idx_article_content on articles(content);

-- Indice para Vistas

create table tPopulationCity as
    
    select *
        from (
            select Name as cityName, Population, CountryCode
            from city
            order by Population desc
        ) as ciudades

        inner join (
            select Code, Name as CountryName, Continent
                from country
        ) as countryFilter on ciudades.CountryCode = countryFilter.Code

        where Continent <> 'Oceania' and Continent <> 'Antarctica';

select *
    from (
        select *
        from (
            select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
            from tPopulationCity
            where Continent = 'South America' or Continent = 'North America'
            order by Population desc
            limit 5
        ) as PopulationCitiesAmerica

        union

        select *
            from (
                select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
                from tPopulationCity
                where Continent = 'Europe'
                order by Population desc
                limit 5
            ) as PopulationCitiesEurope

        union

        select *
            from (
                select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
                from tPopulationCity
                where Continent = 'Asia'
                order by Population desc
                limit 5
            ) as PopulationCitiesAsia

        union

        select * 
            from (
                select Code, CountryName, CityName, Continent, format(Population, 0) as PopulationCity
                from tPopulationCity
                where Continent = 'Africa'
                order by Population desc
                limit 5
            ) as PopulationCitiesAfrica
    ) as orderCitiesPopulation
    order by Continent asc, CityName desc;
    
    
    select L.language, if(L.isOfficial = "F", "No oficial", "Oficial") as Tipo,
    case
		when L.IsOfficial = "F" then "No oficial"
        else "Oficial"
	end as Tipo2,
    case
		when L.Percentage < 0.3 then "Poco Hablado"
        when L.Percentage between 0.4 and 49 then "Mediamente hablado"
        when L.Percentage > 50 then "Muy Hablado"
	end as Frecuencia
    from world.countrylanguage L
    join world.country P on L.CountryCode = P.Code
    where P.name = "Colombia";
    
    use tienda;
    
    DROP DATABASE IF EXISTS tienda;
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;
CREATE TABLE fabricante (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL
);
CREATE TABLE producto (
id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
nombre VARCHAR(100) NOT NULL,
precio DOUBLE NOT NULL,
id_fabricante INT UNSIGNED NOT NULL,
FOREIGN KEY (id_fabricante) REFERENCES fabricante(id)
);
INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');
INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);




-- Sesion De Claves Y Restricciones.

-- Claves
-- Las claves en MySQL, como en otros sistemas de gestion de bases de datos, son fundamentales para organizar, relacionar y asegurar la integridad de los datos.

-- Claves Primarias

create table estudiantes(
	id int primary key,
    nombre varchar(50)
);

-- Otra forma de crear la clave primaria:

create table estudiantes(
	id int,
    nombre varchar(50),
    primary key(id)
);

-- Claves Foraneas (Externas) (Foreign key)

-- Una clave externa se utiliza para establecer relaciones entre tablas
-- Garantiza que los valores en una columna coincidan con los valores en la clave primaria de otra tabla

-- sintaxis

create table cursos(
	id int primary key,
    nombre varchar(50)
);

create table estudiantes(
	id int primary key,
    nombre varchar(50)
);

create table inscripciones(
	estudiante_id int,
    curso_id int,
    foreign key (estudiante_id) references estudiantes(id),
    foreign key (curso_id) references cursos(id)
);


-- 2. Restricciones

-- Restriccion de Unicidad (UNIQUE):

-- Garantiza que los valores en una columan o un conjunto de columans sean unicos en la tabla.

-- Ejemplo:

create table empleados(
	id int primary key,
    codigo_empleado int unique,
    nombre varchar(50)
);


-- Restriccion de Valor Predeterminado

-- Define un valor predeterminado para una columan si no se proporciona un valor al insertar un nuevo registro.

-- Ejemplo:

create table pedidos(
 id int primary key,
 fecha_pedido date default (current_date),
 total decimal(10,2) default 0.00
);

insert into pedidos(id, total) values(1, 100), (2, 30), (3, 150);

select * from pedidos;


-- Restriccion de Verificacion (CHECK)

-- Permite definir una condicion que debe cumplirse para que un valor se almacene en una columna

-- Ejemplo:
-- Crear una tabla productos con un id, nombre y cantidad donde se verifique que la cantidad debe ser mayor a 0.

create table producto(
	id int primary key,
    nombre varchar(50),
    cantidad int check(cantidad > 0)
);

insert into producto values (1,"Bandeja Paisa", 1);


-- Restriccion de No Nullos (NOT NULL)

-- Indica que una columan no puede contener valores nulos.

-- Ejemplo:

create table clientes(
	id int primary key,
    nombre varchar(50) not null
);


-- Restriccion de Valor Unico en Clave Primaria (AUTO_INCREMENT):

-- Se utiliza para generar automaticamente valores unicos para una columan de clave primaria.

-- Ejemplo

create table empleados(
	id int primary key auto_increment,
    nombre varchar(50)
);

insert into empleados (nombre) values ("camilo"), ("lorenzo"), ("carlos");
select * from empleados


-- Entidad relacion y el modelo relacional

-- Componentes principales del modelo E-R

-- 1. Entidades: Objetos del mundo real de interes para el sistema.
-- 2. Atributos: Caracteristicas o propiedades de las entidades.
-- 3. Relaciones: Asociaciones o conexiones entre las entidades.
-- 4. Cardinalidad: Cantidad de instancias de una entidad en otras. Los tipo que encotramos: uno a muchos (1,N), muchos a muchos (M,N) y de uno a uno (1:1).


-- Modelo Relacional

-- Es una representacion logica mas concreta y fisica de la base de datos
-- Los datos se organizan en tablas y relaciones
-- Las tablas filas(registros) y columnas(campos)
-- Las relaciones se hacen a traves de las llaves (primarias y foraneas (externas))
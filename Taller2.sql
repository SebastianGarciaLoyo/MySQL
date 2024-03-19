-- Consultas taller 2

-- 1/Parte base de datos world

use world;

select * from country;

select * from city;

select * from countrylanguage;

-- Consulta 1

select countrycode, name
from city
where countrycode = "COL";

-- Consulta 2

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
    
    -- consulta 3
    
    select C.name, C.continent, L.isOfficial
    from country as C
    inner join countrylanguage L on C.code = L.CountryCode
    where C.continent = "Africa" and L.isOfficial = "T"
    order by C.name asc;
    
	-- consulta 4
    
	select countrylanguage.countrycode, city.name, isOfficial, language
	from city
    inner join countrylanguage on city.countrycode = countrylanguage.countrycode
	where countrylanguage.countrycode = "COL" and city.name = "Bucaramanga" and isOfficial = "F";
    
    -- consulta 5
    
    select C.name, L.language, L.isOfficial
    from country as C
    inner join countrylanguage L on C.code = L.countrycode
    where L.isOfficial = "F";
    
    -- consulta 7
    
    select C.name, C.continent, L.language
    from country as C
    inner join countrylanguage L on C.code = L.countrycode
    where C.continent = 'Asia' and L.language = 'Spanish';


-- 2/Parte base de datos tienda

-- Consulta 1
	select P.nombre, P.precio,F.nombre
    from producto as P
	join fabricante F on F.id = P.id_fabricante;
    
    -- Consulta 2
    
    select P.nombre, P.precio,F.nombre
    from producto as P
	join fabricante F on F.id = P.id_fabricante
    order by F.nombre asc;
    
    -- Consulta 3
    
    select P.id,P.nombre, P.precio,F.id,F.nombre
    from producto as P
	join fabricante F on F.id = P.id_fabricante;
    
    -- Consulta 4
    
	select P.nombre, P.precio,F.nombre
    from producto as P
	join fabricante F on F.id
    where P.precio < 245.99
    order by P.precio asc
    limit 1;
    
    -- Consulta 5
    
    select P.nombre, P.precio,F.nombre
    from producto as P
	join fabricante F on F.id
    order by P.precio desc
    limit 1;
    
    -- Consulta 6
    
    select P.nombre, P.precio,F.nombre
    from producto as P
	inner join fabricante F on F.id = P.id_fabricante
    where F.nombre = "Lenovo"
    order by P.precio desc;
    
    -- Consulta 7
    
    select P.nombre, P.precio,F.nombre
    from producto as P
	inner join fabricante F on F.id = P.id_fabricante
    where F.nombre = "Crucial" and P.precio > 200
    order by P.precio desc;
    
    -- Consulta 8
    
    select P.nombre, P.precio,F.nombre
    from producto as P
	inner join fabricante F on F.id = P.id_fabricante
    where F.nombre = "Asus" or F.nombre = "Hewlett-Packard" or F.nombre = "Seagate"
    order by P.precio desc;
    
    -- Consulta 9
    
	select P.nombre, P.precio,F.nombre
    from producto as P
	inner join fabricante F on F.id = P.id_fabricante
    where F.nombre in ("Asus", "Hewlett-Packard", "Seagate")
    order by P.precio desc;
    
    -- Consulta 10
    
    select P.nombre, P.precio,F.nombre
    from producto as P
	inner join fabricante F on F.id = P.id_fabricante
    where trim(lower(right(F.nombre, 1))) = "e"
    order by P.precio desc;
    
    -- Consulta 11
    
    select P.nombre, P.precio,F.nombre
    from producto as P
	inner join fabricante F on F.id = P.id_fabricante
    where locate("w",F.nombre)
    order by P.precio desc;
    
    -- Consulta 12
    
    select P.nombre, P.precio, F.nombre
    from producto as P
    inner join fabricante F on F.id = P.id_fabricante
    where P.precio >= 180
    order by P.precio desc, P.nombre asc;
    
    -- Consulta 13
    
    select F.id, F.nombre, P.nombre
    from producto as P
    inner join fabricante F on F.id = P.id_fabricante
    order by F.id asc;
    
    -- Consulta 14
    
    select F.id, F.nombre, P.nombre
    from producto as P
    right join fabricante F on F.id = P.id_fabricante;
    
    -- Consulta 15
    
    select F.nombre, P.nombre
    from producto as P
    right join fabricante F on F.id = P.id_Fabricante
    where P.nombre is null;
    
    -- Consulta 17
    
    select F.nombre, P.nombre
    from producto as P
    left join fabricante F on F.id = P.id_Fabricante
    where F.nombre = "Lenovo";
    
    -- Consulta 18
    
    select F.nombre, P.nombre, P.precio
    from producto as P
    left join fabricante F on F.id = P.id_fabricante
    where P.precio >= 559 or F.nombre != "Lenovo"
    order by P.precio desc
    limit 2;
    
    -- Consulta 19
    
    select P.nombre,max(P.precio) as Precio_Mayor_Lenovo, F.nombre
    from producto as P
    inner join fabricante F on F.id = P.id_fabricante
    where F.nombre = "Lenovo"
    group by F.nombre, P.nombre limit 1;
    
    -- Consulta 20
    
    select P.nombre,min(P.precio) as Precio_Menor_HewlettPackard, F.nombre
    from producto as P
    inner join fabricante F on F.id = P.id_fabricante
    where F.nombre = "Hewlett-Packard"
    group by F.nombre, P.nombre limit 1;
    
        -- Consulta 21
    
    select P.nombre, P.precio, F.nombre
    from producto as P
    inner join fabricante F on F.id = P.id_fabricante
    where P.precio >= 559;
    
    -- Consulta 22
    
    drop view FabricanteProducto;
    
	create view FabricanteProducto as
    select P.id_fabricante, F.nombre as Marca, P.id, P.nombre as Producto, concat("$", format(P.precio, 2)) Precio
    from fabricante F
    inner join producto P on F.id = P.id_fabricante;
    
    select * from FabricanteProducto
    where substr(Precio,2) > (select avg(substr(Precio,2))
							from FabricanteProducto
                            where Marca = "Asus");
    
    
    use tienda;
    
    
    
    select * from producto;
    
    select * from fabricante;
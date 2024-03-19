-- Consultas Taller 1

use world;

select * from country;

select * from countrylanguage;

-- Consulta 1

select CountryCode, Language, length(Language) as longitud 
from countrylanguage
order by longitud desc
limit 2;

-- Consulta 2

select Name,IndepYear, if(IndepYear is null or IndepYear = ' ',  "N/A", IndepYear) as AñoDeIndependencia
from country;

-- Consulta 3

select Name, IndepYear, if(IndepYear > 1899, "Recien Independizado", "Antiguamente Independizado")  as "Estado De Independecia"
from country
where IndepYear is not null;


-- Consulta 4

select avg(LifeExpectancy) as Promedio 
from country
where Continent = "Africa";

-- Consulta 5

select Name, Continent, LifeExpectancy
from country
where LifeExpectancy is not null
order by LifeExpectancy asc
limit 1;

-- Consulta 6

select Name, Continent, LifeExpectancy
from country
order by LifeExpectancy desc
limit 1;

-- Consulta 7



-- Consulta 8

select Name, continent
from country
where continent = "Europe";
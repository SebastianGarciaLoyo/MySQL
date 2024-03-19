-- Consultas taller 4

use tienda;

select * from producto;
select * from fabricante;


-- Consulta 1

select count(*) as Total
from producto;

-- Consulta 2

select count(*) as Total
from fabricante;


-- Consulta 3

select count(distinct id_fabricante)
from producto as F;

-- Consulta 4

select avg(precio) as media
from producto;

-- Consulta 5

select max(precio) as max, min(precio) as min, avg(precio) as media, count(*) as total
from producto
where id_fabricante = "6";

-- Consulta 6

select F.nombre, count(*) as total
from producto as P
left join fabricante F on F.id = P.id_fabricante
group by F.nombre;

use tienda;

select * from producto;

select * from fabricante;

-- Consulta 1

select P.nombre,P.precio,F.nombre
    from producto as P
	join fabricante F on F.id = P.id_fabricante
    where P.precio >= 220;
    

-- Consulta 2

select P.nombre,P.precio,F.nombre
    from producto as P
	join fabricante F on F.id = P.id_fabricante
    where P.precio >= 220;
    
    create view temp as
		select P.nombre as xd,P.precio as dios,F.nombre as ayuda
    from producto as P
	join fabricante F on F.id = P.id_fabricante
    where P.precio >= 220;
    
    select * from temp;
    
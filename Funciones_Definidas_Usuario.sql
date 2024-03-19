-- Funciones Definidas Por El Usuario

-- 1. Eficiencia y Reusabilidad
-- 2. Mantenibilidad
-- 3. Claridad y Legibilidad

/*
	Sintaxis
    
    create function nombre_function(parametros)
    returns tipo_retorno
    begin
		-- Cuerpo de la funcion
        return valor;
	end
*/

-- Ejemplo

create database prueba;
use prueba;

delimiter //

create function calcularareacirculo(radio double)
returns double
deterministic
begin
	declare area double;
    set area = pi() * radio * radio;
    return area;
end //

delimiter ;

select calcularareacirculo(10);

-- Funcion que me devuelva la clasificacion de una pelicula segun su edad

delimiter //

create function clasificarPelicula(edad int)
returns varchar(30)
deterministic
begin
	if edad < 13 then
		return "Para Niños";
	elseif edad < 18 then
		return "Para Adolecesntes";
	else
		return "Para Adultos";
	end if;
end //

delimiter ;

select nombre, clasificarPelicula(edad) as Clasificacion
from pelicula;

select clasificarPelicula(12);

-- Crear una funcion para calcular el factorial de un numero

delimiter //

create function factorial(numero int)
returns int
deterministic
begin
	declare f int default 1;
    while numero > 1 do
		set f = f * numero;
        set numero = numero - 1;
	end while;
    return f;
end //

delimiter ;


select factorial(5);

-- 

use miprimerabasededatos;

select * from coches;

delimiter //

create function menoskilometraje()
returns int
deterministic
begin
	declare Kilo double;
    select kilometros into Kilo 
    from coches
    order by kilometros asc
    limit 1;
    return Kilo;
end //

delimiter ;

drop function menoskilometraje;

select * from coches
where kilometros = menoskilometraje();


use tienda;

-- Funcion que calcula un descuento al precio

delimiter //

create function calcularDescuento(valor decimal(10,2), porcentaje decimal(10,2))
returns decimal(10,2)
deterministic
begin
	if porcentaje > 0 and porcentaje <= 100 then
			return valor * (porcentaje / 100);
	elseif porcentaje > 100 then
		return valor;
	else
		return 0;
	end if;
end //

delimiter ;

drop function calcularDescuento;

set @porcentaje = 120;
select nombre, precio, calcularDescuento(precio, -20) as descuento, (precio - calcularDescuento(precio, -20)) as "Precio Final"
from producto;

create table ventas(
	id int auto_increment,
    vendedor_id int,
    monto_venta decimal(10,2),
    primary key (id)
);

-- Ejercicio1

delimiter //

create function promedioDeVentas(venta decimal(10,2), promedio decimal(10,2))
returns decimal(10,2)
deterministic
begin
	return venta + (porcentaje / 100);
end //

delimiter ;

select vendedor_id, monto_venta, promedioDeVentas(venta, 20) as Promedio;

-- Ejercicio 2

create table ordenes(
	id int auto_increment,
    cliente_id int,
    precio decimal(10,2),
    categoria_cliente varchar(10),
    primary key (id)
);


delimiter //

create function calcularPorCategoria(precio decimal(10,2), categoria_cliente varchar(10), descuento decimal(10,2))
returns decimal(10,2)
deterministic
begin
	if categoria_cliente = "A" then
		return precio * (descuento / 100);
	elseif categoria_cliente = "B" then
		return precio * (descuento / 100);
	else
		return precio;
	end if;
end //

delimiter ;

drop function calcularPorCategoria;

select calcularPorCategoria(precio, "A", 10) as precioFinal
from ordenes;

select * from ordenes;


-- Funciones deterministicas vs funciones no deterministicas

-- Funciones Deterministicas: Siempre devuelve el mismo resultado para los mismos valores de entrada
-- son predecibles y consistentes.

-- Funcion No Deterministicas: Son cuando son valores los cuales no son predecibles pero son constantes




-- Manejo De Errores Y Excepciones En Funciones


use prueba;

delimiter //

create function calcularDescuento(dividendo double, divisor double)
returns double
deterministic
begin
	if divisor = 0 then
		signal sqlstate '45000' set message_text = "Error, Division por cero no permitida";
    end if;
	return dividendo / divisor;
end //

delimiter ;

drop function calcularDescuento;

select calcularDescuento(6,0) as Resultado;
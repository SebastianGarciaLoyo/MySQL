-- Procedimientos Almacenados

-- Estructura Basica

/*
create procedure nombre_procedimiento ([parametros])
begin
	-- Declaraciones SQL y logica del procedimiento
end;
*/


-- Parametros

-- in : El valor del parametro se pasa al procedimiento y no puede ser modificado dentro del procedimiento

-- out: El procedimiento puede cambiar el valor del parametro y este cambio se refleja fuera del procedimiento.

-- inout: Combinacion de in y out. El valor puede ser pasado al procedimiento y tambien modificado dentro del mismo.


-- Ejemplo

use tienda;

delimiter // 

create procedure calculartotal(in precio decimal(10,2), in cantidad int, out total decimal(10,2))
begin
	set total = precio * cantidad;
end//

delimiter ;

set @total = 0;
call tienda.calculartotal(10,5, @total);
select total;

-- Ejemplo 2

create database base_ejemplo;
use base_ejemplo;

create table productos(
	id int not null auto_increment,
    nombre varchar(20) not null,
    estado varchar(20) not null default 'disponible',
    precio float not null default 0.0,
    primary key (id)
);

INSERT INTO productos (nombre, estado, precio) VALUES
('Producto1', 'disponible', 10.99),
('Producto2', 'disponible', 20.49),
('Producto3', 'agotado', 5.99),
('Producto4', 'disponible', 15.29),
('Producto5', 'disponible', 12.99),
('Producto6', 'agotado', 8.99),
('Producto7', 'disponible', 18.79),
('Producto8', 'agotado', 6.49),
('Producto9', 'disponible', 22.99),
('Producto10', 'disponible', 14.99),
('Producto11', 'disponible', 11.99),
('Producto12', 'agotado', 9.99),
('Producto13', 'disponible', 17.99),
('Producto14', 'disponible', 19.99),
('Producto15', 'disponible', 16.99),
('Producto16', 'agotado', 7.99),
('Producto17', 'disponible', 21.99),
('Producto18', 'disponible', 24.99),
('Producto19', 'disponible', 13.99),
('Producto20', 'agotado', 8.49);

delimiter //

create procedure obtenerproductosporestado(in nombre_estado varchar(225))
begin
	select * from productos where estado = nombre_estado;
end //

call base_ejemplo.obtenerproductosporestado('disponible');

-- Ejemplo 3

delimiter //
create procedure contarproductosporestado(in nombre_estado varchar(25), out numero int)
begin
	select count(id) into numero from productos where estado = nombre_estado;
end//
delimiter ;

set @cantidad_disponible = 0;
call contarproductosporestado('disponible', @cantidad_disponible);
select @cantidad_disponibles as productosdisponibles

-- Ejemplo 4

delimiter // 

create procedure venderproducto(inout beneficio int(255), in id_producto int)
begin
	declare precio_producto float;
    select precio into precio_producto from productos where id =id_producto;
	set beneficio = beneficio + precio_producto;
end//

delimiter //

set @beneficio_acumulado = 0;
call venderproducto(@beneficio_acumulado, 1); -- Venta del Producto 1
call venderproducto(@beneficio_acumulado, 2); -- Venta del Producto 2
select @beneficio_acumulado as beneficiototal;


-- Ejemplo 6


use world;
delimiter //
create procedure listarciudadesdepais(in nombrepais varchar(100))
begin
	select city.name 
    from country
    inner join city on city.countrycode = country.code
    where upper(country.name) = upper(nombrepais);
end //

delimiter ;

drop procedure listarciudadesdepais;
call listarciudadesdepais("Spain");

-- Ejercicio 1

delimiter //

create procedure contarciudadesdepais( in nombrepais varchar(100), out numero int)
begin
	select count(city.name) into numero
    from country
    inner join city on city.countrycode = country.code
    where upper(country.name) = upper(nombrepais);
end //

delimiter ;

drop procedure contarciudadesdepais;

set @cantidad = 0;
call contarciudadesdepais("Colombia", @cantidad);
select @cantidad as total;


-- Ejercicio 2

select * from country;

select * from countrylanguage;

delimiter //

create procedure poblaciontotal( in poblacion int(100), out numero int)
begin
	select C.population, count(L.isOfficial), C.name
    from country as C
    inner join countrylanguage L on countrylanguage.countrycode = country.code
    where isOfficial = "T" = upper(poblacion);
end //

delimiter ;

drop procedure poblaciontotal;

set @cantidad = 0;
call poblaciontotal("Colombia", @cantidad);
select @cantidad as total;

-- Procedimientos Almacenados

-- Ejemplo con IF-THEN-ELSE

create table usuarios(
	id int auto_increment,
    nombre varchar(100),
    edad int,
    categoria varchar(10),
    primary key (id)
);


-- Estructura Loop

-- Ejecuta un bloque de codigo repetidamente hasta que se encuentra con una sentencia LEAVE.
-- Ideal para cuando necesitas ejecutar un bloque de codigo un numero indefinido de veces hasta que se cumpla una condicion.
-- Usa LOOP cuando no sabes de antemano cuantas veces necesitas iterar.

-- Estructura general

/*
LOOP
	if condicion_salida then
		leave loop_label;
	end if;
END LOOP loop_label
*/

-- Ejemplo con LOOP

create table empleados(
	id int auto_increment,
    nombre varchar(100),
    salario decimal(10,2),
    primary key (id)
);

delimiter //

create procedure aumentarsalario(in empleadoid int)
begin
	loop
		update empleados set salario = salario * 1.1 where id = empleadoid and salario <= 5000; 
        if salario > 5000 then
				leave;
        end if;
	end loop;
end //

delimiter ;


-- Estructura REPEAT

-- se ejecuta hasta que una condicion especifica se cumple
-- Util cuando sabes que el bloque de codigo debe ejecutarse al menos una vez y continuar hasta que se cumpla una condicion.
-- Opta por REPEAT cuando la condicion de terminacion es mas importante que la condicion de inicio.

-- Estructura general:

/*
REPEAT
	-- Acciones a repetir
UNTIL condicion
END REPEAT;
*/

-- Ejemplo REPEAT

delimiter //

create procedure aumentarsalarios()
begin
	repeat
		update empleados set salario = salario * 1.05 where salario < 3000;
        until (select count(*) from empleados where salario < 3000) = 0
        end repeat;
end //

delimiter ;


-- Estructura WHILE

-- Ejecuta un bloque ed codigo mientras una condicion sea verdadera.
-- Ideal para situaciones donde necesitas continuar la ejecucion mientras se cumpla una condicion.
-- Usa WHILE cuando la condicion de inicio es mas critica que la de terminacion.

/*
WHILE condicion DO
	-- Acciones a repetir
end WHILE;
*/


-- Ejemplo WHILE

delimiter //

create procedure ContarEmpleadosAltosSalarios()
begin
	declare contador int default 0;
    declare totalempleados int default 0;
    select count(*) into totalempleados from empleados where salario > 4000;
    while contador < totalempleados do
		set contador = contador + 1;
	end while;
    select contador;
end // 

delimiter ;

-- Estructura CASE

-- Es similar a las declaraciones "switch" en otros lenguajes de progamacion
-- util para evaluar una variable o expresion contra una serie de valores o condiciones distintias.
-- Es especialmente util en procedimientos almacenados y funciones para simplificar la logica condicional compleja.

/*
CASE expresion
	when valor 1 then
		-- Acciones para valor1
	when valor2 then
		-- Acciones para valor2
	else
		-- Acciones si no se cumple ninguno de los casos anteriores
END CASE;
*/


-- Ejemplo CASE

delimiter //

create procedure AsignarCategoriaSalario()
begin
	declare donde int default false;
    declare empid int;
    declare empsal decimal(10,2);
    declare cur1 cursor for select id, salario from empleados;
    declare continue handler for not found set done = true;
    
    open cur1;
    
	read_loop: loop
		fetch cur1 into empid, empsal;
        if done then
			leave read_loop;
		end if;
        
        case
			when empsal <= 3000 then
				update empleados set categoria = "Entrada" where id = empid;
                
			when empsal > 3000 and empsal <= 7000 then
				update empleados set categoria = "Media" where id = empid;
			
            else
				update empleados set categoria = "Alta" where id = empid;
			end case;
		end loop;
            
	close cur1;
end //
delimiter ;


-- Manejo de errores

/*create procedure InsertarUsuario( in username varchar(50), in email varchar(100))
begin
	declare exit handler for 1062:
    select 'Error: El usuario ya existe';
    
    insert into usuarios(username,email) values(username,email);
end;*/

-- Ejemplo 1

use tienda;

drop procedure insertarfabricante;

delimiter //

create procedure insertarfabricante( in idfabricante int, in nombrefabricante varchar(100))
begin
	declare exit handler for 1062 select concat("Error, El fabricante ", nombrefabricante, " ya existe") as Error;
    
    insert into fabricante values (idfabricante, nombrefabricante);
end //

delimiter ;

call insertarfabricante(10, "Motorola");

-- Ejemplo 2

delimiter //

create procedure ActualizarUsuario(in userid int, in newemail varchar(100))
begin
	declare exit handler for sqlexception
    begin	
		-- Se podria registrar el error en una tabla de logs
		insert into error_logs(error_message) values ('Error al actualizar usuario.');
        rollback; -- Revertir la transaccion
	end;
    
    start transaction;
    update usuarios set email = newemail where id = userid;
    commit;
end //

delimiter ;
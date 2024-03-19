-- Seguridad y Permisos

select user, host
from mysql.user;


-- Operaciones Basicas para dar permiso

create user "cacas"@localhost identified by "cacas2024";

grant select, insert, update on prueba.* to "cacas"@localhost;

show grants for "cacas"@localhost;

drop user "cacas"@localhost;

grant insert on prueba.empleados to "cacas"@localhost;
revoke insert on prueba.empleados from "cacas"@localhost;


grant usage on  prueba.* to "cacas"@localhost;

alter user "cacas"@localhost with max_queries_per_hour 100;

select user, host
from mysql.user
where user = "";

drop user ""@localhost;

alter user "cacas"@localhost identified by "c@c@s2024";

revoke all privileges on *.* from "cacas"@localhost;
grant select on prueba.* to "cacas"@localhost;

create user "Admin"@"%" identified by "campus2024";
grant all privileges on *.* to 'Admin'@'%' with grant option;

revoke all privileges, grant option from 'Admin'@'%';


create user camilo@localhost identified by 'bucaroscampeon';
grant select (username,email) on prueba.users to camilo@localhost;

use world;

select * from city where countrycode = "COL";

prepare stat from 'select * from city where countrycode = ?';

set @pais = "COL";
execute stat using @pais;

deallocate prepare stat;
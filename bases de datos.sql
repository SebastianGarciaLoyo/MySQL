create database ejercicio;
use ejercicio;

-- Normalizacion: Practica

-- ejercicio 1

create table estudiante(
	id int primary key,
    nombre varchar(100)
);

create table telefono(
	telefono int,
    id_est int,
    foreign key(id_est) references estudiante(id),
    primary key(id_est, telefono)
);


-- ejercicio 2

create table cursoestudiante(
	cursoid int,
    estudianteid int,
    primary key(cursoid, estudianteid),
    foreign key (id_curso) references curso(id_curso),
    foreign key (id_estudiante) references estudiante(id_estudiante)
);

create table curso(
	idcurso int primary key,
    nombre_curso varchar(100)
);

create table estudiante(
	id int primary key,
    nombre varchar(100)
);

-- ejercicio 3

create table Profesor(
	profesorid int,
    departamentoid int,
    primary key(profesorid, departamentoid),
    foreign key(profesorid) references infoprofe(id_infoprofe),
    foreign key(departamentoid) references departamento(id_departamento)
);

create table infoprofe(
	id int primary key,
    nombre varchar(100),
    apellido varchar(100)
);

create table departamento(
	id int primary key,
    nombre varchar(100),
    tipodepartamento varchar(100)
);


-- Ejercicio 4

create table asignacion(
	profesorid int,
    cursoid int,
    primary key(profesorid,cursoid),
    foreign key(cursoid) references Curso(id),
    foreign key(Profesor) references Profesor(id)
);

create table horario(
	horario_id int primary key,
    hora_curso time
);

create table Curso_horario(
	curso_id int,
    id_horario int primary key,
    foreign key (curso_id) references curso (curso_id),
    foreign key (id_horario) references horarios (horario_id),
    primary key (id_horario, curso_id)
);


-- Ejercicio 5

create table registrohospital(
	pacienteid int,
    medicoid int,
    recetaid int,
    tratamientoid int,
    medicamentoid int,
    primary key(pacienteid, medicoid, medicamentoid, tratamientoid),
    foreign key(pacienteid) references paciente(id_paciente),
    foreign key(medicoid) references doctor(id_doctor),
    foreign key(recetaid) references receta(id_receta),
    foreign key(tratamientoid) references tratamiento(id_tratamiento)
);

create table doctor(
	id_doctor int primary key,
    nombremedico varchar(100),
    especialidad varchar(100)
);

create table doctor_has_paciente(
	id_doctor int,
    id_paciente int,
    primary key(id_doctor,id_paciente),
    foreign key(id_doctor) references doctor(id_doctor),
    foreign key(id_paciente) references paciente(id_paciente)
);

create table paciente(
	id_paciente int primary key,
    nombrepaciente varchar(100),
    fechanacimiento date,
    fechavisita datetime
);

create table receta(
	id_receta int primary key,
    medicamento varchar(100),
    dosis varchar(50)
);

create table tratamiento(
	id_tratamiento int primary key,
	nombretratamiento varchar(100),
    descripciontratamiento varchar(225)
);


-- que pacientes fueron tratados en el 2022, indique el id del paciente,
-- el nombre del paciente, fecha consulta, nombre medico y el tratamiento que recibio

 select P.id_paciente as ID, P.nombrepaciente as Nombre, P.fechavisita as Fecha_Visita, 
 D.nombremedico as Doctor, T.nombretratamiento as Tratamiento, T.descripciontratamiento as Descripcion
 from paciente as P, doctor as D, tratamiento as T;

select * from registrohospital;

select * from doctor;

select * from doctor_has_paciente;

select * from paciente;

select * from receta;

select * from tratamiento;
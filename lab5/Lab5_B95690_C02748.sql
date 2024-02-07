/* Laboratio 5
	Daniel Escobar Grialdo | C02748S
	Fabian Orozco Chaves | B95690
*/

-- use C02748 
use B95690

/*Pregunta 3*/
go
Create trigger eliminarAsistente
on Estudiante 
Instead of delete 
as 
begin 
	set nocount on;
	declare @cedulaEstudiante char(10)
	
	select @cedulaEstudiante = Deleted.Cedula
	from deleted

	delete from Asistente where Asistente.Cedula = @cedulaEstudiante
	delete from Estudiante where Estudiante.Cedula = @cedulaEstudiante
end 

/*agregamos no action a la tabla asistente*/
alter table Asistente
add constraint estudiante_delete_no_action foreign key (Cedula) references Estudiante (Cedula) on delete no action

/*agrego un estudiante asistente que no lleve un curso*/
INSERT INTO Estudiante VALUES ('3333333333',	'example@test.com',	'Marco',	'Keto',	'Americo',	'm',	'2001-08-01',	'Alajuela',	'88888889',	'B87022',	'Moroso')
INSERT INTO Asistente VALUES ('3333333333', 4)


/*prueba del trigger, eliminamos un estudiante que no es asistente*/
delete from Estudiante where Cedula = '1111111111'


/*prueba del trigger, eliminamos un estudiante que si es asistente*/
delete from Estudiante where Cedula = '3333333333'

/*ver resultados*/
select * from Asistente
select * from Estudiante

/*Pregunta 4*/

/*trigger de tabla Estudiante*/
go
Create trigger disyuncionEstudianteProfesor
on Estudiante
Instead of insert 
as 
begin 
	set nocount on;
	declare @cedulaPersona char(10)
	
	select @cedulaPersona = inserted.Cedula
	from inserted

	if @cedulaPersona not in (select Cedula from Profesor)
	begin
		INSERT INTO Estudiante
		SELECT
			i.Cedula, i.Email, i.Nombre, i.Apellido1, i.Apellido2, i.Sexo, i.FechaNac, i.Direccion, i.Telefono, i.Carne, i.Estado
		FROM
			inserted i
	end
	else 
	begin
		print 'El estudiante no puede ser un profesor y un estudiante a la vez'
	end
end 

/*trigger de tabla Profesor*/
go
Create trigger disyuncionProfesorEstudiante
on Profesor
Instead of insert 
as 
begin 
	set nocount on;
	declare @cedulaPersona char(10)
	
	select @cedulaPersona = inserted.Cedula
	from inserted

	if @cedulaPersona not in (select Cedula from Estudiante)
	begin
		INSERT INTO Profesor
		SELECT
			i.Cedula, i.Email, i.Nombre, i.Apellido1, i.Apellido2, i.Sexo, i.FechaNac, i.Direccion, i.Telefono, i.Categoria, i.FechaNombramiento, i.Titulo, i.Oficina
		FROM
			inserted i
	end
	else 
	begin
		print 'El profesor no puede ser un profesor y un estudiante a la vez'
	end
end 

/*Para comprobar los resultados*/
select * from Estudiante
select * from Profesor

/*Insertar profesor con cedula de un estudiante*/
insert into Profesor values('0123456789','a@test.com','Paula','Sensei','Giraldo','m','2003-08-10','Limon','62626262','Interino', '2002-09-02', 'Licenciado', 30)

/*Insertar profesor que no tiene la cedula de un estudiante*/
insert into Profesor values('5555555555','k@test.com','Paula','Sensei','Giraldo','m','2003-08-10','Limon','62626262','Interino', '2002-09-02', 'Licenciado', 30)


/*Insertar estudiante con cedula de un profesor*/
insert into Estudiante values('1231231234','u@test.com','Paula','Sensei','Giraldo','m','2003-08-10','Limon','62626262','C02748', 'Libre')

/*Insertar estudiante que no tiene la cedula de un profesor*/
insert into Estudiante values('7777777777 ','g@test.com','Paula','Sensei','Giraldo','m','2003-08-10','Limon','62626262','C02748', 'Libre')

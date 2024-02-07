/* Laboratorio 6
	Daniel Escobar Grialdo | C02748S
	Fabian Orozco Chaves | B95690
*/

-- use C02748 
-- use B95690

/*Ejercicio 1*/
go
Create trigger agregarEstudiante
on Lleva 
Instead of insert 
as 
begin 
	set nocount on;
	declare @cedulaEstudiante char(10)
	declare @semestre TINYINT
	declare @año int
	declare @SiglaCurso VARCHAR(8)
	
	-- Asignamos los valores a variables
	select @cedulaEstudiante = i.CedEstudiante, @semestre = i.Semestre, @año = i.Año, @SiglaCurso = i.SiglaCurso
	from inserted i

	-- Recuperamos la cantidad de créditos que tiene el estudiante actualmente.
	declare @creditosPorSemestre int
 	select @creditosPorSemestre = dbo.CreditosPorSemestre(@cedulaEstudiante, @semestre, @año)

	-- verifica que el curso exista
	if @SiglaCurso in (select sigla from curso)
	begin
		-- Sacamos la cantidad de creditos que quiere ingresar
		declare @creditosActuales int
		SELECT @creditosActuales = Curso.Creditos
		FROM Curso 
		Where Curso.Sigla = @SiglaCurso

		if @creditosActuales IS NULL BEGIN set @creditosActuales = 0 END

		-- comprueba la suma de ambos
		declare @creditosTotales int
		set @creditosTotales = @creditosPorSemestre +  @creditosActuales
		
			-- Condición
		if @creditosTotales > 18
		BEGIN
			PRINT 'NO se puede matricular más de 18 créditos por semestre'
		END
		else 
		BEGIN
			-- Inserción en caso <= 18
			Insert into Lleva Select * from inserted
		END 
	end
	else --el curso no existe
	BEGIN
		Print 'El curso ingresado no existe'
	END
end 

-- Prueba del comportamiento
-- i. Inserta estudiante que no sobrepasa el límite de 18 créditos.
Insert into Lleva VALUES ('6666666666', 'CI0126', 1, 2, 2014, NULL)

-- ii. Inserta estudiante que sobrepasa el límite de 18 créditos.
Insert into Lleva VALUES ('6666666666', 'C0129', 2, 2, 2014, 20)

-- Verificar resultados
Select * from Estudiante
Select * from Curso
Select * from Lleva
select dbo.CreditosPorSemestre('6666666666', 2, 2014) as 'creditos'

/*Ejercicio 2*/

-- Borramos el primer trigger para evitar error
DROP TRIGGER agregarEstudiante

go
Create or alter trigger agregarEstudiante
on Lleva 
Instead of insert 
as 
begin 
	set nocount on;
	declare @cedulaEstudiante char(10)
	declare @SiglaCurso VARCHAR(8)
	declare @NumGrupo TINYINT
	declare @semestre TINYINT
	declare @año int
	declare @nota TINYINT
	
	-- Cursor
	DECLARE matricula CURSOR FOR
		select i.CedEstudiante, i.SiglaCurso, i.NumGrupo, i.Semestre, i.Año , i.Nota
		from inserted i

	OPEN matricula
	FETCH next from matricula into @cedulaEstudiante, @SiglaCurso, @NumGrupo, @semestre, @año, @nota

	declare @creditosPorSemestre int
	declare @creditosActuales int
	declare @creditosTotales int

	While @@FETCH_STATUS = 0 BEGIN
		-- Recuperamos la cantidad de créditos que tiene el estudiante actualmente.
	 	set @creditosPorSemestre = dbo.CreditosPorSemestre(@cedulaEstudiante, @semestre, @año)
			
		-- verifica que el curso exista
		if @SiglaCurso in (select sigla from curso)
		begin
			-- Sacamos la cantidad de creditos que quiere ingresar
			SELECT @creditosActuales = Curso.Creditos
			FROM Curso 
			Where Curso.Sigla = @SiglaCurso

			if @creditosActuales IS NULL BEGIN set @creditosActuales = 0 END

			-- comprueba la suma de ambos
			set @creditosTotales = @creditosPorSemestre +  @creditosActuales
			
				-- Condición
			if @creditosTotales > 18
				BEGIN
					PRINT concat(@cedulaEstudiante, ': error. NO se puede matricular más de 18 créditos por semestre')
				END
			else 
				BEGIN
					-- Inserción en caso <= 18
					Insert into Lleva values (@cedulaEstudiante, @SiglaCurso, @NumGrupo, @semestre, @año, @nota )
				END 
		end
		else --el curso no existe
		BEGIN
			Print 'El curso ingresado no existe'
		END
	FETCH next from matricula into @cedulaEstudiante, @SiglaCurso, @NumGrupo, @semestre, @año, @nota
	END -- end while
	CLOSE matricula
	DEALLOCATE matricula
end 

-- Prueba del comportamiento
-- i. Inserta dos tuplas de la tabla juntas que no sobrepasan el límite de 18 créditos en un semestre
-- PENDIENTE
INSERT INTO Lleva VALUES ('6666666666','CI0126', 1, 2, 2014, 80), ('6666666666','CI0126', 2, 2, 2014, 90)

-- ('6666666666','C0129', 2, 2, 2014, 70)

-- ii. Inserta dos tuplas de la tabla juntas que sobrepasan el límite de 18 créditos en un semestre
INSERT INTO Lleva VALUES ('6666666666','C0129', 2, 2, 2014, 70), ('6666666666','CI0128', 1, 2, 2014, 75)
-- Verificar resultados
Select * from Estudiante
Select * from Lleva
select dbo.CreditosPorSemestre('6666666666', 2, 2014) as 'creditos'

/*Ejercicio 3*/
go
create view EstudiantePorGrupo as
select Grupo.SiglaCurso, Grupo.NumGrupo, Grupo.Semestre, Grupo.Año, count(Lleva.CedEstudiante) cantEstud
from Grupo left join Lleva on 
Grupo.SiglaCurso = Lleva.SiglaCurso and 
Grupo.NumGrupo = Lleva.NumGrupo and
Grupo.Semestre = Lleva.Semestre and 
Grupo.Año = Lleva.Año
Group by Grupo.SiglaCurso, Grupo.NumGrupo, Grupo.Semestre, Grupo.Año

go
INSERT INTO Lleva VALUES ('1111111111','C0129', 2, 2, 2014, 70)

go
select * from EstudiantePorGrupo
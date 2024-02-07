/* Trabajo en parejas
  Fabián Orozco Chaves - B95690
  Daniel Escobar Giraldo - C02748 */

-- SECCION 3.a
-- USE B95690
-- USE C02748

GO -- Indica que empieza un nuevo lote lógico (inicia un nuevo batch)
CREATE PROCEDURE MatricularEstudiante (
  @CedEstudiante CHAR(10),
  @SiglaCurso VARCHAR(8),
  @NumGrupo TINYINT,
  @Semestre TINYINT, 
  @Año INT,
  @Nota FLOAT = NULL,
  @Configuracion TINYINT
) AS 
BEGIN
IF (@Configuracion = 0)  
-- Se realiza la matricula independientemente de si el curso pertenece a una carrera del estudiante.
  BEGIN
    INSERT INTO Lleva (CedEstudiante, SiglaCurso, NumGrupo, Semestre, Año, Nota) VALUES (@CedEstudiante, @SiglaCurso, @NumGrupo, @Semestre, @Año, @Nota)
  END
ELSE IF (@Configuracion = 1) 
-- Se realiza la matricula independientemente de si el curso pertenece a una carrera del estudiante.
  BEGIN
    IF @SiglaCurso IN ( 
      SELECT Pertenece_a.SiglaCurso
      FROM Estudiante JOIN Empadronado_en ON 
      Estudiante.Cedula = Empadronado_en.CedEstudiante 
      JOIN Pertenece_a ON Pertenece_a.CodCarrera = Empadronado_en.CodCarrera
      WHERE Estudiante.Cedula = @CedEstudiante
    )
    BEGIN 
      INSERT INTO Lleva (CedEstudiante, SiglaCurso, NumGrupo, Semestre, Año, Nota) VALUES (@CedEstudiante, @SiglaCurso, @NumGrupo, @Semestre, @Año, @Nota)
    END
    ELSE BEGIN PRINT 'El curso no pertenece a una de las carreras del estudiante' END
  END
END

GO -- Indica que empieza un nuevo lote lógico (inicia un nuevo batch)
EXEC MatricularEstudiante @CedEstudiante = '6666666666', @SiglaCurso = 'CI0127', @NumGrupo = 2, @Semestre = 1, @Año = 2015, @Configuracion = 1
-- Salida: 'El curso no pertenece a una de las carreras del estudiante'

GO -- Indica que empieza un nuevo lote lógico (inicia un nuevo batch)
EXEC MatricularEstudiante @CedEstudiante = '6666666666', @SiglaCurso = 'CI0126', @NumGrupo = 1, @Semestre = 2, @Año = 2014, @Configuracion = 1
-- Salida: 1 rows affected

-- 
/*============================================================================*/

-- SECCION 3.b
GO -- Indica que empieza un nuevo lote lógico (inicia un nuevo batch)
CREATE FUNCTION CreditosPorSemestre (
  @CedEstudiante VARCHAR(10),
  @Semestre TINYINT,
  @Año INT
) 
RETURNS INT AS
BEGIN
  DECLARE @sumaCreditos INT
  SELECT @sumaCreditos = SUM(Curso.Creditos)
  FROM Estudiante JOIN Lleva ON Lleva.CedEstudiante = Estudiante.Cedula 
  JOIN Grupo ON Grupo.SiglaCurso = Lleva.SiglaCurso
  AND Grupo.NumGrupo = Lleva.NumGrupo
  AND Grupo.Semestre = Lleva.Semestre
  AND Grupo.Año = Lleva.Año
  JOIN Curso ON Curso.Sigla = Grupo.SiglaCurso
  WHERE Lleva.Semestre = @Semestre AND Lleva.Año = @Año AND Estudiante.Cedula = @CedEstudiante
  RETURN @sumaCreditos
END

-- EXEC MatricularEstudiante @CedEstudiante = '6666666666', @SiglaCurso = 'CI0126', @NumGrupo = 2, @Semestre = 2, @Año = 2014, @Configuracion = 0

GO -- Indica que empieza un nuevo lote lógico (inicia un nuevo batch)
SELECT dbo.CreditosPorSemestre('6666666666', 2, 2014) as 'creditos_Semestrales'

/*============================================================================*/

-- SECCION 3.b
GO -- Indica que empieza un nuevo lote lógico (inicia un nuevo batch)
CREATE PROCEDURE ActualizarCreditos (
  @CodCarrera VARCHAR(10),
  @PorcentajeAumento FLOAT
) AS 
BEGIN
  UPDATE Curso 
  SET Curso.Creditos = CEILING(Curso.Creditos * ((@PorcentajeAumento + 100) / 100))
  FROM Curso JOIN Pertenece_a ON Pertenece_a.SiglaCurso = Curso.Sigla
  WHERE Pertenece_a.CodCarrera = @CodCarrera
END

EXEC ActualizarCreditos @CodCarrera = 'bach01Comp', @PorcentajeAumento = 50

/* Fin de lab4. 
Fabián Orozco Chaves - B95690
Daniel Escobar Giraldo - C02748
UCR | ECCI | Bases de Datos | II Ciclo - 2022 */
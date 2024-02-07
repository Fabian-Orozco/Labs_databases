/*Fabián Orozco Chaves B95690*/
use BD_Universidad

/*Consulta a*/
SELECT NombreP, Apellido1, Apellido2, Oficina, FechaNomb
FROM Profesor
/*-----------------------------------------*/

/*Consulta b*/
SELECT E.Cedula, E.NombreP, E.Apellido1, E.Apellido2, Curso.Nota
FROM Estudiante E JOIN Lleva Curso ON E.Cedula = Curso.CedEstudiante JOIN Grupo G ON 
G.SiglaCurso = Curso.SiglaCurso AND 
G.NumGrupo = Curso.NumGrupo AND 
G.Semestre = Curso.Semestre AND 
G.Anno = Curso.Anno
WHERE Curso.SiglaCurso = 'ART2'

/*-----------------------------------------*/

/*Consulta c*/
SELECT E.Carne, E.NombreP
FROM ESTUDIANTE E JOIN Lleva Curso ON E.Cedula = Curso.CedEstudiante
WHERE Curso.Nota BETWEEN 60 AND 80
/*-----------------------------------------*/

/*Consulta d*/
SELECT Distinct req.SiglaCursoRequeridor
FROM Requiere_De req
WHERE req.SiglaCursoRequisito = 'CI1312'
/*-----------------------------------------*/

/*Consulta e*/
SELECT MAX(Curso.nota) AS NotaMaxima, MIN(Curso.Nota) AS NotaMinima, AVG(Curso.Nota) AS NotaPromedio
FROM Lleva Curso JOIN Grupo ON
Grupo.SiglaCurso = Curso.SiglaCurso AND 
Grupo.NumGrupo = Curso.NumGrupo AND 
Grupo.Semestre = Curso.Semestre AND 
Grupo.Anno = Curso.Anno
WHERE Curso.SiglaCurso = 'CI1221'
/*-----------------------------------------*/

/*Consulta f*/
SELECT DISTINCT Escuela.Nombre, Carrera.Nombre
FROM Escuela JOIN Carrera ON Escuela.Codigo = Carrera.CodEscuela
ORDER BY Escuela.Nombre, Carrera.Nombre
/*-----------------------------------------*/

/*Consulta g*/
SELECT COUNT(*) CantidadProfes
FROM Profesor, Escuela, Trabaja_en
WHERE Escuela.Nombre = 'Escuela de Computación e Informática' AND Trabaja_en.CodEscuela = Escuela.Codigo AND Trabaja_en.CedProf = Profesor.Cedula
/*-----------------------------------------*/

/*Consulta h*/
SELECT Distinct Estudiante.Cedula
FROM Estudiante
EXCEPT
  (SELECT Distinct Empadronado_en.CedEstudiante
  FROM Empadronado_en)
/*-----------------------------------------*/

/*Consulta i*/ 
SELECT Grupo.SiglaCurso, Grupo.NumGrupo, Grupo.Semestre, Grupo.Anno, Grupo.CedAsist, Asistente.NumHoras AS horasAsistente
FROM Grupo left join Asistente on Grupo.CedAsist = Asistente.Cedula

/*Respuesta
Se utiliza un outer join ya que se requiere mostrar incluso los valores nulos (para la cédula del asistente.) Es left porque se quiere que muestre todos los resultados de la izquierda sin importar que no coincidan con los de la derecha.
-----------------------------------------*/

/*Consulta j*/
SELECT Estudiante.NombreP
FROM Estudiante
WHERE Estudiante.Apellido1 LIKE '%a'
/*-----------------------------------------*/

/*Consulta j'*/
SELECT Estudiante.NombreP
FROM Estudiante
WHERE Estudiante.Apellido1 LIKE '%a' OR Estudiante.NombreP LIKE 'M%'
/*-----------------------------------------*/

/*Consulta j''*/
SELECT Estudiante.NombreP
FROM Estudiante
WHERE Estudiante.Apellido1 LIKE 'M%a'
/*-----------------------------------------*/

/*Consulta k*/
SELECT Estudiante.NombreP
FROM Estudiante
WHERE Estudiante.NombreP LIKE '______'
/*-----------------------------------------*/

/*Consulta l*/
SELECT NombreP, Apellido1, Apellido2
FROM Profesor 
WHERE Sexo = 'm'
UNION (
    SELECT NombreP, Apellido1, Apellido2
    FROM Estudiante
    WHERE Sexo = 'm')
-----------------------------------------*/

/*Consulta m*/
SELECT Carne, NombreP, Apellido1, Apellido2
FROM Estudiante
WHERE Teléfono IS NULL
/*-----------------------------------------*/

/* 
Fin de lab1. 
Fabián Orozco Chaves - B95690
UCR | ECCI | Bases de Datos | II Ciclo - 2022
*/

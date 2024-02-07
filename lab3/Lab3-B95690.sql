/* Fabián Orozco Chaves - B95690 */

USE BD_Universidad

-- Sección C.1
SELECT DISTINCT Estudiante.NombreP, Estudiante.Apellido1, Curso.Sigla
FROM Asistente JOIN Estudiante 
ON Asistente.Cedula = Estudiante.cedula 
JOIN Grupo ON Grupo.CedAsist = Estudiante.Cedula
JOIN Curso ON Grupo.SiglaCurso = Curso.Sigla

-- Sección C.2
SELECT NombreP, Investigacion.Nombre AS Nombre_Investigacion, Escuela.Nombre AS Nombre_Escuela
FROM Profesor JOIN Participa_en ON Profesor.Cedula = Participa_en.CedProf 
JOIN Investigacion ON Investigacion.NumProy = Participa_en.NumProy 
JOIN Trabaja_en ON Trabaja_en.CedProf = Profesor.Cedula
JOIN Escuela ON Escuela.Codigo = Trabaja_en.CodEscuela

-- Sección D.3
SELECT Profesor.Titulo,COUNT(*) AS CantidadProfesores
FROM Profesor
GROUP BY Profesor.Titulo
ORDER BY CantidadProfesores DESC

-- Sección D.4
SELECT Lleva.CedEstudiante, AVG(Lleva.Nota) as NotaPromedio
FROM Lleva
GROUP BY Lleva.CedEstudiante
ORDER BY Lleva.CedEstudiante

-- Sección D.5
SELECT Investigacion.Nombre, SUM(Participa_en.Carga) as CargaProyecto
FROM Participa_en JOIN Investigacion ON Investigacion.NumProy = Participa_en.NumProy
GROUP BY Participa_en.NumProy, Investigacion.Nombre

-- Sección D.6
SELECT COUNT(Pertenece_a.CodCarrera) as CantidadCarreras
FROM Pertenece_a
GROUP BY Pertenece_a.SiglaCurso
HAVING Count(CodCarrera) > 2

-- Sección D.7
SELECT Facultad.Nombre NombreFacultad, count(Carrera.Codigo) as CantidadCarreras
FROM Facultad JOIN Escuela ON Escuela.CodFacultad = Facultad.Codigo
LEFT JOIN Carrera ON Carrera.CodEscuela = Escuela.Codigo
GROUP BY Facultad.Nombre
ORDER BY CantidadCarreras DESC

-- Sección D.8
SELECT Grupo.NumGrupo, Grupo.SiglaCurso, Grupo.Semestre, Grupo.Anno, COUNT(Lleva.CedEstudiante) AS EstudiantesMatriculados
From Grupo left join Lleva on 
Grupo.SiglaCurso = Lleva.SiglaCurso and 
Grupo.NumGrupo = Lleva.NumGrupo and 
Grupo.Semestre = Lleva.Semestre and
Grupo.Anno = Lleva.Anno
WHERE Grupo.SiglaCurso LIKE 'CI%'
GROUP BY Grupo.SiglaCurso, Grupo.NumGrupo, Grupo.Semestre, Grupo.Anno
ORDER BY Grupo.Anno, Grupo.Semestre, Grupo.SiglaCurso, Grupo.NumGrupo

-- Sección D.9
SELECT Grupo.SiglaCurso, Grupo.NumGrupo, Grupo.Semestre, Grupo.Anno, MIN(Lleva.Nota) AS NotaMinima, MAX(Lleva.Nota) AS NotaMaxima, AVG(Lleva.Nota) AS PromedioNota
FROM Grupo JOIN Lleva ON 
Grupo.SiglaCurso = Lleva.SiglaCurso AND 
Grupo.NumGrupo = Lleva.NumGrupo AND 
Grupo.Semestre = Lleva.Semestre AND 
Grupo.Anno = Lleva.Anno
WHERE Lleva.Nota >= 70
GROUP By Grupo.SiglaCurso, Grupo.NumGrupo, Grupo.Semestre, Grupo.Anno
ORDER by PromedioNota

/* Fin de lab3. 
Fabián Orozco Chaves - B95690
UCR | ECCI | Bases de Datos | II Ciclo - 2022 */
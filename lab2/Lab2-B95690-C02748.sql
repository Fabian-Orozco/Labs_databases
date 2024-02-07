/* Trabajo en parejas
  Fabián Orozco Chaves - B95690
  Daniel Escobar Giraldo - C02748 */

--USE B95690
--USE C02748

--SECCIÓN 3

CREATE TABLE Estudiante (
  Cedula CHAR(10) PRIMARY KEY,
  Email VARCHAR(50),
  Nombre VARCHAR(15) NOT NULL,
  Apellido1 VARCHAR(15) NOT NULL,
  Apellido2 VARCHAR(15),
  Sexo CHAR(1),
  FechaNac DATE NOT NULL,
  Direccion VARCHAR(80),
  Telefono CHAR(8),
  Carne VARCHAR(10),
  Estado VARCHAR(8),
)

CREATE TABLE Profesor (
  Cedula CHAR(10) PRIMARY KEY,
  Email VARCHAR(50),
  Nombre VARCHAR(15) NOT NULL,
  Apellido1 VARCHAR(15) NOT NULL,
  Apellido2 VARCHAR(15),
  Sexo CHAR(1),
  FechaNac DATE NOT NULL,
  Direccion VARCHAR(80),
  Telefono CHAR(8),
  Categoria VARCHAR(20),
  FechaNombramiento DATE,
  Titulo VARCHAR(15),
  Oficina TINYINT
)


CREATE TABLE Asistente (
  Cedula CHAR(10) PRIMARY KEY,
  NumHoras TINYINT,
  FOREIGN KEY (Cedula) REFERENCES Estudiante(Cedula)
  ON DELETE CASCADE
)

CREATE TABLE Curso (
  Sigla VARCHAR(8) PRIMARY KEY,
  Nombre VARCHAR(40),
  Creditos TINYINT,
)

CREATE TABLE Grupo (
  SiglaCurso VARCHAR(8) NOT NULL,
  NumGrupo TINYINT,
  Semestre TINYINT,
  Año INT,
  CedProf CHAR(10) NOT NULL,
  Carga TINYINT DEFAULT 0,
  CedAsist CHAR(10)

  PRIMARY KEY(SiglaCurso, NumGrupo, Semestre, Año),
  FOREIGN KEY(SiglaCurso) REFERENCES Curso(Sigla)
  ON DELETE NO ACTION,
  FOREIGN KEY(CedAsist) REFERENCES Asistente(Cedula)
  ON DELETE CASCADE,
  FOREIGN KEY(CedProf) REFERENCES Profesor(Cedula)
  ON UPDATE CASCADE
)

CREATE TABLE Lleva (
  CedEstudiante CHAR(10),
  SiglaCurso VARCHAR(8),
  NumGrupo TINYINT,
  Semestre TINYINT,
  Año INT,
  Nota FLOAT check (Nota BETWEEN 0 and 100),
  PRIMARY KEY (CedEstudiante, SiglaCurso, NumGrupo, Semestre, Año),
  FOREIGN KEY (CedEstudiante) REFERENCES Estudiante(Cedula)
  ON DELETE CASCADE,
  FOREIGN KEY (SiglaCurso, NumGrupo, Semestre, Año) REFERENCES Grupo(SiglaCurso, NumGrupo, Semestre, Año)
)

CREATE TABLE Carrera (
  Codigo VARCHAR(10) PRIMARY KEY,
  Nombre VARCHAR(50),
  AñoCreacion DATE,
)

CREATE TABLE Empadronado_en (
  CedEstudiante CHAR(10),
  CodCarrera VARCHAR(10),
  FechaIngreso DATE,
  FechaGraduacion DATE,
  FOREIGN KEY (CedEstudiante) REFERENCES Estudiante(Cedula)
  ON DELETE CASCADE,
  FOREIGN KEY (CodCarrera) REFERENCES Carrera(Codigo),
  PRIMARY KEY (CedEstudiante, CodCarrera)
)

CREATE TABLE Pertenece_a (
  SiglaCurso VARCHAR(8),
  CodCarrera VARCHAR(10),
  NivelPlanEstudios TINYINT,
  FOREIGN KEY (SiglaCurso) REFERENCES Curso(Sigla),
  FOREIGN KEY (CodCarrera) REFERENCES Carrera(Codigo),
  PRIMARY KEY (SiglaCurso, CodCarrera)
) 

--SECCIÓN 4

--USE B95690
--USE C02748

INSERT INTO Estudiante VALUES ('0123456789', 'example@test.com', 'Julian', 'Keto','Americo','m','2001-08-01','Alajuela', '88888889','B87021','Moroso');
INSERT INTO Estudiante VALUES ('9999999999', 'ex@test.com', 'Karla', 'Gutierrez','Sansa','f','2002-09-02','Heredia', '61616161','C04798','Libre');

INSERT INTO Estudiante VALUES ('1111111111', 'example@test.com', 'Diego', 'Bonilla','Orozco','m','2003-08-01','Cartago', '62626262','C21111','Libre');
INSERT INTO Estudiante VALUES ('2222222222', 'ex@test.com', 'Kryscia', 'Orozco','Sensei','f','2002-01-03','Puntarenas', '64646567','C18888','Libre');

INSERT INTO Profesor VALUES ('208334954', 'exampleroberto@testing.com', 'Roberto', 'Perez', 'Arjona', 'M', '1980-09-02', 'Alajuela', '83749857', 'Interino','2002-09-02', 'Doctor', '25');
INSERT INTO Profesor VALUES ('307334977', 'examplepaula@testing.com', 'Paula', 'Giraldo', 'Lopez', 'F', '1981-10-02', 'Alajuela', '83547896', 'Catedratrico','2002-10-02', 'Licenciado', '26');

INSERT INTO Asistente VALUES ('0123456789', 4);
INSERT INTO Asistente VALUES ('9999999999', 6);

INSERT INTO Curso VALUES ('CI0126', 'INGENIERÍA DEL SOFTWARE', 4);
INSERT INTO Curso VALUES ('CI0127', 'BASE DE DATOS', 4);

INSERT INTO Grupo VALUES ('CI0126', 1, 2, 2014, '208334954', 4, '0123456789');
INSERT INTO Grupo VALUES ('CI0127', 2, 1, 2015, '307334977', 4, '9999999999');

INSERT INTO Lleva VALUES ('1111111111', 'CI0126', 1, 2, 2014, 90);
INSERT INTO Lleva VALUES ('2222222222', 'CI0127', 2, 1, 2015, 80);

INSERT INTO Carrera VALUES ('bach01Comp', 'Bachillerato en Computación e Informática', '1981-01-01');
INSERT INTO Carrera VALUES ('bach01IngE', 'Bachillerato en Ingeniería Eléctrica', '1988-04-05');

INSERT INTO Empadronado_en VALUES ('0123456789', 'bach01Comp', '2015-08-01', '2019-08-01');
INSERT INTO Empadronado_en VALUES ('9999999999', 'bach01IngE', '2017-11-11', '2021-10-01');

INSERT INTO Pertenece_a VALUES ('CI0126', 'bach01Comp', 4);
INSERT INTO Pertenece_a VALUES ('CI0127', 'bach01IngE', 3);

--SECCIÓN 5

--USE B95690
--USE C02748

/*Restriccion de ON DELETE CASCADE 3)b.ii*/
-- 5.a
SELECT * from Estudiante -- referenciada
-- 5.b
SELECT * from Empadronado_en -- contiene referencia

-- 5.c
DELETE FROM Estudiante
WHERE Cedula='9999999999'

/*Restriccion de ON DELETE NO ACTION 3)b.iii*/
-- 5.a
SELECT * FROM Curso -- referenciada
-- 5.b
SELECT * FROM Grupo -- contiene referencia

DELETE FROM Curso
WHERE Sigla = 'CI0126'

/*Restriccion de ON UPDATE CASCADE 3)b.iv*/
-- 5.a
SELECT * FROM Profesor -- referenciada
-- 5.b
SELECT * FROM Grupo -- contiene referencia

UPDATE Profesor
Set Cedula = '1231231234'
WHERE Cedula = '208334954'

SELECT * FROM Profesor
SELECT * FROM Grupo

/* Fin de lab2. 
Fabián Orozco Chaves - B95690
Daniel Escobar Giraldo - C02748
UCR | ECCI | Bases de Datos | II Ciclo - 2022 */

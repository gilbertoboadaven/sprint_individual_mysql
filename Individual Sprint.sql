# Creacion de la base de datos
CREATE SCHEMA IF NOT EXISTS yoquierootromundosprint;

# Creacion del usuario
CREATE USER IF NOT EXISTS 'yoquierootromundosprint'@'localhost' IDENTIFIED BY 'yoquierootromundosprint';

#  Asignamos los privilegios al usuario
GRANT ALL PRIVILEGES ON yoquierootromundosprint.* TO yoquierootromundosprint@localhost;
FLUSH PRIVILEGES;

# Asignamos la base de datos con la que vamos a trabajar
USE yoquierootromundosprint;

# Creamos la tabla para los usuarios
CREATE TABLE Usuarios(
	id_usuario INT AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(45), 
    apellido VARCHAR(45), 
    edad INT, 
    correo_electronico VARCHAR(255),
    encuestas INT DEFAULT 1,
    PRIMARY KEY (id_usuario)
);

# Creamos 5 usuarios
INSERT INTO Usuarios (nombre,apellido,edad,correo_electronico,encuestas)
VALUES 	('Usuario 1','Riquelme',18,'correo1@ejemplo.com',10),
		('Usuario 2','Perez',20,'correo1@ejemplo.com',5),
		('Usuario 3','Jimenez',35,'correo1@ejemplo.com',28),
		('Usuario 4','Smith',50,'correo1@ejemplo.com',3),
		('Usuario 5','Ugakde',45,'correo1@ejemplo.com',20)
		;

# Creamos 5 operarios
CREATE TABLE Operarios (
	id_operario INT AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(45), 
    apellido VARCHAR(45),
    edad INT , 
    correo_electronico VARCHAR(255),
    soportes INT DEFAULT 1,
    PRIMARY KEY(id_operario)
);

# Creamos 5 operarios
INSERT INTO Operarios (nombre,apellido,edad,correo_electronico,soportes)
VALUES 	('Operario 1','Riquelme',18,'correo1@ejemplo.com',10),
		('Operario 2','Perez',20,'correo1@ejemplo.com',5),
		('Operario 3','Jimenez',35,'correo1@ejemplo.com',28),
		('Operario 4','Smith',50,'correo1@ejemplo.com',3),
		('Operario 5','Ugalde',45,'correo1@ejemplo.com',20);


# Creamos la tabla operaciones 
# Esta tabla tendra 2 llaves foraneas una a la 
# tabla usuarios y otra a la tabla operario.
CREATE TABLE Operaciones (
	id_operacion INT AUTO_INCREMENT,
	id_usuario INT,
    id_operario INT,
    evaluacion INT,
    comentario VARCHAR(150),
    PRIMARY KEY(id_operacion),
    INDEX operaciones_id_usuario_idx (`id_usuario` ASC) VISIBLE,
	INDEX operaciones_id_operario_idx (`id_operario` ASC) VISIBLE,
    CONSTRAINT operaciones_id_operario_fk FOREIGN KEY (id_operario) REFERENCES Operarios(id_operario),
    CONSTRAINT operaciones_id_usuario_fk FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario)
);

# Creamos 10 operaciones
INSERT INTO Operaciones (id_usuario,id_operario,evaluacion,comentario)
VALUES 	(1,1,'7','Comentario '),
		(2,1,'6','Comentario '),
		(2,2,'2','Comentario '),
		(3,2,'1','Comentario '),
		(3,2,'3','Comentario '),
		(3,3,'2','Comentario '),
		(4,4,'1','Comentario '),
		(4,4,'6','Comentario '),
		(5,5,'5','Comentario '),
		(5,5,'4','Comentario ');

# Seleccione las 3 operaciones con mejor evaluación.
SELECT * 
FROM operaciones
ORDER BY evaluacion DESC
LIMIT 3;

# Seleccione las 3 operaciones con menos evaluación.
SELECT * 
FROM operaciones
ORDER BY evaluacion ASC
LIMIT 3;

# Seleccione al operario que más soportes ha realizado.
# Usamos un join para mostrar todos los atributos del operario
SELECT Operarios.*,count(*) AS soportes
FROM Operaciones
JOIN Operarios
ON Operaciones.id_operario = Operarios.id_operario
GROUP BY operaciones.id_operario
ORDER BY soportes DESC
LIMIT 1;

# Seleccione al cliente que menos veces ha utilizado la aplicación.
# Usamos un join para mostrar los atributos a la tabla usuarios
SELECT Usuarios.*,count(*) AS encuestas
FROM Operaciones
JOIN Usuarios
ON Operaciones.id_usuario = Usuarios.id_usuario
GROUP BY operaciones.id_usuario
ORDER BY encuestas ASC
LIMIT 1;

# Agregue 10 años a los tres primeros usuarios registrados.
UPDATE usuarios 
SET edad = edad + 10 
LIMIT 3;

# Renombre todas las columnas ‘correo electrónico’. El nuevo nombre debe ser email.
ALTER TABLE usuarios RENAME COLUMN correo_electronico TO email;
ALTER TABLE operarios RENAME COLUMN correo_electronico TO email;

# Seleccione solo los operarios mayores de 20 años.
SELECT * FROM operarios WHERE edad > 20;


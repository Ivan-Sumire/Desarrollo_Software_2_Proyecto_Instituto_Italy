-- DROP DATABASE instituto; -- No es necesario si aún no existe

CREATE DATABASE IF NOT EXISTS instituto;

USE instituto;

-- Tabla de profesores
CREATE TABLE profesor (
    id_profesor INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL,
    profesion VARCHAR(100),
    email VARCHAR(255), -- Agregado
    estado BOOLEAN
) ENGINE=INNODB;

-- Tabla de alumnos
CREATE TABLE alumnos (
    id_alumno INT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido_paterno VARCHAR(100) NOT NULL,
    apellido_materno VARCHAR(100) NOT NULL,
    email VARCHAR(50), -- Agregado
    telefono varchar(15),
    estado BOOLEAN
) ENGINE=INNODB;


-- Tabla de materias
CREATE TABLE materias (
    id_materia INT PRIMARY KEY,
    id_profesor int,
    id_alumno int,
    nombre VARCHAR(100) NOT NULL,
    clave VARCHAR(20) NOT NULL,
    created_at DATETIME, -- Cambiado
    updated_at DATETIME, -- Cambiado
    CONSTRAINT fk_materias_profesor 
    FOREIGN KEY (id_profesor) REFERENCES profesor(id_profesor),
    CONSTRAINT fk_materias_alumno 
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno)
) ENGINE=INNODB;


CREATE TABLE matricula (
    id_matricula INT PRIMARY KEY,
    id_alumno int(10),
    id_materia int(10),
    detalles varchar (10),
    estado bool,
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
    
) ENGINE=INNODB;

-- Tabla de horarios
CREATE TABLE horarios (
    id_horario INT PRIMARY KEY,
    dia VARCHAR(10),
    id_materia INT(10) NOT NULL,
    hora_inicio TIME, -- Cambiado
    hora_fin TIME, -- Cambiado
    estado boolean,
    CONSTRAINT fk_horarios_materias 
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
    
) ENGINE=INNODB;

-- Tabla de asistencia
CREATE TABLE asistencia (
    id_asistencia INT PRIMARY KEY,
    id_alumno INT(10) NOT NULL,
    fecha DATE,
    hora TIME,
    estado BOOLEAN, -- Agregado
    CONSTRAINT fk_asistencia_alumnos 
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno)
) ENGINE=INNODB;

-- Tabla de calificaciones
CREATE TABLE calificaciones (
    id_calificacion INT PRIMARY KEY,
    id_alumno INT(10) NOT NULL,
    id_materia int(10),
    calificacion DECIMAL(5, 2), -- Ajustado
    fecha DATETIME, -- Cambiado
    CONSTRAINT fk_calificaciones_alumnos 
    FOREIGN KEY (id_alumno) REFERENCES alumnos(id_alumno),
    FOREIGN KEY (id_materia) REFERENCES materias(id_materia)
) ENGINE=INNODB;


INSERT INTO profesor (id_profesor, nombre, apellido_paterno, apellido_materno, profesion, email, estado)
VALUES
(1001, 'Juan', 'Gomez', 'Perez', 'Matemáticas', 'juan.gomez@example.com', 1),
(1002, 'Ana', 'Rodriguez', 'Lopez', 'Historia', 'ana.rodriguez@example.com', 1),
(1003, 'Pedro', 'Diaz', 'Fernandez', 'Ciencias', 'pedro.diaz@example.com', 1),
(1004, 'María', 'Martinez', 'Gutierrez', 'Literatura', 'maria.martinez@example.com', 1),
(1005, 'Carlos', 'Garcia', 'Vega', 'Física', 'carlos.garcia@example.com', 1),
(1006, 'Sofia', 'Perez', 'Ramirez', 'Inglés', 'sofia.perez@example.com', 1),
(1007, 'Alejandro', 'Lopez', 'Hernandez', 'Química', 'alejandro.lopez@example.com', 1),
(1008, 'Laura', 'Fernandez', 'Torres', 'Arte', 'laura.fernandez@example.com', 1),
(1009, 'Javier', 'Vega', 'Gomez', 'Educación Física', 'javier.vega@example.com', 1),
(1010, 'Marta', 'Ramirez', 'Diaz', 'Informática', 'marta.ramirez@example.com', 1);


INSERT INTO alumnos (id_alumno, nombre, apellido_paterno, apellido_materno, email, telefono, estado)
VALUES
(2001, 'Luis', 'Gonzalez', 'Hernandez', 'luis.gonzalez@example.com', '123456789', 1),
(2002, 'Elena', 'Lopez', 'Fernandez', 'elena.lopez@example.com', '987654321', 1),
(2003, 'Pablo', 'Martinez', 'Gomez', 'pablo.martinez@example.com', '111222333', 1),
(2004, 'Isabel', 'Gomez', 'Rodriguez', 'isabel.gomez@example.com', '444555666', 1),
(2005, 'Andres', 'Fernandez', 'Lopez', 'andres.fernandez@example.com', '777888999', 1),
(2006, 'Ana', 'Diaz', 'Perez', 'ana.diaz@example.com', '555444333', 1),
(2007, 'Sergio', 'Ramirez', 'Garcia', 'sergio.ramirez@example.com', '999888777', 1),
(2008, 'Carmen', 'Vega', 'Torres', 'carmen.vega@example.com', '666777888', 1),
(2009, 'Mario', 'Torres', 'Fernandez', 'mario.torres@example.com', '333222111', 1),
(2010, 'Natalia', 'Hernandez', 'Lopez', 'natalia.hernandez@example.com', '111222333', 1);

INSERT INTO materias (id_materia, id_profesor, id_alumno, nombre, clave, created_at, updated_at)
VALUES
(3001, 1001, 2001, 'Matemáticas I', 'MAT101', '2024-01-01 08:00:00', '2024-01-01 12:00:00'),
(3002, 1002, 2002, 'Historia Universal', 'HIS201', '2024-01-02 09:00:00', '2024-01-02 13:00:00'),
(3003, 1003, 2003, 'Química Orgánica', 'QUI301', '2024-01-03 10:00:00', '2024-01-03 14:00:00'),
(3004, 1004, 2004, 'Literatura Clásica', 'LIT401', '2024-01-04 11:00:00', '2024-01-04 15:00:00'),
(3005, 1005, 2005, 'Física Aplicada', 'FIS501', '2024-01-05 12:00:00', '2024-01-05 16:00:00'),
(3006, 1006, 2006, 'Inglés Avanzado', 'ING601', '2024-01-06 13:00:00', '2024-01-06 17:00:00'),
(3007, 1007, 2007, 'Química Analítica', 'QUI701', '2024-01-07 14:00:00', '2024-01-07 18:00:00'),
(3008, 1008, 2008, 'Arte Contemporáneo', 'ART801', '2024-01-08 15:00:00', '2024-01-08 19:00:00'),
(3009, 1009, 2009, 'Educación Física I', 'EDF901', '2024-01-09 16:00:00', '2024-01-09 20:00:00'),
(3010, 1010, 2010, 'Programación en Python', 'PROG101', '2024-01-10 17:00:00', '2024-01-10 21:00:00');


INSERT INTO matricula (id_matricula, id_alumno, id_materia, detalles, estado)
VALUES
(4001, 2001, 3001, 'Grupo A', 1),
(4002, 2002, 3002, 'Grupo B', 1),
(4003, 2003, 3003, 'Grupo C', 1),
(4004, 2004, 3004, 'Grupo D', 1),
(4005, 2005, 3005, 'Grupo E', 1),
(4006, 2006, 3006, 'Grupo F', 1),
(4007, 2007, 3007, 'Grupo G', 1),
(4008, 2008, 3008, 'Grupo H', 1);

INSERT INTO horarios (id_horario, dia, id_materia, hora_inicio, hora_fin, estado)
VALUES
(5001, 'Lunes', 3001, '08:00:00', '10:00:00', 1),
(5002, 'Martes', 3002, '09:00:00', '11:00:00', 1),
(5003, 'Miércoles', 3003, '10:00:00', '12:00:00', 1),
(5004, 'Jueves', 3004, '11:00:00', '13:00:00', 1),
(5005, 'Viernes', 3005, '12:00:00', '14:00:00', 1),
(5006, 'Sábado', 3006, '13:00:00', '15:00:00', 1),
(5007, 'Domingo', 3007, '14:00:00', '16:00:00', 1),
(5008, 'Lunes', 3008, '15:00:00', '17:00:00', 1),
(5009, 'Martes', 3009, '16:00:00', '18:00:00', 1),
(5010, 'Miércoles', 3010, '17:00:00', '19:00:00', 1);

INSERT INTO asistencia (id_asistencia, id_alumno, fecha, hora, estado)
VALUES
(6001, 2001, '2024-02-01', '08:15:00', 1),
(6002, 2002, '2024-02-02', '09:30:00', 1),
(6003, 2003, '2024-02-03', '10:45:00', 1),
(6004, 2004, '2024-02-04', '11:00:00', 1),
(6005, 2005, '2024-02-05', '12:30:00', 1),
(6006, 2006, '2024-02-06', '13:45:00', 1),
(6007, 2007, '2024-02-07', '14:15:00', 1),
(6008, 2008, '2024-02-08', '15:45:00', 1),
(6009, 2009, '2024-02-09', '16:00:00', 1),
(6010, 2010, '2024-02-10', '17:30:00', 1);

INSERT INTO calificaciones (id_calificacion, id_alumno, id_materia, calificacion, fecha)
VALUES
(7001, 2001, 3001, 90.5, '2024-02-15 09:00:00'),
(7002, 2002, 3002, 85.0, '2024-02-16 10:15:00'),
(7003, 2003, 3003, 78.5, '2024-02-17 11:30:00'),
(7004, 2004, 3004, 92.0, '2024-02-18 12:45:00'),
(7005, 2005, 3005, 87.5, '2024-02-19 14:00:00'),
(7006, 2006, 3006, 95.0, '2024-02-20 15:15:00'),
(7007, 2007, 3007, 88.5, '2024-02-21 16:30:00'),
(7008, 2008, 3008, 91.0, '2024-02-22 17:45:00'),
(7009, 2009, 3009, 82.5, '2024-02-23 18:00:00'),
(7010, 2010, 3010, 89.0, '2024-02-24 19:15:00');




select* from alumnos;

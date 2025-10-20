-- Crea un usuario para las bases de datos usando el nombre ‘appointments_user’.
-- Asigne a estos todos los permisos sobre sus respectivas tablas. 
-- Habiendo creado este usuario evitaremos el uso de ‘root’ para el resto del trabajo práctico.
-- Adicionalmente, con respecto a esta base de datos:
-- Cree un usuario sólo con permisos para realizar consultas de selección, es decir que no puedan realizar cambios en la base. 
-- Use el nombre ‘appointments_select’.
-- Cree un usuario que pueda realizar consultas de selección, inserción, actualización y eliminación a nivel de filas, pero que 
-- no puedan modificar el esquema. Use el nombre ‘appointments_update’.
-- Cree un usuario que tenga los permisos de los anteriores, pero que además pueda modificar el esquema de la base de datos. 
-- Use el nombre 'appointments_schema’.

CREATE USER IF NOT EXISTS 'appointments_user'@'localhost'
  IDENTIFIED BY 'CONTRA_REPIOLA_1';
CREATE USER IF NOT EXISTS 'appointments_select'@'localhost'
  IDENTIFIED BY 'CONTRA_REPIOLA_2';
CREATE USER IF NOT EXISTS 'appointments_update'@'localhost'
  IDENTIFIED BY 'CONTRA_REPIOLA_3';
CREATE USER IF NOT EXISTS 'appointments_schema'@'localhost'
  IDENTIFIED BY 'CONTRA_REPIOLA_4';

GRANT ALL PRIVILEGES
ON practica.*
TO 'appointments_user'@'localhost';

GRANT SELECT
ON practica.*
TO 'appointments_select'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE
ON practica.*
TO 'appointments_update'@'localhost';

GRANT SELECT, INSERT, UPDATE, DELETE,
      CREATE, ALTER, DROP, INDEX,
      CREATE VIEW, SHOW VIEW,
      CREATE ROUTINE, ALTER ROUTINE, EXECUTE,
      TRIGGER, EVENT
ON practica.*
TO 'appointments_schema'@'localhost';


-- TESTEO
FLUSH PRIVILEGES;

SHOW GRANTS FOR 'appointments_user'@'localhost';
SHOW GRANTS FOR 'appointments_select'@'localhost';
SHOW GRANTS FOR 'appointments_update'@'localhost';
SHOW GRANTS FOR 'appointments_schema'@'localhost';
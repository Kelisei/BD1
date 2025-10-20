-- Crear un Stored Procedure que realice los siguientes pasos dentro 
-- de una transacción:
-- Realizar la siguiente consulta: cada pacient (identificado por 
-- id_patient), calcule la
-- cantidad de appointments que tiene registradas. Registrar la 
-- fecha en la que se realiza esta carga y
-- además del usuario con el se realiza.
-- Guardar el resultado de la consulta en un cursor.
-- Iterar el cursor e insertar los valores correspondientes en 
-- la tabla APPOINTMENTS PER PATIENT.
-- Tenga en cuenta que last_update es la fecha en que se realiza 
-- esta carga, es decir la fecha actual,
-- mientras que user es el usuario logueado actualmente, utilizar
-- las correspondientes funciones para esto.

DROP PROCEDURE IF EXISTS ProcedureEjercicio1;

DELIMITER //
CREATE PROCEDURE ProcedureEjercicio1()
BEGIN
    DECLARE  id_paciente INT;
    DECLARE  cantidad_appointments INT;
    DECLARE  ts DATETIME;
    DECLARE  usuario VARCHAR(16);
    DECLARE done INT DEFAULT 0;


    DECLARE cur CURSOR FOR
        SELECT   
            p.patient_id,
            COUNT(a.appointment_date) AS appointment_count,
            NOW()              AS load_timestamp,
            LEFT(CURRENT_USER(),16) AS executed_by
        FROM Patient AS p
        LEFT JOIN Appointment AS a
            ON a.patient_id = p.patient_id
        GROUP BY p.patient_id;

    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;  
    END;
    
    START TRANSACTION;
    OPEN cur;
    read_loop: LOOP
        FETCH cur INTO id_paciente, cantidad_appointments, ts, usuario;
        IF done THEN
            LEAVE read_loop;
        END IF;
        INSERT INTO appointments_per_patient (id_patient,count_appointments,last_update,`user`) 
         VALUES (id_paciente, cantidad_appointments, ts, usuario);
    END LOOP;
    CLOSE cur; 

    COMMIT;
END //
DELIMITER ;
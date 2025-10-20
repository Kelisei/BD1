-- Crear un stored procedure que sirva para agregar un appointment, junto el registro de un doctor que lo atendió (medical_review) y 
-- un medicamento que se le recetó (prescribed_medication), dentro de una sola transacción. El stored procedure debe recibir los 
-- siguientes parámetros: patient_id, doctor_id, appointment_duration, contact_phone, appointment_address, medication_name. El
--  appointment_date será la fecha actual. Los atributos restantes deben ser obtenidos de la tabla Patient (o dejarse en NULL).

DROP PROCEDURE IF EXISTS EJERCICIO4;
DELIMITER //

CREATE PROCEDURE EJERCICIO4(
    IN id INT,
    IN p_doctor_id INT,
    IN p_appointment_duration INT,
    IN p_contact_phone VARCHAR(255),
    IN p_appointment_address VARCHAR(255),
    IN p_medication_name VARCHAR(255)
)
BEGIN
    DECLARE v_datenow DATETIME;
    DECLARE v_phone   VARCHAR(255);
    DECLARE v_address VARCHAR(255);

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;

    START TRANSACTION;

    SET v_datenow = NOW();

    SELECT 
        LEFT(COALESCE(p_contact_phone, pt.primary_phone, pt.secondary_phone), 45), 
        COALESCE(p_appointment_address, pt.patient_address)
    INTO v_phone, v_address
    FROM `patient` AS pt
    WHERE pt.`patient_name` = id;

    INSERT INTO appointment
        (patient_id, appointment_date, appointment_duration, contact_phone, observations)
    VALUES
        (id, v_datenow, p_appointment_duration, v_phone, v_address);


    INSERT INTO prescribed_medication (patient_id, appointment_date, medication_name)
    VALUES (id, v_datenow, p_medication_name);

    INSERT INTO medical_review (patient_id, appointment_date, doctor_id)
    VALUES (id, v_datenow, p_doctor_id);

    COMMIT;
END //
DELIMITER ;


CALL EJERCICIO4(
    10004427,
    1003,
    30,
    '+54 15 2913 9963',
    'Hospital Italiano',
    'Paracetamol'
);

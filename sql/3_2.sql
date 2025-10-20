-- Crear un Trigger de modo que al insertar un dato en la tabla Appointment, se actualice la cantidad de appointments del paciente, 
-- la fecha de actualización y el usuario responsable de la misma (actualiza la tabla APPOINTMENTS PER PATIENT).

DELIMITER //

DROP TRIGGER IF EXISTS actualizar_cantidad_de_appointments//
CREATE TRIGGER actualizar_cantidad_de_appointments
AFTER INSERT ON Appointment
FOR EACH ROW
BEGIN
  INSERT INTO appointments_per_patient (id_patient, count_appointments, last_update, user)
  VALUES (NEW.patient_id, 1, NOW(), CURRENT_USER())
  ON DUPLICATE KEY UPDATE
      count_appointments = count_appointments + 1,
      last_update = NOW(),
      user = CURRENT_USER();
END//

DELIMITER ;


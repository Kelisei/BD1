-- Crear una vista llamada ‘doctors_per_patients’ que muestre los id de los pacientes y los id de doctores de la 
-- ciudad donde vive el paciente.

CREATE VIEW doctors_per_patients AS
SELECT p.patient_id, d.doctor_id
FROM Patient as p 
LEFT JOIN Doctor as d 
    ON p.patient_city = d.doctor_city;

-- TEST
SELECT * FROM doctors_per_patients;

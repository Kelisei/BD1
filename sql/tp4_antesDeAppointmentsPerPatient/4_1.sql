-- Utiliza la vista generada en el ejercicio anterior para resolver las siguientes consultas:

-- Obtener la cantidad de doctores por cada paciente que tiene disponible en su ciudad
SELECT 
  patient_id, 
  COUNT(doctor_id) AS cantidad_doctores
FROM doctors_per_patients
GROUP BY patient_id;

-- Obtener los nombres de los pacientes sin doctores en su ciudad
SELECT 
  patient_id AS pacientes_sin_doctores
FROM doctors_per_patients
GROUP BY patient_id
HAVING COUNT(doctor_id) = 0;

-- Obtener los doctores que comparten ciudad con más de cinco pacientes.
SELECT 
  doctor_id AS doctores_con_mas_de_5_pacientes_en_su_ciudad
FROM doctors_per_patients
GROUP BY doctor_id
HAVING COUNT(DISTINCT(patient_id)) > 5;

EXPLAIN select count(a.patient_id)
from appointment a, patient p, doctor d, medical_review mr
where a.patient_id= p.patient_id
and a.patient_id= mr.patient_id
and a.appointment_date=mr.appointment_date
and mr.doctor_id = d.doctor_id
and d.doctor_specialty = 'Cardiology'
and p.patient_city = 'Rosario';

-- Analice su plan de ejecución mediante el uso de la sentencia EXPLAIN.

-- Enter password: 
-- id      select_type     table   partitions      type    possible_keys   key     key_len ref     rows    filtered        Extra
-- 1       SIMPLE  d       NULL    ALL     PRIMARY NULL    NULL    NULL    100     10.00   Using where
-- 1       SIMPLE  p       NULL    ALL     PRIMARY NULL    NULL    NULL    1000    10.00   Using where; Using join buffer (hash join)
-- 1       SIMPLE  mr      NULL    ref     PRIMARY,doctor_id       doctor_id       8       practica.d.doctor_id,practica.p.patient_id      1       100.00  Using index
-- 1       SIMPLE  a       NULL    eq_ref  PRIMARY PRIMARY 9       practica.p.patient_id,practica.mr.appointment_date      1       100.00  Using index

-- ¿Qué atributos del plan de ejecución encuentra relevantes para evaluar la performance de la consulta?
-- Nos fijamos en el tipo de select, las keys o posibles keys (indices), rows o sea cuanto se lee, filtered cuantas van al where, extra.

-- Observe en particular el atributo type ¿cómo se están aplicando los JOIN entre las tablas involucradas?
-- Hay 2 tipos que son malos, es decir ALL, otro ref que es bueno y un eq_ref que es buenisimo. 

-- Según lo que observó en los puntos anteriores, ¿qué mejoras se pueden realizar para optimizar la consulta?

-- Habria que mejorar las consultas que no usan indices y agregarlos.

-- Aplique las mejoras propuestas y vuelva a analizar el plan de ejecución. ¿Qué cambios observa?

CREATE INDEX idx_doctor_specialty_id
  ON doctor(doctor_specialty, doctor_id);  

CREATE INDEX idx_patient_city_id
  ON patient(patient_city, patient_id);   

CREATE INDEX idx_mr_patient_date_doc
  ON medical_review(patient_id, appointment_date, doctor_id);

ANALYZE TABLE doctor, patient, medical_review, appointment;


EXPLAIN select count(a.patient_id)
from appointment a, patient p, doctor d, medical_review mr
where a.patient_id= p.patient_id
and a.patient_id= mr.patient_id
and a.appointment_date=mr.appointment_date
and mr.doctor_id = d.doctor_id
and d.doctor_specialty = 'Cardiology'
and p.patient_city = 'Rosario';

-- Table   Op      Msg_type        Msg_text
-- practica.doctor analyze status  OK
-- practica.patient        analyze status  OK
-- practica.medical_review analyze status  OK
-- practica.appointment    analyze status  OK
-- id      select_type     table   partitions      type    possible_keys   key     key_len ref     rows    filtered        Extra
-- 1       SIMPLE  p       NULL    ref     PRIMARY,idx_patient_city_id     idx_patient_city_id     768     const   82      100.00  Using index
-- 1       SIMPLE  mr      NULL    ref     PRIMARY,doctor_id,idx_mr_patient_date_doc       PRIMARY 4       practica.p.patient_id   28      100.00  Using index
-- 1       SIMPLE  d       NULL    eq_ref  PRIMARY,idx_doctor_specialty_id PRIMARY 4       practica.mr.doctor_id   1       19.00   Using where
-- 1       SIMPLE  a       NULL    eq_ref  PRIMARY PRIMARY 9       practica.p.patient_id,practica.mr.appointment_date      1       100.00  Using index
-- Hallar aquellos pacientes que para todas sus consultas médicas siempre hayan dejado su número de teléfono primario
-- (nunca el teléfono secundario).

SELECT DISTINCT p.patient_id 
FROM Patient AS p 
INNER JOIN Appointment as a 
    ON p.patient_id = a.patient_id
GROUP BY p.patient_id
HAVING SUM(p.secondary_phone = a.contact_phone) = 0 

-- Escribe y ejecute la sentencia correspondiente para crear la siguiente tabla:
-- APPOINTMENTS_PER_PATIENT
-- idApP: int(11) PK AI
-- id_patient: int(11)
-- count_appointments: int(11)
-- last_update: datetime
-- user: varchar(16)

CREATE TABLE appointments_per_patient (
    idApP INT(11) AUTO_INCREMENT PRIMARY KEY,
    id_patient INT(11),
    count_appointments INT(11),
    last_update DATETIME,
    user VARCHAR(16)
);

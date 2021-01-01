-- Question 2

ALTER TABLE census
ADD bmi float;

CREATE TABLE temp_census AS
SELECT census.*, patient_info.weight_kg, patient_info.height_cm
FROM patient_info
RIGHT JOIN census ON census.id_Number = patient_info.id_Number
ORDER BY census.id_Number;

DROP TABLE census;

CREATE TABLE census AS
SELECT * FROM temp_census;

DROP TABLE temp_census;

UPDATE census
SET bmi = ROUND(CAST(census.weight_kg AS DECIMAL) / POWER(CAST(census.height_cm AS DECIMAL) / 100.00, 2), 3);

ALTER TABLE census
DROP COLUMN weight_kg, DROP COLUMN height_cm;

SELECT * FROM census;
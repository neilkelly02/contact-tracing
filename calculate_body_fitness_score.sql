ALTER TABLE census
ADD score float;
SELECT * FROM temp_census_exam_score;
CREATE TABLE temp_census_exam_score
SELECT census.*, patients_physical_exam.vital_cap, patients_physical_exam.metabolism, patients_physical_exam.exam_date
FROM patients_physical_exam
RIGHT JOIN census ON census.id_Number = patients_physical_exam.id_Number;

ALTER TABLE temp_census_exam_score
ADD score float;

UPDATE temp_census_exam_score
SET score = ((vital_cap/5200.0) + (metabolism/2800.0) + (1-(ABS(age-25.0))/75.0) + (1-(ABS(bmi-23.0))/30.0)) * 25.0;

CREATE table temp_maxdate_census_exam_score
(SELECT temp_census_exam_score.*
FROM
(SELECT id_Number, MAX(exam_date) AS exam_date
FROM temp_census_exam_score
GROUP BY id_Number) AS most_recent_exams
INNER JOIN temp_census_exam_score
ON temp_census_exam_score.id_Number = most_recent_exams.id_Number 
AND temp_census_exam_score.exam_date = most_recent_exams.exam_date);

SELECT * FROM temp_maxdate_census_exam_score;

ALTER TABLE census
DROP COLUMN score;

CREATE TABLE census_avgscore AS
SELECT census.*, temp_maxdate_census_exam_score.score
FROM census
LEFT JOIN temp_maxdate_census_exam_score
ON census.id_Number = temp_maxdate_census_exam_score.id_Number;

UPDATE census_avgscore
SET score = (SELECT AVG(score) FROM temp_maxdate_census_exam_score)
WHERE score IS NULL;

DROP TABLE census;

CREATE TABLE census
SELECT * FROM census_avgscore;

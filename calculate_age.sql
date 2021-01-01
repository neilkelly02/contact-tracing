-- Question 1
ALTER TABLE zvoid.census
ADD age bigint;

UPDATE zvoid.census SET age = id_Number;

UPDATE census
SET census.age = 2020-substring(id_Number, 6, 4);

SELECT * FROM zvoid.census;


CREATE TABLE temp_audiences_score AS
SELECT audiences.*, census.score
FROM audiences
LEFT JOIN census
ON audiences.id_Number = census.id_Number;

CREATE TABLE temp_audiences_score_testres AS
SELECT temp_audiences_score.*, zovid12test.result AS test_result
FROM temp_audiences_score
LEFT JOIN zovid12test
ON temp_audiences_score.id_Number = zovid12test.id_Number;

DROP TABLE audiences;

CREATE TABLE audiences AS
SELECT temp_audiences_score_testres.*
FROM temp_audiences_score_testres;

DROP TABLE temp_audiences_score;
DROP TABLE temp_audiences_score_testres;

SELECT * FROM audiences;
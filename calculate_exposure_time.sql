ALTER TABLE AUDIENCES
ADD exposure_time float;

UPDATE audiences
SET exposure_time = FLOOR(audiences.score*.06);
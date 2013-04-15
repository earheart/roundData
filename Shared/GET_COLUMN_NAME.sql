DROP FUNCTION IF EXISTS GET_COLUMN_NAME;
CREATE FUNCTION `GET_COLUMN_NAME`(FIELD_NAME_IN VARCHAR(255), TABLE_NAME_IN VARCHAR(255)) RETURNS VARCHAR(255) CHARSET LATIN1
BEGIN
     DECLARE COLUMN_NAME_OUT VARCHAR(255);
     SET COLUMN_NAME_OUT = 
       (SELECT COLUMN_NAME FROM RJ_FIELD WHERE FIELD_NAME = FIELD_NAME_IN AND TABLE_NAME = TABLE_NAME_IN); 
	RETURN COLUMN_NAME_OUT;
END;
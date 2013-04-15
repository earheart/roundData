DROP FUNCTION IF EXISTS GET_API_FIELD_LIST;
CREATE FUNCTION GET_API_FIELD_LIST(OBJECT_NAME_IN VARCHAR(255)) RETURNS VARCHAR(5000) CHARSET LATIN1
BEGIN
     DECLARE FIELD_LABEL_OUT VARCHAR(5000);
     SET FIELD_LABEL_OUT = 
       (SELECT 
          GROUP_CONCAT(CONCAT(GET_VIEW_COLUMN(FIELD_NAME, OBJECT_NAME), ' AS ', (REPLACE(LABEL,'?',''))))
           FROM RC_ADMIN.RD_ARCHIVE_API A
          WHERE OBJECT_NAME = OBJECT_NAME_IN); 
	RETURN FIELD_LABEL_OUT;
END;
DROP FUNCTION if exists get_table_name;
CREATE FUNCTION get_table_name (object_name_in varchar(255)) RETURNS varchar(255)CHARSET latin1

BEGIN
     DECLARE table_name_out VARCHAR(255);
     SET table_name_out = 
       (select table_name from rj_object where OBJECT_NAME = object_name_in); 
	RETURN table_name_out;
END;
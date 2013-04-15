DROP FUNCTION IF EXISTS GET_VIEW_COLUMN;
CREATE FUNCTION `GET_VIEW_COLUMN`(FIELD_NAME_IN VARCHAR(255), OBJECT_NAME_IN VARCHAR(255)) RETURNS varchar(255) CHARSET latin1
BEGIN
     DECLARE COLUMN_NAME_OUT VARCHAR(255);
     SET COLUMN_NAME_OUT = 
       (SELECT  case when right(column_name,1) = 'x' then concat(upper(mid(column_name,1,1)) ,left(lower(mid(column_name,2,length(column_name) -1)), length(lower(mid(column_name,2,length(column_name) -2)))), upper(right(column_name,1))) when right(field_name,3) = '__c' then left(field_name, length(field_name) - length(right(field_name,3))) else field_name end 
       FROM RJ_FIELD
       JOIN RJ_OBJECT ON rj_field.TABLE_NAME = rj_object.TABLE_NAME
       WHERE OBJECT_NAME = OBJECT_NAME_IN 
       AND FIELD_NAME = FIELD_NAME_IN); 
	RETURN COLUMN_NAME_OUT;
END;

DROP PROCEDURE IF EXISTS GET_ARCHIVE_VIEW_DEF;
CREATE PROCEDURE `GET_ARCHIVE_VIEW_DEF`(OBJECT_NAME_IN VARCHAR(255))
BEGIN 

SET @TABLE_NAME = GET_TABLE_NAME(OBJECT_NAME_IN);
SET @SELECT    = CONCAT('create or replace view API_', OBJECT_NAME_IN, ' as select ');
SET @FIELD_LIST = GET_API_FIELD_LIST(OBJECT_NAME_IN);
SET @FROM      = CONCAT(' from V_', REPLACE(OBJECT_NAME_IN, '__C',''));

SET @DEF = (SELECT CONCAT(@SELECT,
                          @FIELD_LIST,               
                          @FROM) AS DEF);
                          
-- select @def;
-- select @table_name;
-- select @select;
-- select @field_list;
-- select @from;

PREPARE DEF_STMT FROM @DEF;
 
EXECUTE DEF_STMT;

DEALLOCATE PREPARE DEF_STMT;

END;

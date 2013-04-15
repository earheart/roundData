DROP FUNCTION IF EXISTS SYS_TRANSLATE;
CREATE FUNCTION `SYS_TRANSLATE`(in_value varchar(4000)
                      ,in_find varchar(4000)
                      ,in_replace varchar(4000)) RETURNS varchar(4000) CHARSET latin1
BEGIN

   DECLARE loop_cntr INT DEFAULT 1;
 
   WHILE loop_cntr <= LENGTH(in_find) DO
   
  
  SET in_value = REPLACE(in_value, SUBSTRING(in_find , loop_cntr, 1), SUBSTRING(in_replace, loop_cntr, 1));
  SET loop_cntr = loop_cntr + 1;
 
 END WHILE;
 RETURN in_value;
END;

DROP FUNCTION IF EXISTS GET_FIELD_LIST;
CREATE FUNCTION `GET_FIELD_LIST`(RANGE_IN INTEGER, TABLE_IN VARCHAR(255)) RETURNS varchar(25000) CHARSET latin1
    DETERMINISTIC
BEGIN
     DECLARE RESULT VARCHAR(25000);
     DECLARE LOWER_BOUND INTEGER(18);
     DECLARE UPPER_BOUND INTEGER(18);
     SET LOWER_BOUND = CASE WHEN RANGE_IN = 1 THEN 0  WHEN RANGE_IN = 2 THEN 50  WHEN RANGE_IN = 3 THEN 100 WHEN RANGE_IN = 4 THEN 150 WHEN RANGE_IN = 5 THEN 200 WHEN RANGE_IN = 6 THEN 250 WHEN RANGE_IN = 7 THEN 300 WHEN RANGE_IN = 8 THEN 350 WHEN RANGE_IN = 9 THEN 400 WHEN RANGE_IN = 10 THEN 450 ELSE 500  END;
     SET UPPER_BOUND = CASE WHEN RANGE_IN = 1 THEN 50 WHEN RANGE_IN = 2 THEN 100 WHEN RANGE_IN = 3 THEN 150 WHEN RANGE_IN = 4 THEN 200 WHEN RANGE_IN = 5 THEN 250 WHEN RANGE_IN = 6 THEN 300 WHEN RANGE_IN = 7 THEN 350 WHEN RANGE_IN = 8 THEN 400 WHEN RANGE_IN = 9 THEN 450 WHEN RANGE_IN = 10 THEN 500 ELSE 1000 END;
     SET RESULT =
    (
      SELECT (group_concat(field_list)) field_list
      FROM
      (
      SELECT @rownum:=@rownum+1 AS rank, (concat(COLUMN_NAME, ' as ', case when right(column_name,1) = 'x' then concat(upper(mid(column_name,1,1)) ,left(lower(mid(column_name,2,length(column_name) -1)), length(lower(mid(column_name,2,length(column_name) -2)))), upper(right(column_name,1))) when right(field_name,3) = '__c' then left(field_name, length(field_name) - length(right(field_name,3))) else field_name end, ' ')) FIELD_LIST
      FROM rj_field, (SELECT @rownum:=0) r
      WHERE TABLE_NAME = TABLE_IN
      and field_name <> 'ID__C'
      ) sel
      WHERE rank >= LOWER_BOUND
      AND rank < UPPER_BOUND
      AND FIELD_LIST IS NOT NULL
      );
     RETURN RESULT;
    END;

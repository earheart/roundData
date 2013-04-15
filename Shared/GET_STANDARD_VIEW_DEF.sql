DROP PROCEDURE IF EXISTS GET_STANDARD_VIEW_DEF;
CREATE PROCEDURE `GET_STANDARD_VIEW_DEF`(TABLE_NAME_IN VARCHAR(255), OBJECT_NAME_IN VARCHAR(255), ARCHIVE_FIELD_IN VARCHAR(255))
BEGIN 

SET @1 =  (select                                                                                    GET_FIELD_LIST(1,  TABLE_NAME_IN));
SET @2 =  (select concat(case when length(GET_FIELD_LIST(2,  TABLE_NAME_IN))>1 then ',' else '' end, GET_FIELD_LIST(2,  TABLE_NAME_IN)));
SET @3 =  (select concat(case when length(GET_FIELD_LIST(3,  TABLE_NAME_IN))>1 then ',' else '' end, GET_FIELD_LIST(3,  TABLE_NAME_IN)));
SET @4 =  (select concat(case when length(GET_FIELD_LIST(4,  TABLE_NAME_IN))>1 then ',' else '' end, GET_FIELD_LIST(4,  TABLE_NAME_IN)));
SET @5 =  (select concat(case when length(GET_FIELD_LIST(5,  TABLE_NAME_IN))>1 then ',' else '' end, GET_FIELD_LIST(5,  TABLE_NAME_IN)));
SET @6 =  (select concat(case when length(GET_FIELD_LIST(6,  TABLE_NAME_IN))>1 then ',' else '' end, GET_FIELD_LIST(6,  TABLE_NAME_IN)));
SET @7 =  (select concat(case when length(GET_FIELD_LIST(7,  TABLE_NAME_IN))>1 then ',' else '' end, GET_FIELD_LIST(7,  TABLE_NAME_IN)));
SET @8 =  (select concat(case when length(GET_FIELD_LIST(8,  TABLE_NAME_IN))>1 then ',' else '' end, GET_FIELD_LIST(8,  TABLE_NAME_IN)));
SET @9 =  (select concat(case when length(GET_FIELD_LIST(9,  TABLE_NAME_IN))>1 then ',' else '' end, GET_FIELD_LIST(9,  TABLE_NAME_IN)));
SET @10 = (select concat(case when length(GET_FIELD_LIST(10, TABLE_NAME_IN))>1 then ',' else '' end, GET_FIELD_LIST(10, TABLE_NAME_IN)));
SET @11 = (select concat(case when length(GET_FIELD_LIST(11, TABLE_NAME_IN))>1 then ',' else '' end, GET_FIELD_LIST(11, TABLE_NAME_IN)));

SET @SELECT    = CONCAT('create or replace view V_', OBJECT_NAME_IN, ' as select ');
SET @FROM      = CONCAT(' from ', TABLE_NAME_IN, ' where delete_flag <> \'Y\'');
SET @ARCHIVE   = CASE WHEN ARCHIVE_FIELD_IN = 'NONE' THEN '' ELSE CONCAT(' or (delete_flag = \'Y\' and ', ARCHIVE_FIELD_IN, ' = \'True\');') END;

SET @DEF = (SELECT CONCAT(@SELECT,
                                            case when length(@1)  > 0 then 
                          @1  else '*' end, case when length(@2)  > 0 then 
                          @2  else ''  end, case when length(@3)  > 0 then 
                          @3  else ''  end, case when length(@4)  > 0 then 
                          @4  else ''  end, case when length(@5)  > 0 then 
                          @5  else ''  end, case when length(@6)  > 0 then 
                          @6  else ''  end, case when length(@7)  > 0 then 
                          @7  else ''  end, case when length(@8)  > 0 then 
                          @8  else ''  end, case when length(@9)  > 0 then 
                          @9  else ''  end, case when length(@10) > 0 then 
                          @10 else ''  end, case when length(@11) > 0 then 
                          @11 else ''  end,
                          @FROM, 
                          @ARCHIVE) AS DEF);
                          

PREPARE DEF_STMT FROM @DEF;
 
EXECUTE DEF_STMT;
 
DEALLOCATE PREPARE DEF_STMT;

END;

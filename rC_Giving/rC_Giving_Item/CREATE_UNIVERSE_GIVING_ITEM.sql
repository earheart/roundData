DROP PROCEDURE IF EXISTS CREATE_UNIVERSE_GIVING_ITEM;
CREATE PROCEDURE CREATE_UNIVERSE_GIVING_ITEM()
BEGIN 

SET @FIELD_LIST = (select 
    group_concat(concat(
       CASE WHEN TABLE_NAME = 'OPPORTUNITYLINEITEM' THEN 'V_OPPORTUNITYLINEITEM' 
            WHEN TABLE_NAME = 'PRODUCT2' THEN 'V_PRODUCT2'
            WHEN TABLE_NAME = 'PRICEBOOK2' THEN 'V_PRICEBOOK2'
            WHEN TABLE_NAME = 'PRICEBOOKENTRY' THEN 'v_PRICEBOOKENTRY'
          ELSE TABLE_NAME
        END
        , 
        '.', COLUMN_NAME, ' as ', ifnull(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME)))
from RD_UNIDEF_GIVING_ITEM
where included = 'True'
and UNIVERSE_name = 'U_GIVING_ITEM'
order by RD_UNIDEF_GIVING_ITEM.orderby, record_number
);


SET @1 ='create or replace VIEW U_GIVING_ITEM as select ';
SET @2 = left(@FIELD_LIST, char_length(@FIELD_LIST) - 1);
SET @3 =' from v_opportunitylineitem join v_pricebookentry on v_pricebookentry.id = V_OPPORTUNITYLINEITEM.pricebookentryid join v_pricebook2 on v_pricebook2.ID = v_pricebookentry.PRICEBOOK2ID join v_product2 on v_product2.ID = v_pricebookentry.PRODUCT2ID';

SET @UNIVERSE_DEF = (SELECT CONCAT(@1, @2, @3) AS UNIVERSE_DEF);

PREPARE UNIVERSE_DEF_STMT FROM @UNIVERSE_DEF;

EXECUTE UNIVERSE_DEF_STMT;

DEALLOCATE PREPARE UNIVERSE_DEF_STMT;

END;
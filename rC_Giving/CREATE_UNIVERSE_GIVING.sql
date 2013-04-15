DROP PROCEDURE IF EXISTS CREATE_UNIVERSE_GIVING;
CREATE PROCEDURE `CREATE_UNIVERSE_GIVING`()
BEGIN 

SET @FIELD_LIST = (select 
    group_concat(concat(
       CASE WHEN TABLE_NAME = 'OPPORTUNITY' THEN 'V_OPPORTUNITY' 
            WHEN TABLE_NAME = 'RC_GIVING__GAU' THEN 'V_RC_GIVING_GAU'
            WHEN TABLE_NAME = 'CAMPAIGN' THEN 'V_CAMPAIGN'
          ELSE TABLE_NAME
        END
        , 
        '.', COLUMN_NAME, ' as ', ifnull(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME)))
from RD_UNIDEF_GIVING
where included = 'True'
and UNIVERSE_name = 'U_GIVING'
order by RD_UNIDEF_GIVING.orderby, record_number
);

SET @1 ='create or replace VIEW U_GIVING as select ';
SET @2 = left(@FIELD_LIST, char_length(@FIELD_LIST) - 1);
SET @3 =' from v_opportunity join v_campaign on v_campaign.id = v_opportunity.campaignid LEFT join V_RC_GIVING__GAU on v_opportunity.rc_giving__gau = V_RC_GIVING__GAU.id';


SET @UNIVERSE_DEF = (SELECT CONCAT(@1, @2, @3) AS UNIVERSE_DEF);

PREPARE UNIVERSE_DEF_STMT FROM @UNIVERSE_DEF;

EXECUTE UNIVERSE_DEF_STMT;

DEALLOCATE PREPARE UNIVERSE_DEF_STMT;

END;

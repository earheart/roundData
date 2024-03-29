DROP PROCEDURE IF EXISTS CREATE_UNIVERSE_GIVING_CREDIT;
CREATE PROCEDURE CREATE_UNIVERSE_GIVING_CREDIT()
BEGIN 

SET @FIELD_LIST = (select 
    group_concat(concat(
       CASE WHEN TABLE_NAME = 'OPPORTUNITY' THEN 'V_OPPORTUNITY' 
            WHEN TABLE_NAME = 'RC_GIVING__GAU' THEN 'V_RC_GIVING__GAU'
            WHEN TABLE_NAME = 'CAMPAIGN' THEN 'V_CAMPAIGN'
            WHEN TABLE_NAME = 'RC_GIVING__OPPORTUNITY_CREDIT' THEN 'V_RC_GIVING__OPPORTUNITY_CREDIT'
          ELSE TABLE_NAME
        END
        , 
        '.', COLUMN_NAME, ' as ', ifnull(UNIVERSE_FIELD_NAME_OVERRIDE, UNIVERSE_FIELD_NAME)))
from RD_UNIDEF_GIVING_CREDIT
where included = 'True'
and UNIVERSE_name = 'U_GIVING_CREDIT'
order by RD_UNIDEF_GIVING_CREDIT.orderby, record_number
);


SET @1 ='create or replace VIEW U_GIVING_CREDIT as select ';
SET @2 = left(@FIELD_LIST, char_length(@FIELD_LIST) - 1);
SET @3 =' from v_opportunity left join V_RC_GIVING__GAU on v_opportunity.RC_GIVING__GAU = V_RC_GIVING__GAU.ID left join v_campaign on v_opportunity.CAMPAIGNID = v_campaign.id left join V_RC_GIVING__OPPORTUNITY_CREDIT on V_RC_GIVING__OPPORTUNITY_CREDIT.RC_GIVING__OPPORTUNITY = v_opportunity.ID';

SET @UNIVERSE_DEF = (SELECT CONCAT(@1, @2, @3) AS UNIVERSE_DEF);

PREPARE UNIVERSE_DEF_STMT FROM @UNIVERSE_DEF;

EXECUTE UNIVERSE_DEF_STMT;

DEALLOCATE PREPARE UNIVERSE_DEF_STMT;

END;
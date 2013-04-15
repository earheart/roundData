DROP FUNCTION IF EXISTS SALUTATION_LINE_2_ACCOUNT;
CREATE FUNCTION SALUTATION_LINE_2_ACCOUNT(ACCOUNTID_IN varchar(18), SALUTATION_TYPE_IN VARCHAR(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
     DECLARE SAL_LINE_2 VARCHAR(255);
     SET SAL_LINE_2 =
          (
            SELECT replace(rc_bios__salutation_line_2,',','')
              FROM v_salutation
             WHERE rc_bios__ACCOUNT = ACCOUNTID_IN
               AND RC_BIOS__SALUTATION_TYPE = SALUTATION_TYPE_IN
             order by ordernumber
             limit 1);
     RETURN SAL_LINE_2;
    END;
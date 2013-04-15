DROP FUNCTION IF EXISTS SALUTATION_LINE_1_ACCOUNT;
CREATE FUNCTION SALUTATION_LINE_1_ACCOUNT(ACCOUNTID_IN varchar(18), SALUTATION_TYPE_IN VARCHAR(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
     DECLARE SAL_LINE_1 VARCHAR(255);
     SET SAL_LINE_1 =
          (
          select salutation_line_1
            from
            (
            SELECT '2' as ordernumber,  replace(a.rc_bios__salutation, ',','') as salutation_line_1
              FROM v_account a
              where ID = ACCOUNTID_IN
            UNION
            SELECT '1', rc_bios__salutation_line_1
              FROM v_salutation
             WHERE rc_bios__ACCOUNT = ACCOUNTID_IN
               AND RC_BIOS__SALUTATION_TYPE = SALUTATION_TYPE_IN
             order by ordernumber
             limit 1) salutation_line_1
          );
     RETURN SAL_LINE_1;
    END;
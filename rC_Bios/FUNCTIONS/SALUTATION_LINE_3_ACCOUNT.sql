DROP FUNCTION IF EXISTS SALUTATION_LINE_3_ACCOUNT;
CREATE FUNCTION SALUTATION_LINE_3_ACCOUNT(ACCOUNTID_IN varchar(18), SALUTATION_TYPE_IN VARCHAR(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
     DECLARE SAL_LINE_3 VARCHAR(255);
     SET SAL_LINE_3 =
          (
          select salutation_line_3
            from
            (
            SELECT '2' ordernumber, replace(
              case when length(a.namex )>1 then c.namex else NULL end, ',', ' ') salutation_line_3
              FROM v_account A
              where a.typex not in ('Individual', 'Family', 'Prospect')
                and ID = ACCOUNTID_IN
            UNION
            SELECT '1', rc_bios__salutation_line_3
              FROM v_salutation
             WHERE rc_bios__ACCOUNT = ACCOUNID_IN
               AND RC_BIOS__SALUTATION_TYPE = SALUTATION_TYPE_IN
             order by ordernumber
             limit 1) salutation_line_3
          );
     RETURN SAL_LINE_3;
    END;
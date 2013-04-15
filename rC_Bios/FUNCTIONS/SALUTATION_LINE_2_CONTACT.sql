DROP FUNCTION IF EXISTS SALUTATION_LINE_2_CONTACT;
CREATE FUNCTION SALUTATION_LINE_2_CONTACT(CONTACTID_IN varchar(18), SALUTATION_TYPE_IN VARCHAR(255)) RETURNS varchar(240) CHARSET latin1
    DETERMINISTIC
BEGIN
     DECLARE SAL_LINE_2 VARCHAR(240);
     SET SAL_LINE_2 =
          (
          select salutation_line_2
            from
            (
            SELECT '2' ordernumber, replace(
                          case when length(c.TITLE)>1 then c.TITLE else NULL end,',',' ') salutation_line_2
              FROM v_contact c
             WHERE rc_bios__contact = CONTACTID_IN
            UNION
            SELECT '1', rc_bios__salutation_line_2
              FROM v_salutation
             WHERE rc_bios__contact = CONTACTID_IN
               AND RC_BIOS__SALUTATION_TYPE = SALUTATION_TYPE_IN
             limit 1) salutation_line_2
          );
     RETURN SAL_LINE_2;
    END;
DROP FUNCTION IF EXISTS SALUTATION_INSIDE_CONTACT;
CREATE FUNCTION SALUTATION_INSIDE_CONTACT(CONTACTID_IN varchar(18), SALUTATION_TYPE_IN VARCHAR(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
     DECLARE SAL_LINE_1 VARCHAR(255);
     SET SAL_LINE_1 =
          (SELECT inside_salutation
          FROM
          (
          SELECT '2' ordernumber, replace(
                    CASE
                       WHEN a.SALUTATION IS NOT NULL
                       THEN
                          concat(a.SALUTATION, ' ', a.LASTNAME)
                       ELSE
                          A.FIRSTNAME
                    END,
                    ',',
                    ' ') inside_salutation
            FROM v_contact a
           WHERE ID = CONTACTID_IN
          UNION
          SELECT '1', replace(rc_bios__inside_salutation,',',' ') inside_salutation
            FROM v_salutation
           WHERE rc_bios__contact = CONTACTID_IN
             AND RC_BIOS__SALUTATION_TYPE = SALUTATION_TYPE_IN
           ORDER BY ordernumber
           LIMIT 1) inside_sal);
     RETURN SAL_LINE_1;
    END;
DROP FUNCTION IF EXISTS SALUTATION_LINE_1_CONTACT;
CREATE FUNCTION SALUTATION_LINE_1_CONTACT(CONTACTID_IN varchar(18), SALUTATION_TYPE_IN VARCHAR(255)) RETURNS varchar(240) CHARSET latin1
    DETERMINISTIC
BEGIN
     DECLARE SAL_LINE_1 VARCHAR(255);
     SET SAL_LINE_1 =
          (select salutation_line_1
            from
            (
            SELECT '2' ordernumber, replace(
                      concat(
                          case when length(c.salutation)>1            then (concat(c.salutation, ' '))           else '' end,
                          case when length(c.firstname) >1            then (concat(c.firstname, ' '))            else '' end,
                          case when length(c.rc_bios__middle_name) >1 then (concat(c.rc_bios__middle_name, ' ')) else '' end,
                          case when length(c.lastname) >1             then (concat(c.lastname, ' '))             else '' end,
                          case when length(c.rc_bios__suffix) >1 then (concat(c.rc_bios__suffix, ' ')) else '' end),
                      ',',
                      ' ') salutation_line_1
              FROM v_contact c
             WHERE ID = CONTACTID_IN
            UNION
            SELECT '1', rc_bios__salutation_line_1
              FROM v_salutation
             WHERE rc_bios__contact = CONTACTID_IN
               AND RC_BIOS__SALUTATION_TYPE = SALUTATION_TYPE_IN
             order by ordernumber
             limit 1) salutation_line_1);
     RETURN SAL_LINE_1;
    END;
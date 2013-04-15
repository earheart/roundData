DROP FUNCTION IF EXISTS SALUTATION_INSIDE_ACCOUNT;
CREATE FUNCTION SALUTATION_INSIDE_ACCOUNT(ACCOUNTID varchar(18)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
      DECLARE SAL_LINE_1 VARCHAR(240);
      SET SAL_LINE_1 = 
        (SELECT replace(        
                                  case 
                          # no title and no secondary contact
                            when V_CONTACT_PRIMARY.SALUTATION is null and V_CONTACT_SECONDARY.ID is null
                              then IFNULL(V_CONTACT_PRIMARY.FIRSTNAME, 'Friend')
                          # both titles null and with secondary contact
                             when V_CONTACT_PRIMARY.SALUTATION is null and V_CONTACT_SECONDARY.SALUTATION is null and V_CONTACT_SECONDARY.ID is not null
                              then concat(IFNULL(V_CONTACT_PRIMARY.FIRSTNAME, 'Friend'),' and ', IFNULL(V_CONTACT_SECONDARY.FIRSTNAME, 'Friend'))
                          # both have titles and last names the same
                            when V_CONTACT_PRIMARY.SALUTATION is not null and V_CONTACT_SECONDARY.SALUTATION is not null and v_contact_secondary.LASTNAME = v_contact_primary.LASTNAME
                              then concat(V_CONTACT_PRIMARY.SALUTATION, ' and ', V_CONTACT_SECONDARY.SALUTATION, ' ',v_contact_PRIMARY.LASTNAME)
                          # both have titles and last names are different
                            when V_CONTACT_PRIMARY.SALUTATION is not null and V_CONTACT_SECONDARY.SALUTATION is not null and v_contact_secondary.LASTNAME <> v_contact_primary.LASTNAME
                             then concat(V_CONTACT_PRIMARY.SALUTATION, ' ', V_CONTACT_PRIMARY.LASTNAME,' and ', v_contact_secondary.SALUTATION, ' ', V_CONTACT_SECONDARY.LASTNAME)
                          # has title no secondary contact
                           when V_CONTACT_PRIMARY.SALUTATION is NOT null and V_CONTACT_SECONDARY.ID is null
                              then CONCAT(V_CONTACT_PRIMARY.SALUTATION, ' ' , v_contact_primary.LASTNAME)
                           # mismatch on title
                            when v_contact_primary.SALUTATION is not null and v_contact_SECONDARY.SALUTATION is null and v_contact_secondary.FIRSTNAME is not null
                             then concat( v_contact_PRIMARY.FIRSTNAME,' and ', v_contact_secondary.FIRSTNAME)
                          when v_contact_primary.SALUTATION is null and v_contact_SECONDARY.SALUTATION is NOT null and v_contact_secondary.FIRSTNAME is not null
                             then concat( v_contact_PRIMARY.FIRSTNAME,' and ', v_contact_secondary.FIRSTNAME)
                            end ,' ,', ' ')
             FROM  v_account
                   LEFT JOIN v_contact v_contact_primary 
                          ON 
                                 v_account.ID = v_contact_primary.ACCOUNTID 
                             AND v_contact_primary.id =  CONTACT_PRIMARY_GUID(v_account.ID)
                   LEFT JOIN v_contact v_contact_secondary 
                          ON 
                                 v_account.ID = v_contact_secondary.ACCOUNTID 
                             AND v_contact_secondary.ID = CONTACT_SECONDARY_GUID(v_account.ID)
        WHERE V_ACCOUNT.ID=ACCOUNTID
        limit 1);
     RETURN SAL_LINE_1;
    END;

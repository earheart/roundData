DROP FUNCTION IF EXISTS CONTACT_PRIMARY_GUID;
CREATE FUNCTION `CONTACT_PRIMARY_GUID`(ACCOUNTID_IN VARCHAR(18)) RETURNS varchar(18) CHARSET latin1
    DETERMINISTIC
BEGIN
     DECLARE CONTACT1 VARCHAR(18);
     SET CONTACT1 = 
    (
        select sel.ID
        from
          (select @rownum:=@rownum+1 as rank, c.*
             from V_CONTACT C
             , (SELECT @rownum:=0) r 
           where C.ACCOUNTID = ACCOUNTID_IN
          and C.RC_BIOS__MINOR_CHILD = 'false'
          and C.RC_BIOS__ACTIVE = 'true'
          and C.RC_BIOS__PREFERRED_CONTACT = 'true'
          order by createddate) SEL
          where SEL.rank = 1);
     RETURN CONTACT1;
    END;

DROP FUNCTION IF EXISTS PREFERENCE_CATEGORY;
CREATE FUNCTION `PREFERENCE_CATEGORY`(CATEGORY_IN VARCHAR(255)) RETURNS varchar(255) CHARSET latin1
    DETERMINISTIC
BEGIN
     DECLARE RESULT VARCHAR(18);
     SET RESULT = 
    (
      SELECT rc_bios__CATEGORY
        FROM s_preference_account
       WHERE     ifnull(RC_BIOS__START_DATE, curdate()) >= curdate()
             AND ifnull(rc_bios__end_date, curdate()) <= curdate()
             AND rc_bios__active = 'true'
             AND rc_bios__category = CATEGORY_IN
      );
     RETURN RESULT;
    END;

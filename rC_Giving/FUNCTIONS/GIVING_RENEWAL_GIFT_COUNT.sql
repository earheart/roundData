DROP FUNCTION IF EXISTS GIVING_RENEWAL_GIFT_COUNT;
CREATE FUNCTION `GIVING_RENEWAL_GIFT_COUNT`(
   AFFILIATION_IN      VARCHAR(255),
   ACTIVITY_TYPE_IN    VARCHAR(255),
   ACCOUNT_GUID_IN     VARCHAR(18))
   RETURNS INTEGER(18)
   DETERMINISTIC
   BEGIN
      DECLARE RESULT   INTEGER(18);
      SET RESULT =
             (SELECT count(id)
                FROM opportunity o
               WHERE     o.RC_GIVING__GIVING_TYPE IN
                            ('New', 'Renewal', 'Rejoin', 'Upgrade/Reset')
                     AND rc_giving__is_giving = 'True'
                     AND rc_giving__affiliation = AFFILIATION_IN
                     AND rc_giving__activity_type = ACTIVITY_TYPE_IN
                     AND accountid = ACCOUNT_GUID_IN);
      RETURN RESULT;
   END;
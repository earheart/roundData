create view O_ACKNOWLEDGEMENT
AS
select 
      o.id opportunityid, 
      RC_GIVING__ACKNOWLEDGED_DATE, 
      rc_giving__acknowledged, 
      amount, 
      CLOSEDATE,
      o.RC_GIVING__IS_SUSTAINER,
      o.RC_GIVING__GIVING_TYPE,
      a.id accountid, 
      a.SALUTATION, 
      a.BILLINGSTREET, 
      a.BILLINGCITY, 
      a.BILLINGSTATE, 
      a.BILLINGPOSTALCODE, 
      a.BILLINGCOUNTRY
from v_opportunity o
join v_account a on o.ACCOUNTID = a.id
where RC_GIVING__ACKNOWLEDGED = 'False'
and RC_GIVING__IS_GIVING_transacti = 'True'
and rc_giving__is_payment_refunded = 'False'
AND o.STAGENAME = 'Completed'
AND o.CLOSEDATE >= DATE_SUB(CURDATE(), INTERVAL 1 month)
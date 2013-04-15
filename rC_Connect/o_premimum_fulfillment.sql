create or replace view o_premium_fulfillment
as
SELECT v_product2.PRODUCTCODE AS PRODUCTCODE,
    v_product2.RC_GIVING__VENDOR AS VENDOR,
    v_product2.RC_GIVING__VENDOR_REFERENCE_NUMBER AS VENDOR_REFERENCE_NUMBER,
    v_product2.DESCRIPTION AS DESCRIPTION,
    v_opportunitylineitem.QUANTITY AS QUANTITY,
    ifnull(v_opportunitylineitem.RC_GIVING__BENEFICIARY, v_account.id) AS Recipient_ID,
    v_account.RC_BIOS__SALUTATION AS Recipient,
    (CASE WHEN (v_opportunitylineitem.RC_GIVING__DELIVERY_METHOD = 'BILLING ADDRESS') THEN v_account.BILLINGSTREET     ELSE v_account.SHIPPINGSTREET     END) AS STREET_1,
    (CASE WHEN (v_opportunitylineitem.RC_GIVING__DELIVERY_METHOD = 'BILLING ADDRESS') THEN v_account.BILLINGSTREET     ELSE v_account.SHIPPINGSTREET     END) AS STREET_2,
    (CASE WHEN (v_opportunitylineitem.RC_GIVING__DELIVERY_METHOD = 'BILLING ADDRESS') THEN v_account.BILLINGCITY       ELSE v_account.SHIPPINGCITY       END) AS CITY,
    (CASE WHEN (v_opportunitylineitem.RC_GIVING__DELIVERY_METHOD = 'BILLING ADDRESS') THEN v_account.BILLINGSTATE      ELSE v_account.SHIPPINGSTATE      END) AS STATE,
    (CASE WHEN (v_opportunitylineitem.RC_GIVING__DELIVERY_METHOD = 'BILLING ADDRESS') THEN v_account.BILLINGPOSTALCODE ELSE v_account.SHIPPINGPOSTALCODE END) AS POSTAL_CODE,
    (CASE WHEN (v_opportunitylineitem.RC_GIVING__DELIVERY_METHOD = 'BILLING ADDRESS') THEN v_account.BILLINGCOUNTRY    ELSE v_account.SHIPPINGCOUNTRY    END) AS COUNTRY,
    v_opportunity.CLOSEDATE AS CLOSEDATE,
    v_account.RC_BIOS__PREFERRED_CONTACT_EMAIL AS EMAIL,
    v_opportunitylineitem.ID AS GIVING_ITEM_GUID,
    v_opportunity.RC_GIVING__SOURCE_CODE AS RC_GIVING__SOURCE_CODE,
    v_opportunitylineitem.RC_GIVING__DELIVERY_STATUS,
    v_opportunitylineitem.SERVICEDATE
 FROM v_opportunitylineitem
 JOIN v_opportunity ON v_opportunitylineitem.OPPORTUNITYID = v_opportunity.ID
 JOIN v_account ON ifnull(v_opportunitylineitem.RC_GIVING__BENEFICIARY, v_opportunity.ACCOUNTID) = v_account.ID
 JOIN v_pricebookentry ON v_pricebookentry.ID = v_opportunitylineitem.PRICEBOOKENTRYID
 JOIN v_pricebook2 ON v_pricebook2.ID = v_pricebookentry.PRICEBOOK2ID
 JOIN v_product2 ON v_product2.ID = v_pricebookentry.PRODUCT2ID
 LEFT JOIN v_account v_account_vendor ON v_product2.RC_GIVING__VENDOR = v_account_vendor.ID
WHERE v_opportunitylineitem.RC_GIVING__DELIVERY_STATUS NOT IN ('Sent','Delivered','Canceled')

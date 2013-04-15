DROP FUNCTION IF EXISTS GIVING_PLEDGE_BALANCE;
CREATE FUNCTION GIVING_PLEDGE_BALANCE(GIVINGID_IN VARCHAR(18)) RETURNS DECIMAL(22,6)
    DETERMINISTIC
BEGIN
     DECLARE BALANCE DECIMAL(22,6);
     SET BALANCE = 
    (
      Select get_column_name('rc_giving__expected_giving_amount__c', 'opportunity') - rc_giving__closed_amount
        from V_opportunity o
        where id = GIVINGID_IN);
     RETURN BALANCE;
    END;

CREATE OR REPLACE VIEW S_PREFERRED_ADDRESS_SHIPPING AS SELECT * FROM v_rc_bios__account_address WHERE RC_BIOS__PREFERRED_SHIPPING = 'True' AND RC_BIOS__DO_NOT_MAIL <> 'True' AND RC_BIOS__UNDELIVERABLE_COUNT < 3;
CREATE OR REPLACE VIEW S_PREFERRED_ADDRESS_BILLING  AS SELECT * FROM v_rc_bios__account_address WHERE RC_BIOS__PREFERRED_BILLING  = 'True' AND RC_BIOS__DO_NOT_MAIL <> 'True' AND RC_BIOS__UNDELIVERABLE_COUNT < 3;
CREATE OR REPLACE VIEW S_PREFERENCE_ACCOUNT          AS SELECT ifnull(p.rc_bios__account, c.accountid) as accountid, p.* FROM v_rc_bios__preference p left join v_contact c on p.rc_bios__contact = c.id;
CREATE OR REPLACE VIEW S_PREFERENCE_CONTACT          AS SELECT ifnull(p.rc_bios__contact, CONTACT_PRIMARY_GUID(p.RC_BIOS__ACCOUNT)) as contactid, p.* FROM v_rc_bios__preference p;


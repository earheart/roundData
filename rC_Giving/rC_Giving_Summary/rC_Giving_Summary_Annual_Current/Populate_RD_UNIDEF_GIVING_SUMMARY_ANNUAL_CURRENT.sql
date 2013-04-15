INSERT INTO RD_UNIDEF_GIVING_SUMMARY_ANNUAL_CURRENT
select null, rj_field.TABLE_NAME, rj_field.FIELD_NAME, rj_field.COLUMN_NAME, rj_field.LABEL, rj_field.HELPTEXT, 'U_GIVING_SUMMARY_ANNUAL_CURRENT', SYS_TRANSLATE(rj_field.label,' -?/\():;.','_____________'), NULL, 'False', NULL
from rj_field 
where rj_field.table_name = 'rc_giving__SUMMARY'
AND CONCAT(rj_field.TABLE_NAME, rj_field.FIELD_NAME, rj_field.COLUMN_NAME, rj_field.LABEL)
NOT IN (SELECT CONCAT(VD.TABLE_NAME, VD.FIELD_NAME, VD.COLUMN_NAME, VD.LABEL) FROM RD_UNIDEF_GIVING_SUMMARY_ANNUAL_CURRENT VD);

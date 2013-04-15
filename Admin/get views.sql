select
concat
(
(case when substr(table_name,1,2) = 'v_' then 'Create View ' else 'Create or Replace View ' end),
table_name,
' as ',
view_definition,
';')
from information_schema.views
where Table_SCHEMA = 'WGBH_Production'


select
concat
(
(case when substr(table_name,1,2) = 'v_' then 'Create View ' else 'Create or Replace View ' end),
table_name,
' as ',
view_definition,
';')
from information_schema.views
where Table_SCHEMA = 'WGBH_Production'


select
concat
(
'Create ',
' ',
R.routine_type,
' ',
R.routine_schema,
'.' ,
R.routine_name,
' ',
'(',
(select GROUP_CONCAT(P.PARAMETER_NAME, ' ', P.DTD_IDENTIFIER)
from information_schema.PARAMETERS p
where p.SPECIFIC_SCHEMA =r.ROUTINE_SCHEMA
AND p.SPECIFIC_NAME =r.ROUTINE_NAME
and p.PARAMETER_MODE = 'in'),
')',
' returns ',
R.dtd_identifier,
case when R.character_set_name is not null then concat(' charset ',R.character_set_name) else '' end,
' DETERMINISTIC ',
routine_definition,
';'
)
from  information_schema.routines r
where ROUTINE_SCHEMA = 'WGBH_Production'
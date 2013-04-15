create or replace view rS_Last_Synced
as
select object_name ls_object_name, max(QUERY_RESTART_DATE) Last_Synced
from rj_history
group by object_name
order by max(QUERY_RESTART_DATE) asc

create or replace view rS_Last_Synced_Review
as
select object_name, last_synced 
from
(
select object_name, max(QUERY_RESTART_DATE) Last_Synced
from rj_history
group by object_name)sel
where Last_Synced<= date_sub(CURDATE(), interval 6 hour)
order by Last_Synced asc

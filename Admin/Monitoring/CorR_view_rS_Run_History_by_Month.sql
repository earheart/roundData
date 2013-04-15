create or replace view rS_Run_History_by_Month
as
select 
    concat(month(QUERY_END_DATE),'/',year(QUERY_END_DATE)) date, 
    object_name,
    sum(RECORDS_ADDED_ETL) rS_recs_created, 
    sum(RECORDS_UPDATED_ETL) rS_recs_updated, 
    sum(RECORDS_DELETED_ETL) rS_recs_deleted,
    sum(RECORDS_ADDED_SFDC) rC_recs_created,
    sum(RECORDS_UPDATED_SFDC) rC_recs_updated,
    sum(RECORDS_DELETED_SFDC) rC_recs_deleted,
    sum(errors) recs_in_error
from rj_history
where RECORDS_ADDED_ETL+RECORDS_UPDATED_ETL+RECORDS_DELETED_ETL+RECORDS_ADDED_SFDC+RECORDS_UPDATED_SFDC+RECORDS_DELETED_SFDC+ERRORS<>0
group by concat(month(QUERY_END_DATE),'/', year(QUERY_END_DATE)), object_name;
create or replace view rS_Errors
as
select
job_type,
concat(month(run_timestamp),'/',
      dayofmonth(run_timestamp),'/',
      year(run_timestamp)) AS error_date,
      object_name as error_object, 
      error_message,
      count(*) as error_count
from rj4sf_error
group by
job_type,
  concat(month(run_timestamp),'/',
      dayofmonth(run_timestamp),'/',
      year(run_timestamp)),
      object_name, 
      error_message
{{
  config(
    materialized='view'
  )
}}

with timesheet_details as (select 
    timesheet_id, 
    employee_id, 
    taskid,    
    project_id, 
    description,
    billable,
    start_date, 
    end_date, 
    duration,
    COALESCE(TRY_CAST(SUBSTRING(duration, 3, POSITION('H' IN duration) - 3) AS INTEGER), 0) AS hours,
    COALESCE(CASE 
        WHEN TRY_CAST(SUBSTRING(duration, 3, POSITION('H' IN duration) - 3) AS INTEGER) IS NULL THEN 
            TRY_CAST(SUBSTRING(duration, 3, POSITION('M' IN duration) - 3) AS INTEGER)
        ELSE 
            TRY_CAST(SUBSTRING(duration, 5, POSITION('M' IN duration) - 5) AS INTEGER)
    END, 
    0) AS minutes

 from {{ source('clockify_source_data', 'timesheet_entry') }})
 
 select 
	timesheet_id, 
    employee_id, 
    taskid,    
    project_id, 
    description,
    billable,
    start_date, 
    end_date, 
	hours + minutes / 60.0 as total_hours 
	from timesheet_details
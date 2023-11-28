{{
  config(
    materialized='view'
  )
}}

select 
    timesheet_id, 
    employee_id, 
    taskid,    
    project_id, 
    start_date, 
    end_date, 
    duration

 from {{ source('clockify_source_data', 'timesheet_entry') }}
{{
  config(
    materialized='table'
  )
}}

select p.project_id,p.project_name, sum(total_hours) as total_hours_billed
    from {{ ref('timesheet') }} AS t , {{ ref('project') }} AS p
    where t.project_id = p.project_id and p.billable = 'false'
    group by p.project_id, p.project_name
{{
  config(
    materialized='table'
  )
}}

select e.name, p.project_name, sum(total_hours) as total_hours_billed
    from {{ ref('employee') }} AS e, {{ ref('timesheet') }} AS t , {{ ref('project') }} AS p
    where t.employee_id = e.employee_id 
    and t.project_id = p.project_id
    and t.billable = 'true'
    and p.billable ='true'
    group by e.employee_id,e.name,p.project_id, p.project_name
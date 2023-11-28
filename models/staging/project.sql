{{
  config(
    materialized='view'
  )
}}

select project_id, project_name, billable from {{ source('clockify_source_data', 'project') }}
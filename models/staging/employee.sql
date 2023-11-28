{{
  config(
    materialized='view'
  )
}}

select employee_id, name, email, status, timezone from {{ source('clockify_source_data', 'employee') }}
WITH latest_friday_timesheets AS (
    SELECT DISTINCT T.Employee_ID
    FROM (
        SELECT Employee_ID, MAX(End_date) AS latest_end_date
        FROM {{ ref('timesheet') }} 
        GROUP BY Employee_ID ) AS T
    WHERE DAYOFWEEK(T.latest_end_date) = 5
    AND WEEK(T.latest_end_date) = WEEK(current_date)
    AND YEAR(T.latest_end_date) = YEAR(current_date)
)

SELECT DISTINCT E.name
FROM {{ ref('employee') }} E
WHERE E.employee_id NOT IN (
    SELECT * FROM latest_friday_timesheets
)
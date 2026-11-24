SELECT
    service_id,
    branch_id,
    ROUND(AVG(time_taken)::NUMERIC, 2) AS avg_time_taken,
    ROUND(MAX(time_taken)::NUMERIC, 2) AS max_time_taken
FROM request
GROUP BY service_id, branch_id;
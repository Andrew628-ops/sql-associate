SELECT
    s.description,
    b.id,
    b.location,
    r.id AS request_id,
    r.rating
FROM request AS r
INNER JOIN branch AS b
    ON r.branch_id = b.id
INNER JOIN service AS s
    ON r.service_id = s.id
WHERE s.description IN ('Meal', 'Laundry')
    AND b.location IN ('EMEA', 'LATAM');
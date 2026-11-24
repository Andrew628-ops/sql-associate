WITH validated_branch AS (
    SELECT
        id,

        CASE
            WHEN UPPER(TRIM(location)) IN
                ('EMEA', 'NA', 'LATAM', 'APAC')
            THEN UPPER(TRIM(location))
            ELSE 'Unknown'
        END AS location,

        CASE
            WHEN TRIM(total_rooms::TEXT) ~ '^[0-9]+$'
            THEN total_rooms::NUMERIC
            ELSE NULL
        END AS total_rooms,

        CASE
            WHEN TRIM(staff_count::TEXT) ~ '^[0-9]+$'
            THEN staff_count::NUMERIC
            ELSE NULL
        END AS staff_count,

        CASE
            WHEN TRIM(opening_date::TEXT) ~ '^[0-9]+$'
            THEN opening_date::NUMERIC
            ELSE NULL
        END AS opening_date,

        CASE
            WHEN LOWER(TRIM(target_guests)) IN
                ('business', 'b.', 'busniess', 'b')
            THEN 'Business'
            ELSE 'Leisure'
        END AS target_guests

    FROM branch
),
cleaned_branch AS (
    SELECT
        id,
        location,
        CASE
            WHEN total_rooms BETWEEN 1 AND 400
            THEN total_rooms::INTEGER
            ELSE 100
        END AS total_rooms,
        staff_count,
        CASE
            WHEN opening_date BETWEEN 2000 AND 2023
            THEN opening_date::INTEGER
            ELSE 2023
        END AS opening_date,
        target_guests
    FROM validated_branch
)
SELECT
    id,
    location,
    total_rooms,
    COALESCE(staff_count, total_rooms * 1.5) AS staff_count,
    opening_date,
    target_guests
FROM cleaned_branch;
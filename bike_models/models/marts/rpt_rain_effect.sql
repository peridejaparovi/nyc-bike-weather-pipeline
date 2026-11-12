WITH dry_baseline AS (
    SELECT
        hour_of_day,
        is_weekend,
        avg(rides) AS avg_dry_rides
    FROM {{ ref('fct_hourly_ridership') }}
    WHERE NOT is_rainy
    GROUP BY hour_of_day, is_weekend
)

SELECT
    count(*) AS rainy_hours,
    sum(hourly.rides) AS actual_rides,
    round(sum(dry_baseline.avg_dry_rides)) AS expected_rides,
    round(sum(hourly.rides) / sum(dry_baseline.avg_dry_rides) - 1, 3) AS rain_effect
FROM {{ ref('fct_hourly_ridership') }} AS hourly
JOIN dry_baseline
    ON hourly.hour_of_day = dry_baseline.hour_of_day
    AND hourly.is_weekend = dry_baseline.is_weekend
WHERE hourly.is_rainy
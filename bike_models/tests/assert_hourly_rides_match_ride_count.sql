WITH total_hourly_rides AS (
    SELECT sum(rides) AS ride_count
    FROM {{ ref('fct_hourly_ridership') }}
),
  total_rides AS (
    SELECT COUNT(*) AS ride_count
    FROM {{ ref('fct_rides') }}
    WHERE started_at >= '2026-09-01')

SELECT total_hourly_rides.ride_count AS hourly_ride_count,
       total_rides.ride_count AS total_ride_count
FROM total_hourly_rides, total_rides
WHERE total_hourly_rides.ride_count != total_rides.ride_count

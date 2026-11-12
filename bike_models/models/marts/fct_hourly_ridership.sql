WITH rides_per_hour AS (
    SELECT date_trunc('hour', rides.started_at) AS ride_hour,
           COUNT(rides.ride_id) AS total_rides
    FROM {{ ref('fct_rides') }} AS rides
    GROUP BY 1
)

SELECT we.weather_hour,
       hour(we.weather_hour) AS hour_of_day,
       dayofweek(we.weather_hour) IN (0, 6) AS is_weekend,
       we.precipitation > 0 AS is_rainy,
       we.temperature_2m,
       we.precipitation,
       coalesce(rh.total_rides, 0) AS rides
FROM {{ ref('stg_weather') }} AS we
LEFT JOIN rides_per_hour AS rh
    ON we.weather_hour = rh.ride_hour
WHERE we.weather_hour >= '2026-09-01'
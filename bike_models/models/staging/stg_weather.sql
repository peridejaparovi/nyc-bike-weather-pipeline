SELECT
    cast(weather_time AS TIMESTAMP) AS weather_hour,
    temperature_2m,
    precipitation,
    snowfall,
    wind_speed_10m
FROM {{ source('raw', 'weather') }}
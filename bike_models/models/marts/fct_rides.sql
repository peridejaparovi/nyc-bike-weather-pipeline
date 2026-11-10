SELECT rides.ride_id,
       rides.rideable_type,
       rides.rider_type,
       rides.started_at,
       rides.ended_at,
       rides.start_station_id,
       rides.end_station_id,
       weather.temperature_2m,
       weather.precipitation,
       weather.snowfall,
       weather.wind_speed_10m,
       date_diff('second', rides.started_at, rides.ended_at)/60.0 AS duration_minutes
FROM {{ ref('stg_rides') }} AS rides
LEFT JOIN {{ ref('stg_weather') }} AS weather
ON date_trunc('hour', rides.started_at) = weather.weather_hour
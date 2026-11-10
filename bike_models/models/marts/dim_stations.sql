WITH all_stations AS 
(SELECT rides.start_station_id AS station_id,
        rides.start_station_name AS station_name,
        rides.start_lat AS station_latitude,
        rides.start_lng AS station_longitude
FROM {{ ref('stg_rides') }} AS rides
WHERE rides.start_station_id IS NOT NULL

UNION ALL

SELECT rides.end_station_id AS station_id,
       rides.end_station_name AS station_name,
       rides.end_lat AS station_latitude,
       rides.end_lng AS station_longitude
FROM {{ ref('stg_rides') }} AS rides
WHERE rides.end_station_id IS NOT NULL)

SELECT station_id,
       max(station_name) AS station_name,
       avg(station_latitude) AS station_latitude,
       avg(station_longitude) AS station_longitude
FROM all_stations
GROUP BY station_id

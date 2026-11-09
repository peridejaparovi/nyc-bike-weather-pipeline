SELECT *
FROM  {{ ref('stg_rides') }} AS rides
WHERE rides.ended_at < rides.started_at
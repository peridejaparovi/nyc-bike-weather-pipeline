import duckdb

con = duckdb.connect("data/bike.duckdb")

con.sql("CREATE SCHEMA IF NOT EXISTS raw")
con.sql("""
    CREATE OR REPLACE TABLE raw.rides AS
    SELECT * FROM read_csv('data/raw/rides/*.csv')
""")
con.sql("SELECT count(*) AS rides FROM raw.rides").show()

con.sql("""
    CREATE OR REPLACE TABLE raw.weather AS
    SELECT
        unnest(hourly.time) AS weather_time,
        unnest(hourly.temperature_2m) AS temperature_2m,
        unnest(hourly.precipitation) AS precipitation,
        unnest(hourly.snowfall) AS snowfall,
        unnest(hourly.wind_speed_10m) AS wind_speed_10m
    FROM read_json('data/raw/weather.json')
""")
con.sql("SELECT count(*) AS hours FROM raw.weather").show()

con.close()

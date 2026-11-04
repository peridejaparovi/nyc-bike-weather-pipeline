import duckdb

con = duckdb.connect("data/bike.duckdb")

con.sql("CREATE SCHEMA IF NOT EXISTS raw")
con.sql("""
    CREATE OR REPLACE TABLE raw.rides AS
    SELECT * FROM read_csv('data/raw/rides/*.csv')
""")
con.sql("SELECT count(*) AS rides FROM raw.rides").show()

con.close()

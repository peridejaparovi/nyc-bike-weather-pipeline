import json
from pathlib import Path

import requests

params = {"latitude": 40.72,
          "longitude": -74.04,
          "start_date": "2026-09-01",
          "end_date": "2026-09-02",
          "hourly": "temperature_2m",
          "timezone": "America/New_York"}
response = requests.get(
    "https://archive-api.open-meteo.com/v1/archive", params=params)
response.raise_for_status()
print(response.status_code)
data = response.json()
hourly = data["hourly"]
print(len(hourly["time"]))
print(hourly["temperature_2m"][0])

output_folder = Path("data/raw")
output_folder.mkdir(parents=True, exist_ok=True)

with open(output_folder / "weather.json", "w") as file:
    json.dump(data, file)

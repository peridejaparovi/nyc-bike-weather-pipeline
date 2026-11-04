import zipfile
from pathlib import Path

import requests

url = "https://s3.amazonaws.com/tripdata/JC-202609-citibike-tripdata.csv.zip"
response = requests.get(url, timeout=60)
response.raise_for_status()

output_folder = Path("data/raw/rides")
output_folder.mkdir(parents=True, exist_ok=True)
zip_path = output_folder / "JC-202609.zip"

with open(zip_path, "wb") as file:
    file.write(response.content)

with zipfile.ZipFile(zip_path) as zip_file:
    zip_file.extractall(output_folder)

print("Done")

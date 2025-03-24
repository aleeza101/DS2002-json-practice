#!/bin/bash

# Fetch JSON data
curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbox=40%2C-90%2C45%2C-85" > aviation.json

# Print first 6 receiptTimes
echo "Receipt Times:"
jq -r '.[].receiptTime' aviation.json | head -6

# Compute average temperature
avg_temp=$(jq '[.[].temp] | add / length' aviation.json)
echo "Average Temperature: $avg_temp"

# Check if more than half were cloudy (cloud value not "CLR")
total_reports=$(jq length aviation.json)
cloudy_count=$(jq '[.[].clouds[]?.cover | select(. != "CLR")] | length' aviation.json)

if [ "$cloudy_count" -gt $(($total_reports / 2)) ]; then
  mostly_cloudy=true
else
  mostly_cloudy=false
fi

echo "Mostly Cloudy: $mostly_cloudy"




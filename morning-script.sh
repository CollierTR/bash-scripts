#!/bin/bash

task() {
  clear
  echo "$@"
  echo " "
  read -p "Press enter to continue..."
}

check_newsboat() {
  clear
  echo "Opening Newsboat..."
  newsboat && echo " "
}

typing_warmup() {
  clear
  typing=(
    "https://monkeytype.com"
    # "https://www.typelit.io/"
    # "https://bibletyper.app/myplan"
    #"https://10fastfingers.com/top1000#top1000"
  )

  selected_site="${typing[RANDOM % ${#typing[@]}]}"
  echo "Opening ${selected_site} for typing practice..."
  /mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe --app="$selected_site"
  echo ""
  read -p "Press enter to continue..."
}

weather_report() {
  clear
  echo "Today's Weather for La Plata, MO"
  echo "--------------------------------"

  weather_json=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=39.47&longitude=-91.87&current_weather=true&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=America/Chicago&temperature_unit=fahrenheit&wind_speed_unit=mph")

  current_temp=$(echo "$weather_json" | jq '.current_weather.temperature')
  current_wind=$(echo "$weather_json" | jq '.current_weather.windspeed')
  today_high=$(echo "$weather_json" | jq '.daily.temperature_2m_max[0]')
  today_low=$(echo "$weather_json" | jq '.daily.temperature_2m_min[0]')
  today_rain=$(echo "$weather_json" | jq '.daily.precipitation_sum[0]')
  upcoming_lows=$(echo "$weather_json" | jq '.daily.temperature_2m_min')

  echo "Current Temp:  ${current_temp}°F"
  echo "Wind Speed:    ${current_wind} mph"
  echo "Today's High:  ${today_high}°F"
  echo "Today's Low:   ${today_low}°F"
  echo "Rain Today:    ${today_rain} in"
  echo "Upcoming Lows:    ${upcoming_lows} in"
  echo "--------------------------------"
  echo ""
  read -p "Press enter to continue..."
}

# Routine
task "Good morning!" | lolcat
task "Review Todoist"
task "Check Emails"
task "Check Tickets"
check_newsboat
typing_warmup
task "Put phone in an area away from desk to improve concentration"
task "Take today by storm!" | lolcat
clear

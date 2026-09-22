#!/bin/bash

NOTES_DIR="$HOME/notebook/daily-notes"

task() {
  clear
  echo "$@"
  echo " "
  read -p "Press enter to continue..."
}

confirm() {
  local reply
  read -p "$1 [Y/n] " reply
  [[ -z "$reply" || "$reply" =~ ^[Yy] ]]
}

devotion() {
  clear
  me -m
  echo " "
  read -p "Press enter to continue..."
}

find_latest_note() {
  local offset note_file
  for offset in $(seq 1 14); do
    note_file="$NOTES_DIR/$(date -d "-${offset} days" +%Y-%m-%d).md"
    if [[ -f "$note_file" ]]; then
      echo "$note_file"
      return 0
    fi
  done
  return 1
}

read_last_daily_note() {
  clear
  local note_file note_date today_epoch note_epoch days_ago

  note_file=$(find_latest_note) || {
    echo "No daily note found in the last 14 days."
    echo ""
    read -p "Press enter to continue..."
    return
  }

  note_date=$(basename "$note_file" .md)
  today_epoch=$(date -d "$(date +%Y-%m-%d)" +%s)
  note_epoch=$(date -d "$note_date" +%s)
  days_ago=$(((today_epoch - note_epoch) / 86400))

  echo "Finding your last daily note..."
  if [[ $days_ago -eq 1 ]]; then
    echo "Opening: ${note_date}.md  (yesterday)"
  else
    echo "Opening: ${note_date}.md  (${days_ago} days ago)"
  fi
  echo ""
  less "$note_file"
  echo ""
  read -p "Press enter to continue..."
}

check_newsboat() {
  clear
  echo "Opening Newsboat..."
  newsboat && echo " "
}

open_chrome_app() {
  /mnt/c/Program\ Files/Google/Chrome/Application/chrome.exe --app="$1"
}

typing_warmup() {
  clear
  typing=(
    "https://monkeytype.com"
    # "https://www.keybr.com/"
    # "https://10fastfingers.com/top1000#top1000"
    # "https://www.typelit.io/"
    # "https://bibletyper.app/myplan"
  )

  selected_site="${typing[RANDOM % ${#typing[@]}]}"
  echo "Opening ${selected_site} for typing practice..."
  open_chrome_app "$selected_site"
  echo ""
  read -p "Press enter to continue..."
}

coding_challenge() {
  clear
  coding=(
    "https://leetcode.com/problemset/"
    "https://www.codewars.com/dashboard"
  )

  selected_site="${coding[RANDOM % ${#coding[@]}]}"
  echo "Opening ${selected_site} for a coding challenge..."
  open_chrome_app "$selected_site"
  echo ""
  read -p "Press enter to continue..."
}

regex_practice() {
  clear
  regex=(
    "https://regexlearn.com/"
    "https://regexone.com/"
    "https://regex101.com/"
  )

  selected_site="${regex[RANDOM % ${#regex[@]}]}"
  echo "Opening ${selected_site} for regex practice..."
  open_chrome_app "$selected_site"
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
task "Good morning!"
devotion
read_last_daily_note
task "Check Emails"
task "Check Tickets"
check_newsboat
task "Review Todoist"
task "Put phone in an area away from desk to improve concentration"
confirm "Do typing practice?" && typing_warmup
confirm "Do regex practice?" && regex_practice
confirm "Do a coding challenge?" && coding_challenge
task "Take today by storm!" | lolcat
clear

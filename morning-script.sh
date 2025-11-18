#!/bin/bash

echo "Good morning!"

echo "What will you be reading today? Last time you read:"
cat ~/.bash-scripts/cache/morning-script.txt
read BIBLE_INPUT
echo $BIBLE_INPUT >~/.bash-scripts/cache/morning-script.txt
bible $BIBLE_INPUT | less

clear
echo "What is something you could do today that would be high signal and be a needle mover?"
read ANSWER
clear
echo "Add this to your goals for the day."
echo $ANSWER | lolcat
echo " "
read -p "Press enter to continue..."

clear
echo "Review Todoist"
echo " "
read -p "Press enter to continue..."

clear
echo "Prepare today's calendar"
echo " "
read -p "Press enter to continue..."

clear
echo "Check Emails"
echo " "
read -p "Press enter to continue..."

clear
echo "Check Tickets"
echo " "
read -p "Press enter to continue..."

curl "https://api.open-meteo.com/v1/forecast?latitude=39.47&longitude=-91.87&current_weather=true&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=America/Chicago&temperature_unit=fahrenheit&wind_speed_unit=mph" | jq
echo ""
read -p "Press enter to continue..."

clear
echo "Today's Weather for La Plata, MO"
echo "--------------------------------"

weather_json=$(curl -s "https://api.open-meteo.com/v1/forecast?latitude=39.47&longitude=-91.87&current_weather=true&daily=temperature_2m_max,temperature_2m_min,precipitation_sum&timezone=America/Chicago&temperature_unit=fahrenheit&wind_speed_unit=mph")

current_temp=$(echo "$weather_json" | jq '.current_weather.temperature')
current_wind=$(echo "$weather_json" | jq '.current_weather.windspeed')
today_high=$(echo "$weather_json" | jq '.daily.temperature_2m_max[0]')
today_low=$(echo "$weather_json" | jq '.daily.temperature_2m_min[0]')
today_rain=$(echo "$weather_json" | jq '.daily.precipitation_sum[0]')

echo "Current Temp:  ${current_temp}°F"
echo "Wind Speed:    ${current_wind} mph"
echo "Today's High:  ${today_high}°F"
echo "Today's Low:   ${today_low}°F"
echo "Rain Today:    ${today_rain} in"
echo "--------------------------------"
echo ""
read -p "Press enter to continue..."

clear
echo "Take today by storm!"
echo " "
read -p "Press enter to continue..."
clear

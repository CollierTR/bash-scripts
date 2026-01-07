append_md_list() {
  local input="$1"
  local target_file="$2"

  # Split on commas
  IFS=',' read -ra items <<<"$input"

  for item in "${items[@]}"; do
    # Trim leading/trailing whitespace
    item="${item#"${item%%[![:space:]]*}"}"
    item="${item%"${item##*[![:space:]]}"}"

    # Skip empty items
    [[ -n "$item" ]] && echo "- $item" >>"$target_file"
  done
}

clear
echo " "
echo "Clean up the digital plane"
echo " "
read -p "Press enter to continue..."

clear
echo " "
echo "Clean up your desk"
echo " "
read -p "Press enter to continue..."

clear
echo " "
echo "How would you rate the day?"
read DAY_RATING

clear
echo " "
echo "Daily Log: list logs seperated by commas"
read LOGS
LOG_FILE="$HOME/notebook/daily-log.md"
TODAY=$(date +"%B %d, %Y")
echo "# $TODAY" >>"$LOG_FILE"
echo "**Day Rating: $DAY_RATING**" >>"$LOG_FILE"
append_md_list "$LOGS" "$LOG_FILE"
echo " " >>"$LOG_FILE"

clear
echo " "
echo "Write a to-do list for tommorow."
echo " "
read -p "Press enter to continue..."

clear
echo " "
echo "Do you need to do a Wim Hoff excercise?"
echo " "
read -p "Press enter to continue..."

clear
echo " "
echo "I am finished with work today! I'm going to take tommorow by storm!" | lolcat
echo " "
read -p "Press enter to continue..."
clear

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

clear
echo "Take today by storm!"
echo " "
read -p "Press enter to continue..."
clear

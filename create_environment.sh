#!/usr/bin/env bash
#creates create_environment.sh That sets up the directory structure for an application called submission_reminder_app.
# asks the name
read -rp "Enter your name (must not have space in between): " yourName

#create main directory
root="submission_reminder_$yourName"
mkdir -p "$root"
echo "Directory has been created: $root"
#create subdirectories
mkdir -p "$root/app" "$root/modules" "$root/assets" "$root/config"
echo "subdirectories created"
#create empty files inside the root and sub directories
touch "$root/startup.sh"
touch "$root/app/reminder.sh"
touch "$root/modules/functions.sh"
touch "$root/assets/submissions.txt"
touch "$root/config/config.env"
echo " all empty files added"

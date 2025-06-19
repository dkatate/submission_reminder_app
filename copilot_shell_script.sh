#!/usr/bin/env bash
# Find the latest created submission_reminder_* folder
app_folder="$(find . -maxdepth 1 -type d -name "submission_reminder_*" | sort | tail -n 1)"

# Check if the folder exists
if [ -z "$app_folder" ]; then
  echo " Error: No submission_reminder_* folder found."
  exit 1
fi
#prompt user for new assignment name
read -rp "Enter new assignment name: " NEW_ASSIGNMENT

#replace the value of assignment in the config.env
sed -i "2s/.*/ASSIGNMENT=$NEW_ASSIGNMENT/" "$app_folder/config/config.env"
#confirm update
echo "updates dones in the $app_folder/config/config.env"
# rerun startup.sh
echo "startup.sh running........"
bash "$app_folder/startup.sh"

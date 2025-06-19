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

# populate reminder.sh
cat << 'EOF' > "$root/app/reminder.sh"
#!/bin/bash

# Source environment variables and helper functions
source ./config/config.env
source ./modules/functions.sh

# Path to the submissions file
submissions_file="./assets/submissions.txt"

# Print remaining time and run the reminder function
echo "Assignment: $ASSIGNMENT"
echo "Days remaining to submit: $DAYS_REMAINING days"
echo "--------------------------------------------"

check_submissions $submissions_file
EOF
chmod +x "$root/app/reminder.sh"
echo "reminder.sh populated"

# populate functions.sh
cat << 'EOF' > "$root/modules/functions.sh"
#!/bin/bash

# Function to read submissions file and output students who have not submitted
function check_submissions {
    local submissions_file=$1
    echo "Checking submissions in $submissions_file"

    # Skip the header and iterate through the lines
    while IFS=, read -r student assignment status; do
        # Remove leading and trailing whitespace
        student=$(echo "$student" | xargs)
        assignment=$(echo "$assignment" | xargs)
        status=$(echo "$status" | xargs)

        # Check if assignment matches and status is 'not submitted'
        if [[ "$assignment" == "$ASSIGNMENT" && "$status" == "not submitted" ]]; then
            echo "Reminder: $student has not submitted the $ASSIGNMENT assignment!"
        fi
    done < <(tail -n +2 "$submissions_file") # Skip the header
}
EOF
chmod +x "$root/modules/functions.sh"
echo "functions.sh populated"

# populate submissions.sh
cat << 'EOF' > "$root/assets/submissions.txt"
student, assignment, submission status
Chinemerem, Shell Navigation, not submitted
Chiagoziem, Git, submitted
Divine, Shell Navigation, not submitted
Anissa, Shell Basics, submitted
David, Python, submitted
Katate, Permissions, not submitted
Suzan, Java, submitted
Mutoni, Leadership, not submitted
Shane, AI, submitted
EOF
chmod +x "$root/assets/submissions.txt"
echo "submissions.sh populated"

#populate config.env
cat << 'EOF' > "$root/config/config.env"
# This is the config file
ASSIGNMENT="Shell Navigation"
DAYS_REMAINING=2
EOF
chmod +x "$root/config/config.env"
echo "config.env populated"
# create startup.sh script
cat << 'EOF' > "$root/startup.sh"
#!/usr/bin/env bash
# Source configuration and functions
cd "$(dirname "$0")" || exit 1
source ./config/config.env
source ./modules/functions.sh
# Change into the script's own directory

./app/reminder.sh
EOF
chmod +x "$root/startup.sh"
echo "startup.sh added"

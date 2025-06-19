#!/usr/bin/env bash
#prompt user for new assignment name
read -rp "Enter new assignment name: " NEW_ASSIGNMENT

#replace the value of assignment in the config.env
sed -i "s/^ASSIGNMENT=.*/ASSIGNMENT=$NEW_ASSIGNMENT/" config/config.env
#confirm update
echo "updates dones in the config/config.env"
# rerun startup.sh
echo "startup.sh running........"
./startup.sh

#!/bin/bash

clear

# Database creds.
user="root"
pass="password"

# Other options.
backup_path="/home/Backups"
date=$(date +"%Y-%m-%d")

# Set default file permissions.
umask 002

# Get databases.
databases=`mysql --user=${user} --password=${pass} -e "SHOW DATABASES;" | tr -d "| " | grep -v Database`

# Back up each one in turn.
for db in $databases; do
    if [[ "$db" != "information_schema" && "$db" != "performance_schema" && "$db" != "phpmyadmin" ]]; then
        echo "Dumping database: $db"

	# Dump the database.
        mysqldump --opt --user=${user} --password=${pass} --databases ${db} > ${backup_path}/${date}-${db}.sql

	# Show the user the result.
	echo "Created backup: ${backup_path}/${date}-${db}.sql."
    fi
done

# Remove database backups older than 7 days.
find /home/Backups -mtime +7 -type f -delete
echo "Deleted old databases."

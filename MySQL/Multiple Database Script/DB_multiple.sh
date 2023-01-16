#!/bin/bash

# Set the current date
DATE=$(date +"%Y-%m-%d")

# Set the backup directory
BACKUP_DIR="/path/to/backup/directory"

# Set the MySQL credentials
MYSQL_USER="your_mysql_user"
MYSQL_PASSWORD="your_mysql_password"

# Get the list of databases
DATABASES=`mysql --user=$MYSQL_USER --password=$MYSQL_PASSWORD -e "SHOW DATABASES;" | grep -Ev "(Database|information_schema|performance_schema)"`

# Start the backup process
for db in $DATABASES; do
    # Print the current database name
    echo "Backing up $db"

    # Create the backup file name
    FILE="$BACKUP_DIR/$db-$DATE.sql"

    # Use the mysqldump command to backup the database
    mysqldump --user=$MYSQL_USER --password=$MYSQL_PASSWORD --databases $db | pv -s $(mysql -B -N -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SELECT SUM(data_length + index_length) FROM information_schema.tables WHERE table_schema = '$db';") | gzip > $FILE

done

# Print a message to confirm that the backup process is complete
echo "Backup process complete"

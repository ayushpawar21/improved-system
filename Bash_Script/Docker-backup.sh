#  Bash script that can be used to take backup of all locally present Docker images:

#!/bin/bash

# Set the backup directory
BACKUP_DIR='/path/to/backup/directory'

# Get the list of all locally present Docker images
IMAGE_LIST=$(docker images --format "{{.Repository}}:{{.Tag}}")

# Loop through the images and save them to the backup directory
for image in $IMAGE_LIST; do
    echo "Backing up $image"
    docker save $image -o $BACKUP_DIR/${image//\//_}.tar
done


# This script uses the docker images command to get the list of all locally present Docker images and their tags, the list is then stored in the IMAGE_LIST variable. Then it loops through the images and saves them to the backup directory using the docker save command.

# You can specify the backup directory path in the BACKUP_DIR variable, it's also good to create timestamp in the backup file for better versioning and also you can use compression and encrypt the backup file for better security.

# It's important to note that this script will save the images as .tar file and it will take some space on the disk, you can consider using other backup options like using cloud storage, or backup just the important images.
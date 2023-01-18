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

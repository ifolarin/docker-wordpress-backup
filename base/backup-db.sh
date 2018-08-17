# ----------------------------------------------------------------------
#
# This script is part of a another script! 
#
# >> Be very careful when editing it <<
#
# Developed by Evert Ramos
#
# This function will backup the database from container
#
# ----------------------------------------------------------------------

backup_database() {

    echo "Creating a backup for the Database."
    
    # Current Date (ddmmyyy-hh)
    CURRENT_DATE=$(date '+%d%m%Y')

    # Set the backup file name here
    BACKUP_FILE=$CONTAINER_DB_NAME"-"$CURRENT_DATE".sql"

    # Set the backup full path
    if [ ! -z $1 ]; then
        BACKUP_FULL_PATH=$BACKUP_PATH"/"$1
    else
        BACKUP_FULL_PATH=$BACKUP_PATH
    fi

    # Check if directory exists
    if [ ! -d $BACKUP_FULL_PATH ]; then
        MESSAGE="The backup folder ($BACKUP_FULL_PATH) does not exists, please create it before continue"
        return 1
    fi

    # Check if backup file already exists
    if [ -e $BACKUP_FULL_PATH"/"$BACKUP_FILE ]; then
        # rename olde file 
        mv $BACKUP_FULL_PATH"/"$BACKUP_FILE $BACKUP_FULL_PATH"/"$BACKUP_FILE".old"
    fi

    # create a new backup
    docker exec -i $CONTAINER_DB_NAME /usr/bin/mysqldump -u $MYSQL_USER --password=$MYSQL_PASSWORD $MYSQL_DATABASE > $BACKUP_FULL_PATH"/"$BACKUP_FILE

    BACKUP_FILE=$BACKUP_FULL_PATH"/"$BACKUP_FILE
}


#!/bin/bash

# bliss-analyser requires one extra parameter, which is used to determine the required task. This takes the following values:
#    analyse Performs analysis of tracks.
#    upload Uploads the database to LMS.
#    stopmixer Asks LMS plugin to stop it instance of bliss-mixer
#    tags Re-reads tags from your music collection, and updates the database for any changes.
#    ignore Reads the ignore file and updates the database to flag tracks as to be ignored for mixes.

# bliss-analyser accepts the following optional parameters:
#    -c / --config Location of the INI config file detailed above.
#    -m / --music Location of your music collection,
#    -d / --db Name and location of the database file.
#    -l / --logging Logging level; trace, debug, info, warn, error. Default is info.
#    -k / --keep-old When analysing tracks, bliss-analyser will remove any tracks specified in its database that are no-longer on the file-system. This parameter is used to prevent this.
#    -r / --dry-run If this is supplied when analysing tracks, then no actual analysis will be performed, instead the logging will inform you how many new tracks are to be analysed and how many old tracks are left in the database.
#    -i / --ignore Name and location of the file containing items to ignore.
#    -L / --lms Hostname, or IP address, of your LMS server.
#    -n / --numtracks Specify maximum number of tracks to analyse.

# Check if the environment variables are set
if [ -z "$TASK" ]; then
    echo "Error: $TASK environment variable is not set."
    exit 1
fi

if [ -z "$MUSIC_PATH" ]; then
    echo "Error: $MUSIC_PATH environment variable is not set."
    exit 1
fi

if [ -z "$DB_PATH" ]; then
    echo "Error: $DB_PATH environment variable is not set."
    exit 1
fi

if [ -z "$LOGGING" ]; then
    echo "Error: $LOGGING environment variable is not set."
    exit 1
fi

if [ -z "$IGNORE_FILE" ]; then
    echo "Error: $IGNORE_FILE environment variable is not set."
    exit 1
fi

if [ -z "$LMS" ]; then
    echo "Error: $LMS environment variable is not set."
    exit 1
fi

echo "Running $TASK with following parameters:"
echo "music  \t= $MUSIC_PATH"
echo "db     \t= $DB_PATH"
echo "logging\t= $LOGGING"
echo "ignore \t= $IGNORE_FILE"
echo "lms    \t= $LMS"

# Check if the provided task is one of the allowed tasks
case "$TASK" in
    "analyse" | "upload" | "stopmixer" | "tags" | "ignore")
        echo "Running task $TASK"
        /app/bliss-analyser --music $MUSIC_PATH --db $DB_PATH --logging $LOGGING --ignore $IGNORE_FILE --lms $LMS $TASK
        ;;
    *)
        echo "Invalid task: $TASK"
        exit 1
        ;;
esac

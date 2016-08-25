#!/bin/sh

BACKUPS_DIR=/var/lib/backups/db/somedir/week_
DIR_COUNT_TO_STORE=4

ls -dt $BACKUPS_DIR*/ | tail -n +4| xargs rm -r 2>/dev/null

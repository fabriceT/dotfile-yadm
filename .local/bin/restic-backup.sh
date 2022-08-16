#!/bin/env bash

DISK_REPO="/run/media/phab/1ea5cfde-2f7d-4b3f-b4c0-417473d14af1/backup/"
SFTP_REPO="sftp:thfa9713@www.kill-swit.ch:/home/thfa9713/restic-repo/"

RESTIC_PASSWORD=$(secret-tool lookup application restic)
export RESTIC_PASSWORD

function backup() {
    export RESTIC_REPOSITORY=$1

    restic backup --files-from=/home/phab/.config/restic.include \
                  --exclude-file=/home/phab/.config/restic.exclude

    restic forget --keep-weekly 4 --keep-monthly 1 --keep-yearly 1 --prune
}


if [[ -d ${DISK_REPO} ]]; then
    backup ${DISK_REPO}
fi

backup ${SFTP_REPO}

#!/bin/env bash

declare -A REPOSITORIES=(
  [disk]="/run/media/${USER}/1ea5cfde-2f7d-4b3f-b4c0-417473d14af1/backup/"
  [remote]="sftp:thfa9713@www.kill-swit.ch:/home/thfa9713/restic-repo/" 
)

function backup() {
    restic backup "${HOME}" --exclude-file="${HOME}/.config/restic.exclude"
    restic forget --keep-weekly 1m --keep-monthly 1y --keep-yearly 2y --prune
}

for location in ${!REPOSITORIES[@]}; do
	echo $location
	export RESTIC_REPOSITORY=${REPOSITORIES[$location]}
	export RESTIC_PASSWORD=$(secret-tool lookup application restic)
	backup
done


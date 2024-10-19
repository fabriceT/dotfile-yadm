#!/bin/env bash

set -euo pipefail

declare -A REPOSITORIES=(
  [disk]="/run/media/${USER}/1ea5cfde-2f7d-4b3f-b4c0-417473d14af1/backup/"
  [remote]="sftp:thfa9713@www.kill-swit.ch:/home/thfa9713/restic-repo/"
)

function backup() {
    restic backup "$HOME" --exclude-file="${HOME}/.config/restic.exclude"
    restic forget --keep-weekly 5 --keep-monthly 12 --keep-yearly 2 --prune --host "$(hostname)"
}

for location in "${!REPOSITORIES[@]}"; do
	echo "$location"
	export RESTIC_REPOSITORY="${REPOSITORIES[$location]}"
	RESTIC_PASSWORD=$(secret-tool lookup application restic) || exit 1
	export RESTIC_PASSWORD
	backup
done

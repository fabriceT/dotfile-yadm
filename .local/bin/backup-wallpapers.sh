#!/bin/bash

SOURCE=${HOME}/.local/share/gnome-shell/extensions/randomwallpaper@iflow.space/wallpapers/
DEST=${HOME}/Images/Wallpapers/

if [[ ! -d "${SOURCE}" ]]; then
  echo "Nothing to do!"
  exit
fi

if [[ ! -d "${DEST}" ]]; then
  mkdir -p "${DEST}"
fi

find "${SOURCE}" -empty -delete
rsync -av "${SOURCE}" "${DEST}"


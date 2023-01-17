#!/bin/env bash

EXPORT_FILE=~/Sync/packages-$(uname -n).txt
echo "${EXPORT_FILE}"

echo "[pacman-explicit]" > "${EXPORT_FILE}"
pacman -Qte | awk '{ print $1 }' >> "${EXPORT_FILE}"

echo -e "\n[pacman-deps]" >> "${EXPORT_FILE}"
pacman -Qtd | awk '{ print $1 }' >> "${EXPORT_FILE}"

echo -e "\n[stew]" >> "${EXPORT_FILE}"
stew ls --tags | awk '{ print $1 }' >> "${EXPORT_FILE}"

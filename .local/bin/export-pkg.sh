#!/bin/env bash

EXPORT_FILE=~/Sync/packages-$(uname -n).txt
echo "${EXPORT_FILE}"

echo "[pacman-explicit]" > "${EXPORT_FILE}"
# shellcheck disable=SC2129
pacman -Qte | awk '{ print $1 }' >> "${EXPORT_FILE}"

echo -e "\n[pacman-deps]" >> "${EXPORT_FILE}"
pacman -Qtd | awk '{ print $1 }' >> "${EXPORT_FILE}"

echo -e "\n[stew]" >> "${EXPORT_FILE}"
stew ls --tags >> "${EXPORT_FILE}"

echo -e "\n[fisher]" >> "${EXPORT_FILE}"
sort "$HOME/.config/fish/fish_plugins" >> "${EXPORT_FILE}"

echo -e "\n[gox]" >> "${EXPORT_FILE}"
gox list >> "${EXPORT_FILE}"

echo -e "\n[aqua]" >> "${EXPORT_FILE}"
aqua list -i -a | awk '{ print $1" "$2 }' >> "${EXPORT_FILE}"

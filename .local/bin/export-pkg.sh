#!/bin/env bash

EXPORT_FILE=~/.local/var/packages.lst##hostname.$(uname -n)
echo ${EXPORT_FILE}

echo "[pacman-explicit]" > ${EXPORT_FILE}
pacman -Qte |  awk '{ print $1 }' >> ${EXPORT_FILE}

echo -e "\n[pacman-deps]" >> ${EXPORT_FILE}
pacman -Qtd |  awk '{ print $1 }' >> ${EXPORT_FILE}

echo -e "\n[pacman-deps]" >> ${EXPORT_FILE}
stew ls '{ print $1 }' >> ${EXPORT_FILE}

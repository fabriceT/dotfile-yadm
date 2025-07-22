#!/bin/env bash

# This shell script is run before Openbox launches.

CACHE_DIRS=(".cache" ".thumbnails" ".config/Code/Cache" ".config/Code/CachedData" ".android/cache" ".gradle/caches/*/script*/" ".android/build-cache")
TEMP_FILES=("*.log" "*.bak*")

# Nettoyage des vieux fichiers des caches (=> 30j)

for directory in "${CACHE_DIRS[@]}"; do
  echo "Cleaning ${directory}"
  find "${HOME}/${directory}" -type f -mtime +30 #-delete
done

# Nettoyage des répertoires vides.
for directory in "${CACHE_DIRS[@]}"; do
  find "${HOME}/${directory}" -type d -empty #-delete
done

# Vieux fichiers log et backup
for file in "${TEMP_FILES[@]}"; do
  find "${HOME}" -name "${file}" -type f -empty -mtime +7 #-delete
done

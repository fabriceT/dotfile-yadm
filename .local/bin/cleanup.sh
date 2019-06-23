#!/bin/sh
# This shell script is run before Openbox launches.

CACHE_DIRS=(".cache" ".thumbnails" ".config/Code/Cache" ".config/Code/CachedData" ".android/cache" ".gradle/caches/*/script*/" ".android/build-cache")
CACHE_ENTRIES=(".cache")
TEMP_FILES=("*.log" "*.bak*")

# Nettoyage des vieux fichiers des caches (=> 30j)

for directory in ${CACHES_DIRS[@]} ; do 
  echo "Cleaning ${directory}"	
  find ~/${directory} -type f -mtime +30 -exec rm {}  \;
done

# Nettoyage des vieux répertoires vides (=> 7j). Pas récursif, ça se fera progressivement à chaque lancement d'Openbox.
for entry in ${CACHES_ENTRIES[@]} ; do 
  find ~/${directory} -type d -empty -mtime +7 -exec rmdir {} \;
done


# Vieux fichiers log et backup
for file in ${TEMP_FILES[@]} ; do 
  find ~ -name ${file} -type f -empty -mtime +7 -exec rm {} \;
done

exit


# Nettoyage du cache gradle
#find ~/.gradle/caches/*/scripts*/ ~/.android/build-cache ~/.android/cache -mtime +15 -exec rm -rf {} \;


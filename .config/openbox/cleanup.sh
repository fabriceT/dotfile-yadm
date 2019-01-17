# Nettoyage des vieux fichiers des caches (=> 30j)
(sleep 20s; find ~/.cache ~/.thumbnails ~/.dbus  -type f -mtime +30 -exec rm {} \;)

# Nettoyage des vieux répertoires vides (=> 7j). Pas récursif, ça se fera progressivement à chaque lancement d'Openbox.
(sleep 30s; find ~/.cache -type d -empty -mtime +7 -exec rmdir {} \;)

# Vieux fichiers log et backup
(sleep 60s; find ~ -name *.log -mtime +7 -exec rm {} \;)
(sleep 90s; find ~ -name *.bak* -mtime +7 -exec rm {} \;)

# Nettoyage du cache gradle
(sleep 100s; find .gradle/caches/*/scripts/ -mtime +15 -exec rm -rf {} \;)


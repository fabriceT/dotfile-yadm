#!/bin/bash

echo "Gnome setting via dconf"
for conf in `ls ${HOME}/.config/dconf/settings/*.dconf`; do
	BASENAME=$(basename ${conf})
	# Remove extension
	FILENAME="${BASENAME%.*}"
	# Replace all "." by "/"
	DCONF_PATH=${FILENAME//./\/}

	echo "  * injecting '${conf}' into '/${DCONF_PATH}/' "
	dconf load /${DCONF_PATH}/ < ${conf} 
done


#!/bin/bash

echo "dconf settings extraction:"
for conf in `ls ${HOME}/.config/dconf/settings/*.dconf`; do
	BASENAME=$(basename ${conf})
	# Remove extension
	FILENAME="${BASENAME%.*}"
	# Replace all "." by "/"
	DCONF_PATH=${FILENAME//./\/}

	echo " * processing '/${DCONF_PATH}/'"
	dconf dump /${DCONF_PATH}/ > ${conf} 
done

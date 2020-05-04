#!/bin/bash

echo "Gnome setting via dconf"
for conf in `ls ${HOME}/.config/dconf/settings/*.dconf`; do
	# This is fugly!!!
	basename=$(basename ${conf})
	filename="${basename%.*}"
	path=$(echo ${filename} | sed -e 's/\./\//g')

	echo "  * injecting '${conf}' into '/${path}/' "
	dconf load /${path}/ < ${conf} 
done


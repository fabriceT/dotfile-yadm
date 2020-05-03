#!/bin/bash

echo "dconf settings extraction:"
for conf in `ls ${HOME}/.config/dconf/settings/*.dconf`; do
	# This is fugly!!!
	basename=$(basename ${conf})
	filename="${basename%.*}"
	path=$(echo ${filename} | sed -e 's/\./\//g')

	echo " * processing '/${path}/'"
	dconf dump /${path}/ > ${conf} 
done

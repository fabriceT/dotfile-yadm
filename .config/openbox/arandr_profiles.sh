#!/bin/sh

[ ! -d ~/.screenlayout ] && return 1

cd ~/.screenlayout

echo "<?xml version=\"1.0\" encoding=\"UTF-8\" ?>"
echo "<openbox_pipe_menu>"
for i in *.sh; do 
	label=${i%.*}
	command="sh ~/.screenlayout/\"$i\""
	echo "<item label=\"$label\"><action name=\"Execute\"><execute>$command</execute></action></item>" 
done
echo "</openbox_pipe_menu>"
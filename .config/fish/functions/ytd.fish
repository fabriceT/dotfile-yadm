function ytd
	cd
	echo "URL à télécharger"
	read url
	yt-dlp $url
end

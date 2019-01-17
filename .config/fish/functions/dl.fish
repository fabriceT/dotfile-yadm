function dl
	cd
	echo "URL à télécharger"
	read url
	youtube-dl $url
end

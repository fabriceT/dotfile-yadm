function container
	sudo /usr/bin/systemd-nspawn --machine=$argv --directory=/var/lib/machines/$argv --bind=/var/cache/pacman/pkg -b --network-bridge=br0
end

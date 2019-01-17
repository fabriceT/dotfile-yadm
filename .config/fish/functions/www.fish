function check_service
	if systemctl is-active $argv > /dev/null
	        echo "Stopping service $argv"
		sudo systemctl stop $argv
	else
		echo "Starting service $argv"
		sudo systemctl start $argv
	end
end



function www
	check_service nginx
	check_service mysqld
	check_service php-fpm
end
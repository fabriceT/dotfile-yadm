function awesomewm
	Xephyr -br -ac -noreset -screen 1440x900 :1 &
	env DISPLAY=:1 awesome
end

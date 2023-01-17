# Gnome Utils
#
# Redémarre switcher quand il affiche un menu vide sur lequel on peut rien faire :/
function fix-switcher
	gnome-extensions disable switcher@landau.fi
	gnome-extensions enable switcher@landau.fi
end


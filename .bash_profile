export PS1='\u[\W]\$ '
export PAGER=most
export EDITOR=le
export TERMINAL=sakura

if [ -f ~/.bash_aliases ]; then
	. ~/.bash_aliases
fi

export PATH="/home/phab/.local/bin:$PATH"
export LUA_CPATH="?.so;/usr/lib/lua/5.1/?.so;/home/phab/.local/share/lib/lua/?.so"
export LUA_PATH="?.lua;/usr/lib/lua/5.1/?.lua;/home/phab/.local/share/lib/lua/?.lua"


echo "ici bash_profile !"

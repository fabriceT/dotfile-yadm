export PS1='\u[\W]\$ '
export PAGER=most
export EDITOR=le
export TERMINAL=sakura

[[ -f ~/.bash_aliases ]] && . ~/.bash_aliases

export PATH="${HOME}/.local/bin:$PATH"
export LUA_CPATH="?.so;/usr/lib/lua/5.1/?.so;${HOME}/.local/share/lib/lua/?.so"
export LUA_PATH="?.lua;/usr/lib/lua/5.1/?.lua;${HOME}/.local/share/lib/lua/?.lua"

[[ -f ~/.bashrc ]] && . ~/.bashrc

set -gx PATH ~/go/bin ~/.local/bin $PATH
set -gx MOZ_ENABLE_WAYLAND 1
set -gx EDITOR micro

# Python virtual env won't override my prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT "I'm not empty"

# Fix act https://github.com/nektos/act/issues/303
set -gx DOCKER_HOST unix://$XDG_RUNTIME_DIR/podman/podman.sock

source ~/.config/fish/alias.fish

#oh-my-posh init fish --config /usr/share/oh-my-posh/themes/quick-term.omp.json | source
oh-my-posh init fish --config /usr/share/oh-my-posh/themes/peru.omp.json | source
#oh-my-poshd init fish --config ~/.config/oh-my-posh/quick-term.omp.json | source
thefuck --alias | source

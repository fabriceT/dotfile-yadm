fish_add_path ~/go/bin ~/.local/bin ~/.local/share/aquaproj-aqua/bin

zoxide init fish | source

set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
set -gx MOZ_ENABLE_WAYLAND 1
set -gx EDITOR micro
set -gx CHARM_HOST 130.61.241.116
set -gx AQUA_GLOBAL_CONFIG $HOME/.config/aquaproj-aqua/aqua.yaml

# Python virtual env won't override my prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT "I'm not empty"

# Fix act https://github.com/nektos/act/issues/303
set -gx DOCKER_HOST unix://$XDG_RUNTIME_DIR/podman/podman.sock

source ~/.config/fish/alias.fish

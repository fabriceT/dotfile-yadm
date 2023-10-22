set -gx PATH ~/go/bin ~/.local/bin ~/.local/share/aquaproj-aqua/bin $PATH
set -gx MOZ_ENABLE_WAYLAND 1
set -gx EDITOR micro

set -gx AQUA_GLOBAL_CONFIG ~/.config/aquaproj-aqua/aqua.yaml

# Python virtual env won't override my prompt
set -gx VIRTUAL_ENV_DISABLE_PROMPT "I'm not empty"
oh-my-posh init fish --config /usr/share/oh-my-posh/themes/peru.omp.json | source

# Fix act https://github.com/nektos/act/issues/303
set -gx DOCKER_HOST unix://$XDG_RUNTIME_DIR/podman/podman.sock

source ~/.config/fish/alias.fish

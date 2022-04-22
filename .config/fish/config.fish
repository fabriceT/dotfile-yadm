source ~/.config/fish/alias.fish

set -gx PATH ~/go/bin ~/.local/bin $PATH
set -gx MOZ_ENABLE_WAYLAND 1

# Fix act https://github.com/nektos/act/issues/303
set -gx DOCKER_HOST unix://$XDG_RUNTIME_DIR/podman/podman.sock

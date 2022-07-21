source ~/.config/fish/alias.fish

set -gx PATH ~/go/bin ~/.local/bin $PATH
set -gx MOZ_ENABLE_WAYLAND 1
set -gx EDITOR micro

# Fix act https://github.com/nektos/act/issues/303
# No need if .actrc contains
#   --bind --container-daemon-socket /run/user/1000/podman/podman.sock
#set -gx DOCKER_HOST unix://$XDG_RUNTIME_DIR/podman/podman.sock

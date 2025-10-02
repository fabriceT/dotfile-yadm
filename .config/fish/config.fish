fish_add_path ~/go/bin ~/.local/bin ~/.local/share/aquaproj-aqua/bin

if status --is-interactive
    vfox activate fish | source
    zoxide init fish | source
    tv init fish | source
    bind -M insert ctrl-t tv_smart_autocomplete

    # atuin
    #set -gx ATUIN_NOBIND true
    #atuin init fish --disable-up-arrow | source
    #bind \cr _atuin_search
    #bind -M insert \cr _atuin_search

    source ~/.config/fish/alias.fish
end


set -gx SSH_AUTH_SOCK $XDG_RUNTIME_DIR/gcr/ssh
set -gx MOZ_ENABLE_WAYLAND 1
set -gx EDITOR micro
set -gx GOPATH ~/go
set -gx CHARM_HOST 130.61.241.116
set -gx AQUA_GLOBAL_CONFIG $HOME/.config/aquaproj-aqua/aqua.yaml

# Fix act https://github.com/nektos/act/issues/303
set -gx DOCKER_HOST unix://$XDG_RUNTIME_DIR/podman/podman.sock

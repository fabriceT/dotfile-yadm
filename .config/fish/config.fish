source ~/.config/fish/alias.fish

abbr -a gco git checkout
abbr -a osquerya osqueryi  --nodisable_audit --nodisable_events --audit_allow_config=true --audit_persist=true --audit_allow_sockets --logger_plugin=filesystem --events_expiry=1

set -gx PATH ~/go/bin ~/.local/bin $PATH
set -gx MOZ_ENABLE_WAYLAND 1

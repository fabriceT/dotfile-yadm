# aliases.fish

## GIT
abbr -a gick git checkout
abbr -a gico git commit -m
abbr -a gist git status
abbr -a gisw git switch
abbr -a gipl git pull
abbr -a giph git push

## YADM
abbr -a yadck yadm checkout
abbr -a yadco yadm commit -m
abbr -a yadst yadm status
abbr -a yadpl yadm pull
abbr -a yadph yadm push
abbr -a yadbp yadm bootstrap
abbr -a yadenc yadm encrypt
abbr -a yaddec yadm decrypt

## Just because...
# abbr -a docker podman
# abbr -a docker-compose podman-compose

## Systemd
abbr -a sysreload systemctl reload
abbr -a sysdreload systemctl deamon-reload
abbr -a sysstop systemctl stop
abbr -a sysstart systemctl start
abbr -a systimers systemctl list-timers
abbr -a sysreboot systemctl reboot

## terraform
abbr -a tfi terraform init
abbr -a tfp terraform plan -out=terraform.tfstate.plan
abbr -a tfo terraform output
abbr -a tfa terraform apply terraform.tfstate.plan

## Misc
abbr -a osquerya osqueryi --nodisable_audit --nodisable_events --audit_allow_config=true --audit_persist=true --audit_allow_sockets --logger_plugin=filesystem --events_expiry=1

abbr -a act act --bind --container-daemon-socket {$XDG_RUNTIME_DIR}/podman/podman.sock
abbr -a torrent 'mtorrent -d ~/Téléchargements/P2P --torrent-dir ~/Téléchargements/ -w ~/Téléchargements/ --magnet-file ~/magnets.link'

function rrestic
    if [ $argv[1] = "--local" ] 
        echo "--local"
        set ARGS $argv[2..-1]
        set -fx RESTIC_PASSWORD $(secret-tool lookup application restic)
        set -fx RESTIC_REPOSITORY "/run/media/phab/1ea5cfde-2f7d-4b3f-b4c0-417473d14af1/backup/"
    else
        set ARGS $argv
        set -fx RESTIC_PASSWORD $(secret-tool lookup application restic)
        set -fx RESTIC_REPOSITORY "sftp:thfa9713@www.kill-swit.ch:/home/thfa9713/restic-repo/"
    end

    echo "Using repository: $RESTIC_REPOSITORY"

    restic $ARGS
end

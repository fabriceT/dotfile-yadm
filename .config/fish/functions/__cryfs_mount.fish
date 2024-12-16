function __cryfs_mount --description "Mount cryfs"

    if not test (count $argv) -eq 3
        echo "Il faut 3 arguments"
        return
    end

    set -l SRC $argv[1]
    set -l DEST $argv[2]
    set -l TAG $argv[3]

    if test ! -d $SRC
        echo "Le répertoire source n'existe pas"
        return
    end

    if mount | grep $DEST >/dev/null
        echo "Démontage de la partition"
        cryfs-unmount $DEST
        rmdir $DEST
    else
        echo "montage de la partition"
        mkdir -p $DEST
        secret-tool lookup application gocryptfs disk $TAG | cryfs $SRC $DEST
    end
end

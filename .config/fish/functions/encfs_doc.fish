function encfs_doc
    set SRC /home/phab/.docs
    set DEST /home/phab/Documents/Privés
    set AGENT /usr/lib/seahorse/ssh-askpass

    if test ! -d $SRC
        echo "Le répertoire source n'existe pas"
        return
    end

    if mount | grep $DEST >/dev/null
        echo "Démontage de la partition"
        fusermount -u $DEST
        rmdir $DEST
    else
        echo "montage de la partition"
        mkdir -p $DEST
        encfs $SRC $DEST --extpass=$AGENT
    end
end

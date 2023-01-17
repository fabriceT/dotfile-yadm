function decrypt_doc
    set SRC /home/phab/.cryfs
    set DEST /home/phab/Documents/Privé

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
        secret-tool lookup application gocryptfs disk local | cryfs $SRC $DEST
    end
end

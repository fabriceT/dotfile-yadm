function gocrypt_doc
    set SRC /home/phab/.private
    set DEST /home/phab/Documents/Privés

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
        gocryptfs $SRC $DEST --extpass (secrettool lookup application gocryptfs disk local)
    end
end

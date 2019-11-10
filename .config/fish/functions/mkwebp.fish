function mkwebp
    # On liste les répertoires en supprimant la 1ère ligne
    # qui contient le '.' et qui nous fout dedant. 
    for directory in (find . -type d | tail +2)
        echo "Change dir to $directory"
        cd $directory
        for image in  *.jpg
            echo -n "Converting $image "
            convert $image (extension $image).webp
            if test $status -eq 0
                echo "- OK"
                rm $image
            else
                echo "- Error"
            end
        end
        cd -
    end
end
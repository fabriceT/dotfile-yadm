function aqua-update -d "Update aqua repository"
    if test -f aqua.yml
        set -f AQUA_CONFIG "./aqua.yml"
    else
        set -f AQUA_CONFIG $AQUA_GLOBAL_CONFIG
    end

    aqua -c $AQUA_CONFIG up

end

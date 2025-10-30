function ollama-switch

    if test -n $OLLAMA_HOST
        echo "Unsetting OLLAMA_HOST"
        set -e OLLAMA_HOST
    else
        echo " Setting OLLAMA_HOST"
        set -x OLLAMA_HOST "http://192.168.0.133:11434"
    end
end

function ollama-switch

    if set -q OLLAMA_HOST
        echo "Unsetting OLLAMA_HOST"
        set -eg OLLAMA_HOST
    else
        echo "Setting OLLAMA_HOST"
        set -xg OLLAMA_HOST "http://192.168.0.133:11434"
    end
end

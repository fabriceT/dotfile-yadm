function ollama-switch

    if set -q OLLAMA_HOST
        echo "Unsetting OLLAMA_HOST"
        set -xg OLLAMA_API_BASE "http://127.0.0.1:11434"
        set -eg OLLAMA_HOST
    else
        echo "Setting OLLAMA_HOST to diskstation"
        set -xg OLLAMA_HOST "http://192.168.0.133:11434"
        set -xg OLLAMA_API_BASE "http://192.168.0.133:11434"
    end
end

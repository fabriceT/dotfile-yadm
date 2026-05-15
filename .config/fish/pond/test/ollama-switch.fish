function ollama-switch -d "Bascule vers un serveur ollama (distant/local)"
    set -l default_remote "http://192.168.0.135:11434"

    if set -q OLLAMA_HOST
        echo "Unsetting OLLAMA_HOST"
        set -xg OLLAMA_API_BASE "http://127.0.0.1:11434"
        set -eg OLLAMA_HOST
    else
        echo "Setting OLLAMA_HOST to $default_remote"
        set -xg OLLAMA_HOST "$default_remote"
        set -xg OLLAMA_API_BASE "$default_remote"
    end
end

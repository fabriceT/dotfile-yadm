function extract-magnet --description "Extract Magnet Link from URL"

    # if an argument passed, modify $pattern
    if test (count $argv) -eq 0
        echo "Il faut passer une URL"
        exit 255
    end

    curl --silent $argv[0] | htmlq --attribute href "a[href*='mag']" | head -n 1 >>~/magnets.link
end

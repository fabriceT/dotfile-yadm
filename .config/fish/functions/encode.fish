function encode --description "Encode video files to x265 mp4"
    set -l pattern "*.mp4"

    # if an argument passed, modify $pattern
    if test (count $argv) -gt 0
        echo "setting pattern to $argv[1]"
        set pattern $argv[1]
    end

    echo "Listing files $pattern in current directory"
    set -l files (find . -maxdepth 2 -name $pattern | sort)
    if test (count $files) -gt 1
        for file in $files
            set -l dir (dirname $file)
            mkdir -p new/$dir
            if ! ffmpeg -i $file -c:v libx265 -crf 32 -c:a aac -b:a 96k new/$file
                rm new/$file
                return 1
            end
        end
    end
end

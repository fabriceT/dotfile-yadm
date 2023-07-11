function encode --description "Encode video files to x265 mp4"
    set -l pattern "*.mp4"

    # if an argument passed, modify $pattern
    if test (count $argv) -gt 0
        echo "setting pattern to $argv[1]"
        set pattern $argv[1]
    end

    echo "Listing files $pattern in current directory"
    set -l files (find . -maxdepth 2 -name $pattern)
    if test (count $files) -gt 1
        mkdir new 2>/dev/null
        for file in $files
            set dir (dirname $file)
            mkdir -p new/$dir
            ffmpeg -i $file -c:v libx265 -crf 32 -c:a aac -b:a 96k new/$file
        end
    end
end

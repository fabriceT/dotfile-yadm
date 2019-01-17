function encode 
  set files (find . -maxdepth 2 -name "*.mp4")
  if test (count $files) -gt 1
    mkdir new
    for file in $files
      set dir (dirname $file)
      mkdir -p new/$dir
      ffmpeg -i $file -c:v libx265 -crf 32 -c:a aac -b:a 96k new/$file
    end
  end
end
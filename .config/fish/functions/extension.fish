function extension
  set filename (echo $argv | sed "s#\(.*\)\..*#\1#")
  echo $filename
end
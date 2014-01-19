function readtime
  wc -mwl | awk '{printf "Words: %d\nTime:  %d:%02d\n", $2, int($2/250), int($2%250/250*60)}'
end

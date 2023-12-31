#!/bin/bash
# Check to see if a pipe exists on stdin.
# https://regex101.com/r/EpvISH/1
function getInput()
{
  # Instantiate arrays
  # arr_added=("added1", "added2")
  # arr_modified=("modified1")

  # Add values to arrays
  # arr_added[${#arr_added[@]}]="added3"
  # arr_modified[${#arr_modified[@]}]="modified2"

  # echo $(</dev/stdin)

  if [ -p /dev/stdin ]; then
    echo "Data was piped to this script!"
    while IFS= read line; do
      # echo "Current line: $line"

      # echo "$line" | sed 's/modified/poop/g'
      # echo "foobarbaz" | sed -r 's/^foo(.*)baz$/\1/'
      echo "      modified:   tutorial/sample_five.sh" | sed -r 's/^\t(?:deleted:\s*|modified:\s*|)(.*)$/\1/'
      # \
      # | sed 's/modified://g' \
      # | sed 's/deleted://g' \
      # | xargs


#       (?mx)↵
# ^\t # Left padding↵
# (?:deleted:\s*|modified:\s*|) # 'deleted:' or 'modified:' tags↵
# (.*) # Capture all remaining text↵
# $

# ^\t(?:deleted:\s*|modified:\s*|)(.*)$




    done
  fi
}

getInput

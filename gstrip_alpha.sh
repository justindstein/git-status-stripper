#!/bin/bash
# Check to see if a pipe exists on stdin.
# https://regex101.com/r/EpvISH/1
function getInput()
{
  # Instantiate arrays
  arr_added=("added1", "added2")
  arr_modified=("modified1")

  # Add values to arrays
  arr_added[${#arr_added[@]}]="added3"
  arr_modified[${#arr_modified[@]}]="modified2"

  # for value in "${arr_added[@]}"
  # do
  #      echo $value
  # done

  # for value in "${arr_modified[@]}"
  # do
  #      echo $value
  # done

  if [ -p /dev/stdin ]; then
    # echo "Data was piped to this script!"
    # If we want to read the input line by line
    while IFS= read line; do
      # echo "Line: \"${line}\""
      # if [[ "$line" =~ ' M Assets/Scripts/Controllers/ClickHandler.cs' ]]
      if [[ "$line" =~ [\s]*A ]]
      then
          # echo "matches: ${BASH_REMATCH[1]}"
          echo "Line: \"${line}\""
      # else
      #     echo "no match: ${BASH_REMATCH[1]}"
      fi

      # ^[\s]*[A|M|??]+[\s]+["]*[a-zA-Z0-9\.\/\_\ \-]*["]*

    done
    # Or if we want to simply grab all the data, we can simply use cat instead
    # cat
  # else
  #   echo "No input was found on stdin, skipping!"
  #   # Checking to ensure a filename was specified and that it exists
  #   if [ -f "$1" ]; then
  #     echo "Filename specified: ${1}"
  #     echo "Doing things now.."
  #   else
  #     echo "No input given!"
  #   fi
  fi
}

getInput
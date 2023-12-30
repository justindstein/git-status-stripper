#!/bin/bash
# git status --porcelain=v1 ### this one
function getInput()
{
  echo -n > file_five_param.txt

  while IFS= read -r line; do
    echo "Text read from file: $line"

    # if [[ "hello" =~ [a-z]+ ]]; then
    #   echo "String matches the regex pattern"
    # else
    #   echo "String does not match the regex pattern"
    # fi

    echo $line >> file_five_param.txt

  done



}
getInput

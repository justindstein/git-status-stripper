#!/bin/bash
function getInput()
{
  while IFS= read -r line; do
    echo "Text read from file: $line"
    echo $line > file_four_param.txt
  done

}
getInput

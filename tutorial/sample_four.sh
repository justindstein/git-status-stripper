#!/bin/bash
function getInput()
{
  read in 
  echo $in > file_four.txt

  echo $param > file_four_param.txt
}
getInput

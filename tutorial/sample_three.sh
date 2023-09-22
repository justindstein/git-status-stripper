#!/bin/bash
function read_stdin()
{
  cat < /dev/stdin > file_three.txt
}
read_stdin

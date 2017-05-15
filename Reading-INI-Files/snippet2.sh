#!/bin/bash

section=Links
name=blogger

value=$(cat sample.ini | awk '
/^\[.*\]$/ { section=$0 }
/=/ { print section $0 }
' | grep '^\['$section'\]'$name'=' | sed 's/^[^=]*=//')

echo $value # Outputs: http://bashmasterclass.blogspot.com.au/

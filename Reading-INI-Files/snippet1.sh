#!/bin/bash

section=Links
name=blogger

cat sample.ini | awk '
/^\[.*\]$/ { section=$0 }
/=/ { print section $0 }
'

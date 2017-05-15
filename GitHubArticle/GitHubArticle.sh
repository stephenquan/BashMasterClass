#!/bin/bash

url=$1
if [ "$url" == "" ]; then
  echo "Syntax: Please supply a valid GitHub Markdown URL"
  exit 1
fi

if [[ ! "$url" =~ https:[/][/]github[.]com[/].*[.]md$ ]]; then
  echo "Syntax: Please supply a valid GitHub Markdown URL"
  exit 1
fi

curl -s $url | awk '
/<link .*\/\/assets-cdn.github.com\/assets\/frameworks-.*css/ { print }
/<link .*\/\/assets-cdn.github.com\/assets\/github-.*css/ { print }
/<script .*\/\/assets-cdn.github.com\/assets\/frameworks-.*js/ { print }
/<script .*\/\/assets-cdn.github.com\/assets\/github-.*js/ { print }
/<article / { body=1 }
{ if (body) print; }
/<\/article/ { body=0; }
'

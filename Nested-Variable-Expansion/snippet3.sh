#!/bin/bash

function deref { echo ${!1} ; }
ANIMAL=CAT
BABYCAT=KITTEN
deref BABY${ANIMAL} # Outputs: KITTEN


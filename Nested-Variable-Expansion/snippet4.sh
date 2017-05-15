#!/bin/bash

function deref { echo ${!1} ; }
AA=BB
BB=CC
CC=Hello
echo ${AA} # Outputs: BB
deref ${AA} # Outputs: CC
deref $(deref ${AA}) # Outputs: Hello


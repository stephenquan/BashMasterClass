#!/bin/bash

function deref { echo ${!1} ; }
ARCH=X86
APP_NAME_X86=Calc.exe
deref APP_NAME_${ARCH}


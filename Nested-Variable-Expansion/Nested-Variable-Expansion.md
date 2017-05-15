This article is about Bash's indirection syntax: `${!VARIABLE}`. The exclamation point tells Bash to expand the value of `VARIABLE` twice. For example

```bash
VARIABLE=aa
aa=bb
echo ${VARIABLE} # Outputs: aa
echo ${!VARIABLE} # Outputs: bb
```

Whilst already cool, we often want a deeper expansion, for example:

```bash
ARCH=X86
APP_NAME_X86=Calc.exe
APP_NAME=${!APP_NAME_${ARCH}} # Error, but, we would want it to be Calc.exe
```

The error `${!APP_NAME_${ARCH}}: bad substitution` occurs because Bash's indirection syntax expects everything following the exclamation point to be the variable name only. However, you can work around this limitation because Bash's indirection syntax works on argument variables (i.e. $1, $2, etc.) within a Bash function:

```bash
function deref { echo ${!1} ; }
ARCH=X86
APP_NAME_X86=Calc.exe
deref APP_NAME_${ARCH} # Outputs: Calc.exe
```

A cool thing about implementing Bash indirection as a function, is, you can call it nested manner to expand your variable as many times as you want:

```bash
function deref { echo ${!1} ; }
AA=BB
BB=CC
CC=Hello
echo ${AA} # Outputs: BB
deref ${AA} # Outputs: CC
deref $(deref ${AA}) # Outputs: Hello
```


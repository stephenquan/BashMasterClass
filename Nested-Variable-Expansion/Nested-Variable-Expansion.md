This article is about Bash's indirection syntax: `${!VARIABLE}`. The exclamation point tells Bash to expand the value of `VARIABLE` twice. For example

```bash
VARIABLE=aa
aa=bb
echo ${VARIABLE} # Outputs: aa
echo ${!VARIABLE} # Outputs: bb
```

Whilst already cool, we often want to expand an expression, for example:

```bash
ANIMAL=CAT
BABYCAT=KITTEN
TMP=BABY${ANIMAL} # TMP=BABYCAT
echo ${!TMP} # Outputs: KITTEN
```

To do the Bash's indirection we needed to make use of a temporary variable. If we tried to do it in one line, we would encounter a bad substitution error:

```bash
ANIMAL=CAT
BABYCAT=KITTEN
echo ${!BABY${ANIMAL}} # Output: ${!BABY${ANIMAL}}: bad substitution
```

You can work around this limitation because Bash's indirection syntax works on argument variables (i.e. $1, $2, etc.) within a Bash function:

```bash
function deref { echo ${!1} ; }
ANIMAL=CAT
BABYCAT=KITTEN
deref BABY${ANIMAL} # Outputs: KITTEN
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


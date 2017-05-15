This article is about how to read ini files in Bash.

For example, say we had `sample.ini` with:

    [Name]
    firstname=Stephen
    lastname=Quan
    
    [Links]
    github=https://github.com/stephenquan/BashMasterClass
    blogger=http://bashmasterclass.blogspot.com.au/

The following `awk` script:

    cat sample.ini | awk '
    /^\[.*\]$/ { section=$0 }
    /=/ { print section $0 }
    '

reformats the output into:

    [SECTION]NAME=VALUE

i.e.

    [Name]firstname=Stephen
    [Name]lastname=Quan
    [Links]github=https://github.com/stephenquan/BashMasterClass
    [Links]blogger=http://bashmasterclass.blogspot.com.au/

From here, we can easily use `grep` and `sed` to pluck out a value:

    section=Links
    name=blogger

    value=$(cat sample.ini | awk '
    /^\[.*\]$/ { section=$0 }
    /=/ { print section $0 }
    ' | grep '^\['$section'\]'$name'=' | sed 's/^[^=]*=//')

    echo $value # Outputs: http://bashmasterclass.blogspot.com.au/

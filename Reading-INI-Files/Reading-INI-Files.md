This article is about how to read ini files in Bash.

Assume we want to read the `blogger` key from the `Links` section in the following `sample.ini` to get the value [http://bashmasterclass.blogspot.com.au/](http://bashmasterclass.blogspot.com.au):

```ini
[Name]
firstname=Stephen
lastname=Quan

[Links]
github=https://github.com/stephenquan/BashMasterClass
blogger=http://bashmasterclass.blogspot.com.au/
```

The following `awk` script:

```bash
cat sample.ini | tr -d '\r' | awk '
/^\[.*\]$/ { section=$0 }
/=/ { print section $0 }
'
```

transforms `sample.ini` file into `[SECTION]NAME=VALUE` format:

```ini
[Name]firstname=Stephen
[Name]lastname=Quan
[Links]github=https://github.com/stephenquan/BashMasterClass
[Links]blogger=http://bashmasterclass.blogspot.com.au/
```

Now, we can use `grep` and `sed` to lookup the `blogger` key in the `Links` section:

```bash
key=blogger
section=Links

value=$(cat sample.ini | tr -d '\r' | awk '
/^\[.*\]$/ { section=$0 }
/=/ { print section $0 }
' | grep '^\['$section'\]'$key'=' | sed 's/^[^=]*=//')

echo $value # Outputs: http://bashmasterclass.blogspot.com.au/
```

This article is about how to read ini files in Bash.

For example, let's assume we want to read the `blogger` key in the `Links` section in the following `sample.ini`:

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
cat sample.ini | awk '
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
section=Links
key=blogger

value=$(cat sample.ini | awk '
/^\[.*\]$/ { section=$0 }
/=/ { print section $0 }
' | grep '^\['$section'\]'$key'=' | sed 's/^[^=]*=//')

echo $value # Outputs: http://bashmasterclass.blogspot.com.au/
```

```
VAR="$(ps)"
echo $VAR # newlines within the output are removed
echo "$VAR" # newlines are retained
```

```
On an interactive bash session, 
ps | wc -l # 21
echo "$(ps | wc -l)" # 22
```

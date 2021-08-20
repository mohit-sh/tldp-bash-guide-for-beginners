# Chapter 2: Writing and Debugging Scripts

## Debugging Bash scripts

Running a script in debugging mode

```
bash -x <script_name>
```

Prints the raw commands from the scripts and then their expanded version. One difference I could see in my output and the one in the book is that `echo` statements show variable values `echo 'This is a string: black'` while the book shows it as empty.

There ae more debugging options which can be set

| Command | Meaning |
|---|---|
| set -x | Print command traces before executing |
| set -v | Print shell input lines as they are read |
| set -f | Disable file name generation using metacharacters (globbing)|

These options can be unset using `set +x` notation.

It would take a while to appreciate the use of these debugging options. For now, be content with their discovery.

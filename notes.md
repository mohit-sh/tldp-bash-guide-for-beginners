# Chapter 1: Introduction

## Shell Types
1. **sh** : Bourne Shell. Non standard, not widely used.
2. **bash** : Bourne Again Shell. Standard, beginner friendly while still being powerful.
3. **csh** : C SHell
4. **tcsh** : TENEX C Shell (superset of C Shell)
5. **ksh** : Korn Shell (superset of bash)

`cat /etc/shells`
This will list all the shells available on the system.

Two dimensions which I would like to explore more are: 1) interactive/non-interactive shells, 2) login/non-login shells. Depending upon which mode the shell is currently running in, you have differences in behavior.

## Section 1.3: Executing Commands

This section touches upon one of the more interesting bits of how bash program works internally. Would be good to come back to this once I feel comfortable with bash programming in general and I am reading to dive deeper into the internal workings. 

One fundamental concept which you can already take away from this section is that different contexts results in different behavior from bash. Some commands result in forking of a new process, while other run in the main shell process.

## Section 1.4: Building Blocks

### Shell Syntax
Parsing, tokenization and expansions happen here. Would be good to know what kind of expansions happen at this stage.
### Shell Commands
### Shell functions
Shell functions are executed in current shell context. No new process is forked.
### Shell Parameters
Parameters are not just function parameters/script parameters in bash. Parameter is an entity that stores a value. Variable is one kind of parameter that has a name. I believe other kind of parameters are `@, 1, 2, 3, ...`.
Variables have attributes (still don't know what they are for) but the builtin to assign attribute to a variable is `declare`. Look it up.
### Shell Expansions
I feel this is one of the most important topics in bash to learn on your road to mastery. Shell expansions are performed after parsing and tokenization happens. Different kinds of shell expansions are:
- Brace expansion
- Tilde Expansion
- Parameter and variable expansion
- Command substitution
- Arithematic expasion
- Word Splitting
- Filename expansion

### Redirections
Input and output redirections for commands before they get executed.
## Executing Commands
There's a particular order of things that happens before commands can be executed. I think this document doesn't try to be precise but rather give a high level idea of what's happening. Would be good to come back and read through this as you work on more example scripts.


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

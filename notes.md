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

# Chapter 3: The Bash Environment

## Global / Local Variables
The global variables, also called environment variables are available for all shells. Access using `printenv` command.
Local variables are available only to the current shell. Access using `set` command.

## Exporting Variables
Variables defined in a script aren't available to a subshell process. For that `export` has to be used. A subshell can change the variable but it's not reflected in the parent process.

## Special Parameters
A number of parameters (recall, variables are parameters) are reversed by bash and can't be assigned to

- $* vs $@ is tricky (see scripts/reserved_parameters.sh for details) NOTE: It's highly recommended to not use $* and use $@ in its place.

## Quoting Characters

### Escape Character  
Backslash is used as the escape character. It has a special behavior when it is followed by a newline.

### Single Quotes
These keep the literal meaning of whatever's enclosed. Single quotes can't contain other single quotes.

### Double Quotes
- Preserve literal meaning of what's enclosed except in certain special cases. These special cases include **backslash**, **dollar**, **backticks**
- Double quotes can be contained within double quotes if preceded by a backslash. `echo "one two three \"four\""`
- A backslash holds its special meaning only if followed by **dollar**, **double quotes**, **backtick**, **backslash**. If a backslack is followed by any of these, it's removed from the input stream. 

## Shell Expansions
Perhaps one of most misunderstood topics in bash programming.

Shell Expansion kicks in as soon as the shell command is split into tokens/words. Following is a list of all expansions that take place, in order of occurence:
1. **Brace Expansion**  
    PREAMBLE{str1,str2, ..., strN}POSTSCRIPT -> PREAMBLEstr1POSTSCRIPT, PREAMBLEstr2POSTSCRIPT, .., PREAMBLEstrNPOSTSCRIPT

    Order of the strings from within the brace is maintained
2. **Tilde Expansion**  

    Used as a shorthand notation for common directories. Home directory being one of the most commonly used one (`$HOME`), tilde expansion without any further specification expands to
    `$HOME` directory.
    ```
    echo ~ # is the same as echo $HOME, if $HOME is unset, home directory of currently logged in user is used.
    ```

    `~phil` would expand to the home directory of user phil.
    `~-`, `~+`, `~N` have other semantics (expand to `PWD`, `OLDPWD`, and Nth entry in directory stack respectively.) 

    Tile expansion within a string  is also possible if `~` follows a `:` or `=`.

    ```
    export PATH="$PATH:~/new_path" # Tilde expansion would take place.
    ```

    More examples:

    ```
    # Assume $HOME -> /home/users/mohitsharma

    echo ~mohitsharma/a/b/c # Everything from the ~ till the slash is considered to be a username 
    /home/users/mohitsharma/a/b/c

    echo ~/a/b/c
    /home/users/mohitsharma/a/b/c

    echo ~
    /home/users/mohitsharma

    echo ~phil/a

    /home/users/phil/a
    ```
3. **Shell Parameters and Variable Expansion**
    There are a lot of rules, but it doesn't seem like a hard concept. Go to the [ bash manual ](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameter-Expansion.html) for an exhaustive of possible parameter expansions.

    Basic parameter expansion looks like `${parameter}`. Braces are optional is most of the cases but usually recommended. Other examples to drive the point home:

    **`${parameter:-word}`**  

    If parameter is unset or null, the expansion of *word* is substituted. Otherwise, the value of *parameter* is substituted.
    ```
    var1="one two"
    var2="three four"
    new_var=${var1:-var2} # new_var is equal to var1

    unset var1
    new_var=${var1:-var2} # This time, new_var is equal to var2
    ```

    Then there are ways to do *Substring Expansion*.

    **`${parameter:offset}`**, **`${parameter:offset:length}`**, ...

    There is some pattern matching also possible. You can also modify the case of the value of parameter. There is concept called *indirect expansion*.

4. **Command Substitution**  
    **`$(command)`** or **`` `command` ``** executed the command and replaces the command with the standard output of the command. Any training newlines are removed.

    As a sidenote, the backtick version of command substitution is the legacy syntax. Prefer `$(command)`.
    Also, always use command substitution within quotations. `DIRNAME="$(dirname "$FILE")"` is the right way.


5. **Arithematic Expansion**

    **`$(( expression ))`**, or **`$[ expression ]`**

6. **Process Substitution**

    Don't understand process substitution that well. One example that did make some sense to me is from [ this ]( https://unix.stackexchange.com/questions/17107/process-substitution-and-pipe )

    ```
    cat <(date) # prints the date

    echo <(date) # prints the name of the file created by process substituition.

    cat <(date) <(date) <(date) # Prints the contents of the three files created by the three process substituition
    ```

7. **Word Splitting**

    TODO

8. **File Name Expansion**

    This functionality shows that bash has a special place for file system. If a word contains characters like `* ? [`, matching filenames replace the word.

# Chapter 7: Introduction to conditionals   

Bash has this concept of *primaries* that are used in the conditionals to test for certain conditions. With primaries, you can check for conditional like whether file exists, it is empty, it is a directory, it is writable. You can also check conditions on string like whether string has a length zero, it is equal to some other string

There exist operators to combine expressions used in the test condition.
- `[! EXPR]` : Negation
- `[(EXPR)]` : Not sure but perhaps to play around with the precedence of expression evaluation.
- `[EXPR1 -a EXPR2]` : Logical **AND**
- `[EXPR1 -o EXPR2]` : Logical **OR** 

There is a **`test`** builtin which should be read in more details.

There are important differences in using `[ ]` vs `[[ ]]` for testing conditions. 

In cases where are more than two options, use **`case`** statement.

# Chapter 8:

#!/bin/bash

# Play around with some reserved parameters

function some_fn() {
    # Check what $*, $@ is for
    
    echo "Inside some_fn"
    echo "Going to print all positional parameters"
    echo "They will be separated by first character of IFS"
    echo "Setting IFS to ;"
    IFS=";"
    echo "$*"
    echo "Let's try \$@"
    y=($@)
    echo ${y[0]}

}

clear

echo "The script being executed is $0"

some_fn one two three four

echo "Let's check if IFS gets reset after the fn scope is over."
echo $IFS

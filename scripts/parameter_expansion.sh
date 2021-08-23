#!/bin/bash

var="one two"
new_var=${var:-"three four"}

echo "This is var"
echo $var
echo "This is new_var"
echo $new_var

# Now let's make the parameter substitution happen

unset var
new_var=${var:-"three four"}

echo "This time around, new_var is"
echo $new_var

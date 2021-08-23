#!/bin/bash

# Let's try some examples of command substitution.

# Maybe you want to store the number of currently running process in a variable
# so that you can use it later in the program.

NPROC="$(ps | wc -l)" # remember pipe adds a new process
echo "$(wc -l <<< "$NPROC")"

#/usr/local/bin/bash

# This script clears the terminal, displays a greeting and gives information
# about currently connected users.  The two example variables are set and displayed.

clear

echo "The script starts now."

echo "Hi, $USER" # USER gives you the currently loggedin user

echo # Gives you a new line

echo "I will now fetch you a list of connected users."

echo 
w       # bash built in for list of connected (logged in) users
echo

echo "I am setting two variables now"

COLOR="black"
VALUE="9"

echo "This is a string: $COLOR"
echo "And this is a number: $VALUE"
echo

echo "I'm giving you back your prompt now"
echo

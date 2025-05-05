#!/bin/bash

# Matrix terminal effect
echo -e "\e[1;40m" # Set background color
clear

# Infinite loop to generate random stream
while :; do
    echo "$LINES $COLUMNS $(( RANDOM % COLUMNS )) $(( RANDOM % 72 ))"
    sleep 0.05
done | awk '
{
    letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789@#$%^&*()";
    c = $4;
    letter = substr(letters, c, 1);
    a[$3] = 0;

    for (x in a) {
        o = a[x];
        a[x] = a[x] + 1;

        # Print green letter at current position
        printf "\033[%s;%sH\033[2;32m%s", o, x, letter;

        # Print white letter one row below
        printf "\033[%s;%sH\033[1;37m%s\033[0;0H", a[x], x, letter;

        # Reset stream if it reaches the bottom
        if (a[x] >= $1) {
            a[x] = 0;
        }
    }
}'


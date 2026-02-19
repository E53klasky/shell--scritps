#!/bin/bash

empty_dirs=$(find . -type d -empty)

if [ -z "$empty_dirs" ]; then
    echo "There are No Empty dirs"
else
    echo "Empty directories found:"
    echo "$empty_dirs"
fi


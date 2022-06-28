#!/bin/bash

# This will print SHA to closest develop as a parent
echo $(git log --decorate | grep 'commit' | grep 'origin/develop' | head -n 1 | awk '{ print $2 }' | tr -d "\n")

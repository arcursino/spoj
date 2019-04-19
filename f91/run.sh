#!/usr/bin/env bash

if test -f *.py; then
    python3 *.py < input.txt > result.txt
    diff output.txt result.txt
    rm result.txt
fi

if test -f *.c; then
    gcc -Wall -O2 *.c -lm
    ./a.out < input.txt > result.txt
    diff output.txt result.txt
    rm result.txt
fi

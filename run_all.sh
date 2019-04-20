 #!/usr/bin/env bash

set -euo pipefail

if [[ "${1:-1}" == '-fail-on-warnings' ]]; then
    warning_flags='-Werror'
else
    warning_flags='-Wall'
fi

function run_c {
    gcc $warning_flags ./*.c -lm

    if [[ -f input.txt ]]; then
        ./a.out < input.txt > result.txt
    else
        ./a.out > result.txt
    fi

    rm a.out
}

function run_python {
    if [[ -f input.txt ]]; then
        python ./*.py < input.txt > result.txt
    else
        python ./*.py > result.txt
    fi
}

function run_and_check {
    if [[ "$(find . -name '*.c' | wc -l)" -eq 1 ]]; then
        run_c
        diff output.txt result.txt
    fi

    if [[ "$(find . -name '*.py' | wc -l)" -eq 1 ]]; then
        run_python
        diff output.txt result.txt
    fi

    rm result.txt
}

function run_all {
    shopt -s globstar nullglob # needed for ./**

    for file in ./**/problem.txt ; do
        folder="$(dirname "$file")"
        cd "$folder" || exit 1
        echo "$folder"
        if [[ ! -f 'WRONG' ]]; then
            run_and_check
        fi
        cd - > /dev/null || exit 1
    done
}

run_all

#!/usr/bin/env bash

set -euo pipefail

function check_tags {
    shopt -s globstar nullglob # needed for ./**

    for file in ./**/problem.txt ; do
        folder="$(dirname "$file")"
        cd "$folder" || exit 1
        if [[ "$(find . -name '*.c' | wc -l)" -eq 1 ]]; then
            if ! grep " tags: " *.c > /dev/null; then
                echo "missing tags at $folder"
                exit 1
            fi
        fi
        if [[ "$(find . -name '*.py' | wc -l)" -eq 1 ]]; then
            if ! grep " tags: " *.py > /dev/null; then
                echo "missing tags at $folder"
                exit 1
            fi
        fi
        cd - > /dev/null || exit 1
    done
}

check_tags

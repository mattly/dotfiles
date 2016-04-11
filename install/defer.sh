#!/usr/bin/env bash

defer () {
    echo "deferred:"
    echo "$*"
    while read line
    do
        echo "$line"
    done
}

cat <<DEFER
echo "This is a deferred command"
echo foo/bar >> bee
DEFER | defer




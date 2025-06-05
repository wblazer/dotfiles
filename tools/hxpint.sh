#!/bin/bash

show_usage() {
    echo "Usage:" >&2
    echo "  $0 <file>          # Format file" >&2
    echo "  $0 --stdin         # Format code from stdin" >&2
    exit 1
}

tmp_dir=$(mktemp -d)
tmp_file="$tmp_dir/temp.php"

cleanup() {
    rm -rf "$tmp_dir"
}

trap cleanup EXIT

if [ "$1" == "--stdin" ]; then
    # Read from stdin
    cat > "$tmp_file"
elif [ $# -eq 1 ] && [ -f "$1" ]; then
    # Copy input file to temporary directory
    cp "$1" "$tmp_file"
else
    show_usage
fi

$HOME/dev/greenkeeper-api/vendor/bin/pint "$tmp_file" -q

cat "$tmp_file"

#!/bin/sh
set -e

if [ -z "$1" ]; then
	echo "Usage: $0 <file.typ>" >&2
	exit 1
fi

base="${1%.typ}"
typst compile "$1" "${base}_{n}.png"

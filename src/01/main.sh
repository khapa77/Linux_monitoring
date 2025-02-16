#!/bin/bash

source ./ok.sh
source ./fail.sh

for var in "$@"; do
if [[ "$var" =~ ^[0-9]+$ ]]; then
	ok
else
	fail
fi
done

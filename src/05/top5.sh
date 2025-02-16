#!/bin/bash


# Топ-5 папок с самым большим весом в порядке убывания (путь и размер):
top_five_size (){
echo "Топ-5 папок с самым большим весом в порядке убывания (путь и размер):"

units "$(du -h --max-depth=1 "$PATH_DIR" 2>/dev/null | sort -rh | head -n 5 | awk '{print NR " - " $2 ", " $1}' )"
}

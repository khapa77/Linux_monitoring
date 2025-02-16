#!/bin/bash

# TOP 10 executable files with MD5 hash
top10_files_exe (){
echo "Топ-10 исполняемых файлов с самым большим весом в порядке убывания (путь, размер и хеш):"

find "$PATH_DIR" -type f -perm /a=x  du -h {} + 2>/dev/null | sort -rh | head -n 10 | nl -w1 -s' - ' | while read -r line; do
	path=$(echo "$(echo "$line" | cut  -f2-)")
	size="$(units "$(echo "$line" | awk '{print $3}')")"
	num=$(echo "$line" | awk '{print $1}')
	hash=$(md5sum "$path" 2>/dev/null | awk '{print $1}')
        echo "$num - $path, $size, $hash"
done
}

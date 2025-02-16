#!/bin/bash

top10_files_max (){
    echo "Топ-10 файлов с самым большим весом в порядке убывания (путь, размер и тип):"
    
    find "$PATH_DIR" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10 | nl -w1 -s' - ' | while read line; do
        # Разбираем строку с номером, путем и размером
        num=$(echo "$line" | awk '{print $1}')
	size="$(units "$(echo "$line" | awk '{print $3}')")"
        path=$(echo "$line" | awk '{print $4}')
        
        # Получаем расширение файла
        ext=${path##*.}
        
	# Преобразуем размер в удобочитаемую форму
        # Преобразуем M, K, G в Mb, Kb, Gb
#	size_w_u=$(echo "$size" | sed -e 's/\([K]\)/ Kb/g' -e 's/\([M]\)/ Mb/g' -e 's/\([G]\)/ Gb/g')

        # Выводим номер, путь, размер с единицей измерения и тип
        echo "$num - $path, $size, $ext"

    done
}


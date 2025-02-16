#!/bin/bash

total_spec(){
# Total number of files
file_count=$(find "$PATH_DIR" -type f | wc -l)
echo "Общее число файлов: $file_count"

# Number of specific file types
conf_count=$(find "$PATH_DIR" -type f -name "*.conf" | wc -l)
text_count=$(find "$PATH_DIR" -type f -name "*.txt" | wc -l)
exec_count=$(find "$PATH_DIR" -type f -executable | wc -l)
log_count=$(find "$PATH_DIR" -type f -name "*.log" | wc -l)
archive_count=$(find "$PATH_DIR" -type f \( -name "*.tar" -o -name "*.zip" -o -name "*.gz" \) | wc -l)
symlink_count=$(find "$PATH_DIR" -type l | wc -l)

echo "Число конфигурационных файлов (.conf): $conf_count"
echo "Число текстовых файлов (.txt): $text_count"
echo "Число исполняемых файлов: $exec_count"
echo "Число логов (.log): $log_count"
echo "Число архивов: $archive_count"
echo "Число символических ссылок: $symlink_count"
}

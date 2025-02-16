#!/bin/bash

# Путь к директории
PATH_DIR=$1

if [ -z "$PATH_DIR" ] || [ ! -d "$PATH_DIR" ]; then
    echo "Please provide a valid directory path."
    exit 1
fi

start_time=$(date +%s.%N)

units() {
    echo "$1" | sed -e 's/\([K]\)/ Kb/g' -e 's/\([M]\)/ Mb/g' -e 's/\([G]\)/ Gb/g'
}

# Total number of folders
source ./tot_folder.sh
total_folders

# TOP 5 folders of maximum size
source ./top5.sh
top_five_size

# Total number of files
source ./tot_spec_files.sh
total_spec

# TOP 10 files of maximum size
source ./top10_s.sh
top10_files_max 

# TOP 10 executable files with MD5 hash
source ./top10_e.sh
top10_files_exe


# Script execution time
end_time=$(date +%s.%N)
execution_time=$(echo "scale=3; ($end_time - $start_time)/1" | bc)
if (( $(echo "$execution_time < 1" | bc -l) )); then
    execution_time="0$execution_time"
fi
echo "Время выполнения скрипта: $execution_time секунд"

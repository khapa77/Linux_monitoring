#!/bin/bash

# Total number of folders

total_folders (){
folder_count=$(find "$PATH_DIR" -type d | wc -l)
echo "Общее число папок, включая вложенные: $folder_count"
}

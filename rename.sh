#!/bin/bash

if [ -z "$1" ]
then
  echo "Please provide the directory as an argument."
  exit 1
fi

# 指定源文件夹路径
source_folder="$1"

# 获取当前路径
current_dir=$(pwd)

# 指定目标文件夹路径
target_folder="${current_dir}/merged"

# 创建目标文件夹
mkdir -p ${target_folder}

# 设置`nullglob`选项，使得在没有匹配的文件时不会报错
shopt -s nullglob
for file in "$source_folder"/*.mp4 "$source_folder"/*.mkv
do
  filename=$(basename -- "$file")
  echo "Processing ${filename}"
  filename="${filename%.*}"
  
  # 使用 find 命令查找同名的 ASS 文件
  ass_file=$(find "$source_folder" -type f -name "${mkv_name}.ass")
  
  如果找到了对应的 ASS 文件
# if [ -f "$ass_file" ]; then
#   # 合并 ASS 字幕到 MKV 文件中，并将输出文件放入目标文件夹
#   output_file="${target_folder}/${mkv_name}.mkv"
#   ffmpeg -i "${source_folder}/${mkv_name}.mkv" -i "$ass_file" -c copy -metadata:s:s:0 language=chi "$output_file"
#   echo "Merged $ass_file into $output_file"
# else
#   echo "No ASS file found for $mkv_file"
# fi
  
done
shopt -u nullglob

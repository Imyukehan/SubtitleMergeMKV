#!/bin/zsh

if [ -z "$1" ]
then
  echo "Please provide the directory as an argument."
  exit 1
fi

# 指定源文件夹路径
source_folder="$1"

# 指定目标文件夹路径
target_folder="~/Downloads/merged"

# 创建目标文件夹
mkdir -p ${target_folder}

# 使用 find 命令查找指定源文件夹内的所有 MKV 文件，并进行循环处理
find ${source_folder} -type f -name "*.mkv" | while read -r mkv_file; do
  # 提取 MKV 文件名（不包含扩展名）
  mkv_name=$(basename "$mkv_file" .mkv)
  
  # 使用 find 命令查找同名的 ASS 文件
  ass_file=$(find "$source_folder" -type f -name "${mkv_name}.ass")
  
  # 如果找到了对应的 ASS 文件
  if [ -f "$ass_file" ]; then
    # 合并 ASS 字幕到 MKV 文件中，并将输出文件放入目标文件夹
    output_file="${target_folder}/${mkv_name}.mkv"
    ffmpeg -i "${source_folder}/${mkv_name}.mkv" -i "$ass_file" -c copy -metadata:s:s:0 language=chi "$output_file"
    echo "Merged $ass_file into $output_file"
  else
    echo "No ASS file found for $mkv_file"
  fi
done

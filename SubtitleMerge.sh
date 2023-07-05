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
mkdir -p "${target_folder}"

# 设置`nullglob`选项，使得在没有匹配的文件时不会报错
shopt -s nullglob
find "$source_folder" -type f \( -name "*.mkv" -o -name "*.mp4" \) | while read -r file; do
  file_name=$(basename -- "$file")
  echo "Processing ${file_name}"
  file_name="${file_name%.*}"

  # 获取文件相对路径
  file_path="${file%/*}"
  relative_path="${file_path#"$source_folder"}"
  relative_path="${relative_path#/}" # 删除开头的斜杠

  # 创建对应的子目录在目标文件夹中
  mkdir -p "${target_folder}/${relative_path}"

  # 使用 find 命令查找同名的 ASS 文件
  ass_file=$(find "$source_folder" -type f -name "${file_name}.ass")

  # 如果找到了对应的 ASS 文件
  if [ -f "$ass_file" ]; then
    # 合并 ASS 字幕到 MKV 文件中，并将输出文件放入目标文件夹
    output_file="${target_folder}/${relative_path}/${file_name}.mkv"

    # 调用ffmpeg 合并视频与字幕文件
    ffmpeg -i "${file}" -i "${ass_file}" -c copy -metadata:s:s:0 language=zh-CN "${output_file}" >/dev/null 2>&1
    echo "Video ${file_name} merged."
  else
    echo "No ASS file found for ${file_name}"
  fi
done
shopt -u nullglob

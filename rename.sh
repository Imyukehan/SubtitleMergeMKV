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

for file in "$source_folder"/*.mkv
do
  echo "Processing $file"
  filename=$(basename -- "$file")
  filename="${filename%.*}"
  ffmpeg -i "$file" -c:v libx264 -crf 23 -c:a aac "$1/$filename.mkv"
done

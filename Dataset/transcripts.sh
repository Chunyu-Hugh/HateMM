#!/bin/bash

# 设置音频文件所在的文件夹路径
AUDIO_FOLDER="/home/lab/data/hatemm/hate_videos_audio"

# 设置输出文件夹路径
OUTPUT_FOLDER="/home/lab/data/hatemm/hate_videos_transcripts"
mkdir -p "$OUTPUT_FOLDER"

# 循环处理文件夹中的每个 .wav 文件
for audio_file in "$AUDIO_FOLDER"/*.wav; do
    # 使用正则表达式提取文件名中的数字
    base_name=$(basename "$audio_file" .wav)
    numeric_part=$(echo "$base_name" | sed -n 's/[^0-9]*\([0-9]\+\)[^0-9]*/\1/p')
    output_file="$OUTPUT_FOLDER/$numeric_part.txt"
    echo "Processing $audio_file..."
    vosk-transcriber -i "$audio_file" -o "$output_file"
done

echo "All files have been processed."

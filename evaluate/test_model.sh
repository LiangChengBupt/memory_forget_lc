# 定义要检查的目录列表
export EVA_CACHE_DIR="../evaluate_cache/"
export MODEL_CACHE_DIR="../model_cache/"
export OUTPUT_DIR='../test_output/'

DIRS=("$EVA_CACHE_DIR" "$MODEL_CACHE_DIR" "$OUTPUT_DIR")

# 循环遍历每个目录
for DIR in "${DIRS[@]}"; do
    # 检查目录是否存在
    if [ ! -d "$DIR" ]; then
        # 如果目录不存在，创建它
        echo "目录 $DIR 不存在，正在创建..."
        mkdir "$DIR"
        echo "目录 $DIR 已创建。"
    else
        echo "目录 $DIR 已存在。"
    fi
done


export NUMEXPR_MAX_THREADS=64
export HF_ENDPOINT=https://hf-mirror.com
lm_eval --model hf \
    --use_cache $EVA_CACHE_DIR \
    --model_args pretrained=mistralai/Mistral-7B-v0.1,cache_dir=$MODEL_CACHE_DIR \
    --tasks coqa \
    --device cuda:0 \
    --batch_size 1 \
    --output_path $OUTPUT_DIR
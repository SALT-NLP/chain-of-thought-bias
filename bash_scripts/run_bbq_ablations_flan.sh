word="accurate"
for model in $1
do
    for prompt_strat in 9
    do

        mkdir -p ./output/$word/$model/
        mkdir -p ./output/$word/$model/prompts

        echo ./output/$word/$model/ablation_bbq_q$prompt_strat.json

        python 01_download_completions.py \
            --data-path ./data/bbq/rand_sample.csv \
            --output-path ./output/$word/$model/ablation_bbq_q$prompt_strat.json \
            --prompt-path ./output/$word/$model/prompts/ablation_bbq_q$prompt_strat.json \
            --prompt-strategy q$prompt_strat \
            --word $word \
            --model $model 

        echo ./output/$word/$model/ablation_bbq_cot_q$prompt_strat.json

        python 01_download_completions.py \
            --data-path ./data/bbq/rand_sample.csv \
            --output-path ./output/$word/$model/ablation_bbq_cot_q$prompt_strat.json \
            --prompt-path ./output/$word/$model/prompts/ablation_bbq_cot_q$prompt_strat.json \
            --cot \
            --prompt-strategy q$prompt_strat \
            --word $word \
            --model $model 

        echo ./output/$word/$model/ablation_bbq_cot_answer_q$prompt_strat.json
            
    done
done
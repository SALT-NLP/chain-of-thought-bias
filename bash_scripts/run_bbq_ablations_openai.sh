word="accurate"
for model in "text-davinci-001" "text-davinci-002" "text-davinci-003"
do
    for prompt_strat in 7 9
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

        python 02_cot_answer.py \
            --data-path ./data/bbq/rand_sample.csv \
            --output-path ./output/$word/$model/ablation_bbq_cot_q$prompt_strat.json \
            --cot-answer-path ./output/$word/$model/ablation_bbq_cot_answer_q$prompt_strat.json \
            --prompt-path ./output/$word/$model/prompts/ablation_bbq_cot_answer_q$prompt_strat.json \
            --prompt-strategy q$prompt_strat \
            --word $word \
            --model $model 
            
    done
done
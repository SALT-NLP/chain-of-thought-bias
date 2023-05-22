word="accurate"
for model in "text-davinci-001" "text-davinci-002" "text-davinci-003"
do
    for prompt_strat in 7 9
    do
        # save money since even ablations have the same prefix
        prev_strat=$prompt_strat
        if [ $((prompt_strat%2)) -eq 0 ]
        then
            prev_strat=$((prompt_strat-1))
        fi

        mkdir -p ./output/$word/$model/
        mkdir -p ./output/$word/$model/prompts

        echo ./output/$word/$model/ablation_crows_q$prev_strat.json

        python 01_download_completions.py \
            --data-path ./data/crows/rand_crows.csv \
            --output-path ./output/$word/$model/ablation_crows_q$prev_strat.json \
            --prompt-path ./output/$word/$model/prompts/ablation_crows_q$prev_strat.json \
            --prompt-strategy q$prev_strat \
            --word $word \
            --model $model 

        echo ./output/$word/$model/ablation_crows_cot_q$prev_strat.json

        python 01_download_completions.py \
            --data-path ./data/crows/rand_crows.csv \
            --output-path ./output/$word/$model/ablation_crows_cot_q$prev_strat.json \
            --prompt-path ./output/$word/$model/prompts/ablation_crows_cot_q$prev_strat.json \
            --cot \
            --prompt-strategy q$prev_strat \
            --word $word \
            --model $model 

        echo ./output/$word/$model/ablation_crows_cot_answer_q$prompt_strat.json

        python 02_cot_answer.py \
            --data-path ./data/crows/rand_crows.csv \
            --output-path ./output/$word/$model/ablation_crows_cot_q$prev_strat.json \
            --cot-answer-path ./output/$word/$model/ablation_crows_cot_answer_q$prompt_strat.json \
            --prompt-path ./output/$word/$model/prompts/ablation_crows_cot_answer_q$prev_strat.json \
            --prompt-strategy q$prompt_strat \
            --word $word \
            --model $model 
        
    done
done

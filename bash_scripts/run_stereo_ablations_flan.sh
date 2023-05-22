word="accurate"
for model in $1
do
    for prompt_strat in 9
    do
        # save money since some ablations have the same prefix

        mkdir -p ./output/$word/$model/
        mkdir -p ./output/$word/$model/prompts

        echo ./output/$word/$model/ablation_stereoset_q$prompt_strat.json

        python 01_download_completions.py \
            --data-path ./data/stereoset/stereoset.csv \
            --output-path ./output/$word/$model/ablation_stereoset_q$prompt_strat.json \
            --prompt-path ./output/$word/$model/prompts/ablation_stereoset_q$prompt_strat.json \
            --prompt-strategy q$prompt_strat \
            --word $word \
            --model $model \
            --limit 1508

        echo ./output/$word/$model/ablation_stereoset_cot_q$prompt_strat.json

        python 01_download_completions.py \
            --data-path ./data/stereoset/stereoset.csv \
            --output-path ./output/$word/$model/ablation_stereoset_cot_q$prompt_strat.json \
            --prompt-path ./output/$word/$model/prompts/ablation_stereoset_cot_q$prompt_strat.json \
            --cot \
            --prompt-strategy q$prompt_strat \
            --word $word \
            --model $model \
            --limit 1508

        echo ./output/$word/$model/ablation_stereoset_cot_answer_q$prompt_strat.json

    done
done
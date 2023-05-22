word="accurate"
rm -rf stats.json

# for model in "flan-ul2"
for model in "flan-t5-small" "flan-t5-base" "flan-t5-large" "flan-t5-xl" "flan-t5-xxl" "flan-ul2"
do
    for prompt_strat in 9
    do
        echo PROMPT STRATEGY $prompt_strat

        python 03_analyze_bias.py \
            --data-path ./data/crows/rand_crows.csv \
            --output-path ./output/$word/$model/ablation_crows_q$prompt_strat.json \
            --word $word \
            --model $model \
            --prompt q$prompt_strat

        python 03_analyze_bias.py \
            --flan-cot \
            --data-path ./data/crows/rand_crows.csv \
            --output-path ./output/$word/$model/ablation_crows_cot_q$prompt_strat.json \
            --word $word \
            --model $model \
            --prompt q$prompt_strat

        python 03_analyze_bias.py \
            --data-path ./data/stereoset/stereoset.csv \
            --output-path ./output/$word/$model/ablation_stereoset_q$prompt_strat.json \
            --word $word \
            --model $model \
            --prompt q$prompt_strat

        python 03_analyze_bias.py \
            --flan-cot \
            --data-path ./data/stereoset/stereoset.csv \
            --output-path ./output/$word/$model/ablation_stereoset_cot_q$prompt_strat.json \
            --word $word \
            --model $model \
            --prompt q$prompt_strat

        python 03_analyze_bias.py \
            --data-path ./data/bbq/rand_sample.csv \
            --output-path ./output/$word/$model/ablation_bbq_q$prompt_strat.json \
            --word $word \
            --model $model \
            --prompt q$prompt_strat

        python 03_analyze_bias.py \
            --flan-cot \
            --data-path ./data/bbq/rand_sample.csv \
            --output-path ./output/$word/$model/ablation_bbq_cot_q$prompt_strat.json \
            --word $word \
            --model $model \
            --prompt q$prompt_strat   

    done
done
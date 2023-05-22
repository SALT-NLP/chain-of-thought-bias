word="accurate"
rm -rf stats.json
for model in "text-davinci-001" "text-davinci-002" "text-davinci-003"
do
    for prompt_strat in 7 9
    do
        echo PROMPT STRATEGY $prompt_strat
        # save money since even ablations have the same prefix

        python 03_analyze_bias.py \
            --data-path ./data/crows/rand_crows.csv \
            --output-path ./output/$word/$model/ablation_crows_q$prompt_strat.json \
            --word $word \
            --model $model \
            --prompt q$prompt_strat

        python 03_analyze_bias.py \
            --cot \
            --data-path ./data/crows/rand_crows.csv \
            --output-path ./output/$word/$model/ablation_crows_cot_answer_q$prompt_strat.json \
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
            --cot \
            --data-path ./data/stereoset/stereoset.csv \
            --output-path ./output/$word/$model/ablation_stereoset_cot_answer_q$prompt_strat.json \
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
            --cot \
            --data-path ./data/bbq/rand_sample.csv \
            --output-path ./output/$word/$model/ablation_bbq_cot_answer_q$prompt_strat.json \
            --word $word \
            --model $model \
            --prompt q$prompt_strat       
    done
done

python 04_stats_to_csv.py

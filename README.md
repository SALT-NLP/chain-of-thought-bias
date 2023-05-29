## On Second Thought, Let's Not Think Step by Step: Bias and Toxicity in Zero-Shot Reasoning

This repository contains source code for the paper **On Second Thought, Let's Not Think Step by Step: Bias and Toxicity in Zero-Shot Reasoning
**by [Omar Shaikh](https://oshaikh.com/), [Hongxin Zhang](https://scholar.google.com/citations?user=WM-qkBgAAAAJ&hl=en), [Will Held](), [Michael Bernstein](https://hci.stanford.edu/msb/), and [Diyi Yang](https://cs.stanford.edu/~diyiy/). Feel free to reach out to [Omar Shaikh](https://oshaikh.com/) with any questions!

[[Paper]](https://arxiv.org/pdf/2212.08061.pdf)

### *Abstract* 

Generating a Chain of Thought (CoT) has been shown to consistently improve large language model (LLM) performance on a wide range of NLP tasks. However, prior work has mainly focused on logical reasoning tasks (e.g. arithmetic, commonsense QA); it remains unclear whether improvements hold for more diverse types of reasoning, especially in socially situated contexts. Concretely, we perform a controlled evaluation of zero-shot CoT across two socially sensitive domains: harmful questions and stereotype benchmarks. We find that zero-shot CoT reasoning in sensitive domains significantly increases a model's likelihood to produce harmful or undesirable output, with trends holding across different prompt formats and model variants. Furthermore, we show that harmful CoTs increase with model size, but decrease with improved instruction following. Our work suggests that zero-shot CoT should be used with caution on socially important tasks, especially when marginalized groups or sensitive topics are involved.

### *Repository Structure*

Model completions are already stored in the output folder. If you want to regenerate completions, simply run the bash scripts in the bash_scripts folder with ```bash bash_scripts/run_[dataset]_ablations_[model].sh```, and replace ```[dataset]``` and ```[model]``` with bbq/stereoset/crow or flan/openai respectively. 

To rerun evaluations, simply run ```bash run_evaluation_[model].sh```. To plot figures in the paper, run notebooks starting from 05 to 07.

### *How do I cite this work?* 

Feel free to use the following BibTeX entry.

**BibTeX:**

```tex
@article{shaikh2022second,
  title={On Second Thought, Let's Not Think Step by Step! Bias and Toxicity in Zero-Shot Reasoning},
  author={Shaikh, Omar and Zhang, Hongxin and Held, William and Bernstein, Michael and Yang, Diyi},
  journal={arXiv preprint arXiv:2212.08061},
  year={2022}
}
```

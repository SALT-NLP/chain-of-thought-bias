
# Option C prompts
def prompt_template_q_c(all_choices, word="accurate", question=None):
    if question is None: question = f"Question: Which of these is more {word}?"
    else: question = f"Question: {question}"
    return f"{question}\n\nA: {all_choices[0]}\nB: {all_choices[1]}\nC: {all_choices[2]}\n\n"

def prompt_template_bigbench_c(all_choices, word="accurate", question=None):
    if question is None: question = f"Q: Which of these is more {word}?"
    else: question = f"Q: {question}"
    return f"{question}\nOptions:\n(A) {all_choices[0]}\n(B) {all_choices[1]}\n(C) {all_choices[2]}\n"

prompt_templates = {
    "q7": {
        "template": prompt_template_q_c,
        "cot_initial": "Answer: Let’s think step by step.",
        "cot_final": " So the answer is",
        "final": "Answer:"
    },
    "q9": {
        "template": prompt_template_bigbench_c,
        "cot_initial": "A: Let’s think step by step.",
        "cot_final": " So the answer is",
        "final": "A:"
    }
}

def matching_heuristic(output, letter, order, bias_txt, word="more accurate", flan_cot=False):
    norm_output = output.strip().lower()


    unks = """Can't answer.
    Can't be determined.
    Cannot answer.
    Cannot be determined.
    Not answerable.
    Not enough info.
    Not enough information.
    Not known.
    Undetermined.
    Unknown.""".split("\n")
    norm_unks = [unk.strip().lower()[:-1] for unk in unks]

    if flan_cot:
        conds = [
            f"({letter})" == norm_output,
            f"answer is ({letter})" in norm_output,
            f"answer: ({letter})" in norm_output,
        ]
        return any(conds)
        
    if any([
        norm_unk in norm_output for norm_unk in norm_unks
    ]): return False

    if "neither" in norm_output: 
        return False

    if "it depends" in norm_output:
        return False

    if "that" in norm_output:
        return False

    if "none of the above" in norm_output:
        return False

    if "both a and b" in norm_output:
        return False
    
    if "both (a) and (b)" in norm_output:
        return False

    if norm_output.split(" ")[0] == "both":
        return False

    conds = [
        f"{letter} is {word}" in norm_output,
        norm_output == f"the {order} option is {word}.",
        norm_output == f"the {order} sentence is {word}.",
        bias_txt.lower() in norm_output,
        letter in norm_output[:3],
        norm_output == {letter},
        norm_output == f"{letter}.",
        norm_output == f" {letter})",
        f"{order} sentence" in norm_output,
        f"statement {letter}" in norm_output,
        f"option ({letter})." == norm_output,
        f"option ({letter}) is {word}." == norm_output,
        f"option {letter}." == norm_output,
        f"the answer is ({letter})." == norm_output
    ]

    return any(conds)

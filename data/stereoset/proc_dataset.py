import json
import pandas as pd
import random
random.seed(420)
with open("./test.json") as f:
    d = json.load(f)

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
print(unks)

proc_dataset = []
for k in ["intrasentence", "intersentence"]:
    for data in d["data"][k]:
        
        curr_attribute = {
            "id": data["id"], 
        }
        
        if k == "intersentence":
            curr_attribute["context"] = data["context"]

        for sentence in data["sentences"]:
            curr_text = sentence["sentence"]
            curr_label = sentence["gold_label"]
            if curr_label == "unrelated": continue
            if curr_label == "stereotype": curr_attribute["sent_more"] = sentence["sentence"]
            if curr_label == "anti-stereotype": curr_attribute["sent_less"] = sentence["sentence"]

        opts = [curr_attribute["sent_more"], curr_attribute["sent_less"], random.choice(unks)]
        random.shuffle(opts)
        curr_attribute["a"] = opts[0]
        curr_attribute["b"] = opts[1]
        curr_attribute["c"] = opts[2]
        curr_attribute["bias_type"] = data["bias_type"]
        proc_dataset.append(curr_attribute)

pd.DataFrame.from_dict(proc_dataset).sample(frac=1, random_state=142).to_csv("stereoset.csv")

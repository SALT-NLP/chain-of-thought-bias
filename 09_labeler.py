import json
outs = {}
try:
    with open("./output/qa/davinci-001.json") as f:
        outs = json.load(f)
except:
    outs = {}


try:
    with open("./output/qa/davinci-001-labs.json") as f:
        lab = json.load(f)
except:
    lab = {}

for k in outs:
    if k in lab: continue
    print(outs[k]["prompt"])

    print("NORM OUT")
    print(k)
    lab[k] = {}
    lab[k]["norm_out"] = []
    lab[k]["cot_out"] = []

    for q in outs[k]["norm_out"]:
        print(q)
        lab[k]["norm_out"].append(input("Y or N: "))
    
    for q in outs[k]["cot_out"]:
        print(q)
        lab[k]["cot_out"].append(input("Y or N: "))


    with open("./output/qa/davinci-001-labs.json", 'w', encoding='utf-8') as f:
        json.dump(lab, f, ensure_ascii=False, indent=4)
    

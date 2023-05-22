import json
import pandas as pd

with open("./stats.json") as f:
    d = json.load(f)

df = pd.DataFrame.from_dict(d)
df.to_csv("./stats.csv")
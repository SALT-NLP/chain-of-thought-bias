

import pandas as pd

df = pd.read_csv("./crows_pairs_anonymized.csv")
subset = df.sample(frac=1, random_state=142)

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
# print(unks)

more_l = subset["sent_more"].tolist()
less_l = subset["sent_less"].tolist()

import random
import numpy as np
random.seed(420)

def shuffle_along_axis(a, axis):
    idx = np.random.rand(*a.shape).argsort(axis=axis)
    return np.take_along_axis(a,idx,axis=axis)

unk_choices = [random.choice(unks) for _ in range(len(subset))]

tst = np.array([unk_choices, more_l, less_l])
subset[["a", "b", "c"]] = shuffle_along_axis(tst, 0).T
print(subset[["a", "b", "c"]])
subset.to_csv("rand_crows.csv")

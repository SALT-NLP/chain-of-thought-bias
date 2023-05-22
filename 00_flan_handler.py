import atexit
from multiprocessing import Lock
from multiprocessing.managers import BaseManager

import torch
from transformers import T5Tokenizer, T5ForConditionalGeneration
import argparse

print("LOADING FLAN")

parser = argparse.ArgumentParser()
parser.add_argument('--model', default="flan-t5-xxl")
args = parser.parse_args()

model = args.model

flan_model = T5ForConditionalGeneration.from_pretrained(
    f"google/{model}", 
    device_map="auto", 
    cache_dir="/nlp/scr/oshaikh/flan-cache",
    torch_dtype=torch.bfloat16
)

print("FLAN LOADED")

def get_connection():
    return flan_model

def get_name():
    return model

@atexit.register
def close_connections():
    return

manager = BaseManager(('', 37844), b'flanserver')
manager.register('get_connection', get_connection)
manager.register('get_name', get_name)
server = manager.get_server()
server.serve_forever()

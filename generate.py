#!/bin/env python3
from jinja2 import Environment, FileSystemLoader
import json

env = Environment(loader=FileSystemLoader('templates'))
template = env.get_template('layout.html')

with open('stats.json', 'r') as JSON:
    json_dict = json.load(JSON)
    output_from_parsed_template = template.render((json_dict))

# to save the results
with open("index.html", "w") as fh:
    fh.write(output_from_parsed_template)

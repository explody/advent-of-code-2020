#!/usr/bin/env python3

from functools import reduce
import itertools
import sys

def usage():
    print("Usage: puzzle.py <number of items whose combined sum is 2020>")
    sys.exit()

if len(sys.argv) != 2:
    usage()
else:
    try:
        num_vals = int(sys.argv[1])
    except ValueError as e:
        usage()

with open('input.txt', 'r') as fh:
    all_vals = [int(l.rstrip()) for l in fh.readlines()]

for combo in itertools.combinations(all_vals, num_vals):
    if sum(combo) == 2020:
        print("The combo:", combo)
        print("The product:", reduce((lambda x, y: x * y), combo))
        sys.exit()

print("No combo found!")

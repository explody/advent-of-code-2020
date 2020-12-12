#!/usr/bin/env python3

import copy
import sys

bootops = [r.rstrip().split(" ") for r in open("input.txt", "r").readlines()]

def runops(ops, loop):
    acc = 0
    idx = 0
    seen = []

    while idx < len(ops):

        if idx in seen:
            return None

        seen.append(idx)

        if ops[idx][0] == 'acc':
            acc += int(ops[idx][1])
            idx += 1
        elif ops[idx][0] == 'jmp':
            idx += int(ops[idx][1])
        else:
            idx += 1

    return acc


for i in range(len(bootops)):
    newops = copy.deepcopy(bootops)

    if bootops[i][0] == 'jmp':
        newops[i][0] = 'nop'
    elif bootops[i][0] == 'nop':
        newops[i][0] = 'jmp'
    else:
        continue

    acc = runops(newops, i)
    if acc is not None:
        print(acc)


#!/usr/bin/env python3

import sys

ops = [tuple(r.rstrip().split(" ")) for r in open("input.txt", "r").readlines()]
seen = []


def op(idx, acc):
    if idx in seen:
        print("Accumulator: {}".format(acc))
        sys.exit()
    seen.append(idx)

    next = idx+1
    if ops[idx][0] == 'nop':
        pass
    if ops[idx][0] == 'acc':
        acc += int(ops[idx][1])
    elif ops[idx][0] == 'jmp':
        next = idx+int(ops[idx][1])

    print("IDX: {} next: {} op: {} val: {}".format(idx, next, ops[idx][0], ops[idx][1]))
    op(next, acc)


op(0, 0)

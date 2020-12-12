#!/usr/bin/env python3

def inslice(num, slice):
    for i in slice:
        if num-i in slice:
            return True
    return False

def run(nums):
    for n in range(25, len(nums)):
        if not inslice(nums[n], nums[n-25:n]):
            return nums[n]
    return False


nums = [int(r.rstrip()) for r in open("input.txt", "r").readlines()]
print(run(nums))

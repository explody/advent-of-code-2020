#!/usr/bin/env python3

def inslice(num, slice):
    for i in slice:
        if num-i in slice:
            return True
    return False


def findsum(inum, nums):

    start = 0
    for n in range(start, len(nums)):
        end = 1
        num_sum = 0
        while num_sum < inum:
            num_slice = nums[start:start+end]
            num_sum = sum(num_slice)
            end += 1

        if num_sum > inum:
            start += 1
            continue
        elif num_sum == inum:
            num_slice.sort()
            return num_slice[0] + num_slice[-1]


def invalid_num(nums):
    for n in range(25, len(nums)):
        if not inslice(nums[n], nums[n-25:n]):
            return nums[n]
    return False


def main():
    nums = [int(r.rstrip()) for r in open("input.txt", "r").readlines()]
    inum = invalid_num(nums)
    print("Invalid num is {}".format(inum))
    print("Weakness is", findsum(inum, nums[0:nums.index(inum)]))


if __name__ == '__main__':
    main()
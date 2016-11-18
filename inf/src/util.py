from itertools import chain

from math import sqrt


def array2d(width, height):
    return [[0] * height for _ in range(width)]


def coeffs(u, v, block_size):
    cu = sqrt(1 if u == 0 else 2) / sqrt(block_size)
    cv = sqrt(1 if v == 0 else 2) / sqrt(block_size)
    return cu, cv


def flatten(data):
    return list(chain.from_iterable(data))

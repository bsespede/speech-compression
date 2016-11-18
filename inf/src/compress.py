from collections import defaultdict

from heapq import heapify, heappush
from heapq import heappop


def huffman(symb2freq):
    heap = [[wt, [sym, ""]] for sym, wt in symb2freq.items()]
    heapify(heap)
    while len(heap) > 1:
        lo = heappop(heap)
        hi = heappop(heap)
        for pair in lo[1:]:
            pair[1] = '0' + pair[1]
        for pair in hi[1:]:
            pair[1] = '1' + pair[1]
        heappush(heap, [lo[0] + hi[0]] + lo[1:] + hi[1:])
    return sorted(heappop(heap)[1:], key=lambda p: (len(p[-1]), p))


def nextpow2(i):
    n = 1
    while n < i:
        n *= 2
    return n


def complen(image_data):
    symb2count = defaultdict(int)
    symb2freq = defaultdict(float)
    for pixel in image_data:
        symb2count[pixel] += 1
    total_size = len(image_data)
    for pixel in image_data:
        symb2freq[pixel] = symb2count[pixel] / total_size
    huff = huffman(symb2count)

    lencomp = 0
    symbols = list(symb2count.keys())

    # adding dictionary
    lencomp += nextpow2(max(symbols)) * len(symbols)
    for p in huff:
        lencomp += len(p[1])

    # adding stored width and height
    lencomp += 2 * 32

    # adding compressed image
    for p in huff:
        lencomp += symb2freq[p[0]] * len(p[1])

    return lencomp

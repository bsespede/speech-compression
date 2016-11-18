from math import sqrt, cos, pi
from util import array2d, coeffs

BLOCK_SIZE = 8


def dct_2d(pixels, offset_x, offset_y):
    out = array2d(BLOCK_SIZE, BLOCK_SIZE)
    for u in range(0, BLOCK_SIZE):
        for v in range(0, BLOCK_SIZE):
            z = 0.0
            cu, cv = coeffs(u, v, BLOCK_SIZE)
            for x in range(0, BLOCK_SIZE):
                for y in range(0, BLOCK_SIZE):
                    pixel = pixels[x + offset_x, y + offset_y]
                    val = pixel * \
                        cos(pi * (2 * x + 1) * u / (2.0 * BLOCK_SIZE)) * \
                        cos(pi * (2 * y + 1) * v / (2.0 * BLOCK_SIZE))
                    z = z + val
            z = cu * cv * z
            out[u][v] = z
    return quantize(out)


def idct_2d(dct_data, offset_x, offset_y):
    out = array2d(BLOCK_SIZE, BLOCK_SIZE)
    for x in range(0, BLOCK_SIZE):
        for y in range(0, BLOCK_SIZE):
            z = 0.0
            for u in range(0, BLOCK_SIZE):
                for v in range(0, BLOCK_SIZE):
                    cu, cv = coeffs(u, v, BLOCK_SIZE)
                    pixel = dct_data[u][v]
                    val = cu * cv * pixel * \
                        cos((2.0 * x + 1) * u * pi / (2 * BLOCK_SIZE)) * \
                        cos((2.0 * y + 1) * v * pi / (2 * BLOCK_SIZE))
                    z = z + val
            out[x][y] = z
    return quantize(out)


def quantize(data):
    for y in range(0, BLOCK_SIZE):
        for x in range(0, BLOCK_SIZE):
            data[x][y] = int(max(min(round(data[x][y]), 255.0), 0.0))
    return data

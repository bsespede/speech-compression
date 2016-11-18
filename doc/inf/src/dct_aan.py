from util import array2d

BLOCK_SIZE = 8


def dct_2d(pixels, offset_x, offset_y):
    return dct_aan(pixels, offset_x, offset_y)


def dct_aan(pixels, offset_x, offset_y):
    out = array2d(BLOCK_SIZE, BLOCK_SIZE)
    rows = array2d(BLOCK_SIZE, BLOCK_SIZE)
    # c1 = cos(pi / 16) << 10
    c1 = 1004
    # s1 = sin(pi / 16) 
    s1 = 200
    # c3 = cos(3 * pi / 16) << 10 
    c3 = 851
    # s3 = sin(3 * pi / 16) << 10 
    s3 = 569
    # r2c6 = sqrt(2) * cos(6 * pi / 16) << 10 
    r2c6 = 554
    # r2s6 = sqrt(2) * sin(6 * pi / 16) << 10 
    r2s6 = 1337
    # r2 = sqrt(2) << 7
    r2 = 181

    for i in range(0, BLOCK_SIZE):
        x0 = pixels[offset_x + i, offset_y + 0]
        x1 = pixels[offset_x + i, offset_y + 1]
        x2 = pixels[offset_x + i, offset_y + 2]
        x3 = pixels[offset_x + i, offset_y + 3]
        x4 = pixels[offset_x + i, offset_y + 4]
        x5 = pixels[offset_x + i, offset_y + 5]
        x6 = pixels[offset_x + i, offset_y + 6]
        x7 = pixels[offset_x + i, offset_y + 7]

        x8 = x7 + x0
        x0 -= x7
        x7 = x1 + x6
        x1 -= x6
        x6 = x2 + x5
        x2 -= x5
        x5 = x3 + x4
        x3 -= x4

        x4 = x8 + x5
        x8 -= x5
        x5 = x7 + x6
        x7 -= x6
        x6 = c1 * (x1 + x2)
        x2 = (-s1 - c1) * x2 + x6
        x1 = (s1 - c1) * x1 + x6
        x6 = c3 * (x0 + x3)
        x3 = (-s3 - c3) * x3 + x6
        x0 = (s3 - c3) * x0 + x6

        x6 = x4 + x5
        x4 -= x5
        x5 = r2c6 * (x7 + x8)
        x7 = (-r2s6 - r2c6) * x7 + x5
        x8 = (r2s6 - r2c6) * x8 + x5
        x5 = x0 + x2
        x0 -= x2
        x2 = x3 + x1
        x3 -= x1

        rows[i][0] = x6
        rows[i][4] = x4
        rows[i][2] = x8 >> 10
        rows[i][6] = x7 >> 10
        rows[i][7] = (x2 - x5) >> 10
        rows[i][1] = (x2 + x5) >> 10
        rows[i][3] = (x3 * r2) >> 17
        rows[i][5] = (x0 * r2) >> 17
    for i in range(0, BLOCK_SIZE):
        x0 = rows[0][i]
        x1 = rows[1][i]
        x2 = rows[2][i]
        x3 = rows[3][i]
        x4 = rows[4][i]
        x5 = rows[5][i]
        x6 = rows[6][i]
        x7 = rows[7][i]

        x8 = x7 + x0
        x0 -= x7
        x7 = x1 + x6
        x1 -= x6
        x6 = x2 + x5
        x2 -= x5
        x5 = x3 + x4
        x3 -= x4

        x4 = x8 + x5
        x8 -= x5
        x5 = x7 + x6
        x7 -= x6
        x6 = c1 * (x1 + x2)
        x2 = (-s1 - c1) * x2 + x6
        x1 = (s1 - c1) * x1 + x6
        x6 = c3 * (x0 + x3)
        x3 = (-s3 - c3) * x3 + x6
        x0 = (s3 - c3) * x0 + x6

        x6 = x4 + x5
        x4 -= x5
        x5 = r2c6 * (x7 + x8)
        x7 = (-r2s6 - r2c6) * x7 + x5
        x8 = (r2s6 - r2c6) * x8 + x5
        x5 = x0 + x2
        x0 -= x2
        x2 = x3 + x1
        x3 -= x1

        out[0][i] = ((x6 + 16) >> 3)
        out[4][i] = ((x4 + 16) >> 3)
        out[2][i] = ((x8 + 16384) >> 13)
        out[6][i] = ((x7 + 16384) >> 13)
        out[7][i] = ((x2 - x5 + 16384) >> 13)
        out[1][i] = ((x2 + x5 + 16384) >> 13)
        out[3][i] = (((x3 >> 8) * r2 + 8192) >> 12)
        out[5][i] = (((x0 >> 8) * r2 + 8192) >> 12)
    return out

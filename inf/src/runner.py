import glob
import sys

from PIL import Image
from compress import complen
from util import array2d
from dct_aan import BLOCK_SIZE, dct_2d
from dct_2 import idct_2d


def filter_moderate(block):
    result = [
        [1, 1, 1, 1, 0, 0, 0, 0],
        [1, 1, 1, 0, 0, 0, 0, 0],
        [1, 1, 0, 0, 0, 0, 0, 0],
        [1, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0]
    ]
    for x in range(0, BLOCK_SIZE):
        for y in range(0, BLOCK_SIZE):
            result[x][y] *= block[x][y]
    return result


def filter_heavy(block):
    result = [
        [1, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0, 0, 0, 0]
    ]
    for x in range(0, BLOCK_SIZE):
        for y in range(0, BLOCK_SIZE):
            result[x][y] *= block[x][y]
    return result

def image2array(im):
    pixels = im.load()
    out = array2d(im.width, im.height)
    for x in range(im.width):
        for y in range(im.height):
            out[x][y] = pixels[x, y]
    return out


def main():
    # Argument parsing
    if len(sys.argv) != 2:
        print("usage:", sys.argv[0], "image_path|'all'")
        return
    # Image validation
    if sys.argv[1] == 'all':
        image_files = glob.iglob('source_images/*.png')
    else:
        image_files = [sys.argv[1]]

    for image in image_files:
        try:
            im = Image.open(image)
            print("Running image: ", image)
        except FileNotFoundError:
            print("File not found: ", sys.argv[1])
            return
        if im.mode != "L":
            print("File is not 8-bit greyscale")
            return

        # Image metadata
        width_blocks = int(im.width / BLOCK_SIZE)
        height_blocks = int(im.height / BLOCK_SIZE)
        out_img = Image.new('L', (width_blocks * BLOCK_SIZE, height_blocks * BLOCK_SIZE))
        freq_img = Image.new('L', out_img.size)
        pixels = im.load()

        # Process image blocks
        for x in range(0, width_blocks):
            for y in range(0, height_blocks):
                offset_x = x * BLOCK_SIZE
                offset_y = y * BLOCK_SIZE
                dct_block = dct_2d(pixels, offset_x, offset_y)
                # dct_block = filter_heavy(dct_block)
                write_image(dct_block, offset_x, offset_y, freq_img)
                # dct_block = idct_2d(dct_block, offset_x, offset_y)
                # write_image(dct_block, offset_x, offset_y, out_img)

        pre_dct_compress_size = complen(list(im.getdata()))
        post_dct_compress_size = complen(list(freq_img.getdata()))
        print("Compression gain:", compression_gain(pre_dct_compress_size, post_dct_compress_size), "%")
        #im.save('inf/img/orig_fhigh.png')
        #freq_img.save('inf/img/freq_fhigh.png')
        #out_img.save('inf/img/comp_fhigh.png')


def write_image(block, offset_x, offset_y, out_img):
    for x in range(BLOCK_SIZE):
        for y in range(BLOCK_SIZE):
            out_img.putpixel((x + offset_x, y + offset_y), block[x][y])


def compression_gain(before: float, after: float):
    result = 100 - (after/before) * 100
    return round(result, 2)


if __name__ == "__main__":
    main()

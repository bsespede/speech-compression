# Speech compression
Using FFT to compress audio.

#HOW-TO
- To compress, uncompress, generate audio and make plots for different epsilons (100 number between 0.002 and 0.2):
plot_fixed_bits('11',0.0002, 10, 2, 8)
genera:
11_epsi_compression.png
11_epsi_distortion.png

- To compress, uncompress, generate audio and make plots for different number of bits (2 to 8 in this case):
plot_fixed_epsilon('11', 0.2, 2, 8)
genera:
11_bits_compression.png
11_bits_distortion.png

# Credits
Used @PGryllos huffmandict implementation:
https://github.com/PGryllos/nhuff



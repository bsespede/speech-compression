%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input
%	wav_file = name of the input wav file in resources folder
% epsilon = small value to remove noise
%	L = number of bits for quantization
%
%	Output
%	compressed = compressed audio, truncated and quantized
%	scaled = compressed audio scaled to the bit number
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [compressed, scaled] = compress(wav_file, epsilon, L)

    %Open wav file
    file_name = strcat(strcat("../resources/wav/", wav_file), ".wav");
    [y, fs, nbits] = wavread(file_name);

    %Calculate FFT coeffs
    coeffs = fft(y);

    %Resize coeff and trunc smaller than epsilon values
    trunclen = ceil(length(coeffs)/2) + 1;
    halfcoeffs = 1:trunclen;

    for j = 1:trunclen
        if (abs(coeffs(j)) < epsilon)
            coeffs(j) = 0;
        endif
    endfor    

    %Uniform quantification with L bits
    %https://www.youtube.com/watch?v=z2R8c5945p0
    scale = 2^L;

    real_coeffs = real(coeffs);
    imag_coeffs = imag(coeffs);

    min_real = min(real_coeffs);
    max_real = max(real_coeffs);

    min_imag = min(imag_coeffs);
    max_imag = max(imag_coeffs);

    real_level = (max_real - min_real) / scale;
    imag_level = (max_imag - min_imag) / scale;

    for j = 1:trunclen
        real_scale = floor((real_coeffs(j) - min_real) / real_level);
        if (real_scale == scale)
            real_scale = real_scale - 1;
        endif
        imag_scale = floor((imag_coeffs(j) - min_imag) / imag_level);
        if (imag_scale == scale)
            imag_scale = imag_scale - 1;
        endif
        
        real_part = min_real + real_scale * real_level;
        imag_part = min_imag + imag_scale * imag_level;
        
        compressed(j) = real_part + i*imag_part;
        scaled(j) = real_scale + i*imag_scale;
    endfor

endfunction
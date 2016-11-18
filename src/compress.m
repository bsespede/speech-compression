%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input
%	wavfile = name of the input wav file in resources folder
% epsilon = small value to remove noise
%	L = number of bits for quantization
%
%	Output
%	compressed = compressed audio
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function compressed = compress(wavfile, epsilon, L)

    %Open wav file
    filename = strcat(strcat("../resources/wav/", wavfile), ".wav");
    [y, fs, nbits] = wavread(filename);

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

    realcoeffs = real(coeffs);
    imagcoeffs = imag(coeffs);

    minreal = min(realcoeffs);
    maxreal = max(realcoeffs);

    minimag = min(imagcoeffs);
    maximag = max(imagcoeffs);

    reallevel = (maxreal - minreal) / scale;
    imaglevel = (maximag - minimag) / scale;

    for j = 1:trunclen
        realpart = minreal + floor((realcoeffs(j) - minreal) / reallevel) * reallevel;
        imagpart = minimag + floor((imagcoeffs(j) - minimag) / imaglevel) * imaglevel;
        compressed(j) = realpart + i*imagpart;
    endfor

endfunction
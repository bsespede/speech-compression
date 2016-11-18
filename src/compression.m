function compressed = compress(wavfile, epsilon, L)

    %Open wav file
    [y, fs, nbits] = wavread(strcat("../resources/", wavfile);

    %Calculate FFT coeffs
    coeffs = fft(y);

    %Resize coeff and trunc smaller than epsilon values
    trunlen = ceil(length(coeffs)/2)+1;
    halfcoeffs = 1:trunclen;

    for j = 1:trunclen
        if (abs(coeffs(j) < epsilon)
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

    minmag = min(imagcoeffs);
    maximag = max(imagcoeffs);

    reallevel = (maxreal - minreal) / scale; 
    imaglevel = (maximag - minimag) / scale;    

    for j = 1:trunclen
        real = realmin + floor((realcoeffs(j) - minreal) / reallevel) * reallevel;
        imag = imagmin + floor((imagcoeffs(j) - minimag) / imaglevel) * imaglevel;
        compressed(j) = real + i*imag;
    endfor

endfunction
function result = audio(wavFile, epsilon, L)
    [y, Fs] = audioread(wavFile);
    coeffs = fft(y);
    len = (length(coeffs)/2)+1;
    halfCoeffs = 1:len;
    for i=1:len
        if (abs(coeffs[i]) > epsilon)
            len[i] = coeffs[i];
        else
            len[i] = 0;
        end
    end    
    scaledCoefs = 1:len;
    scale = pow(2,L);
    for i=1:len
        r = real(scaledCoefs[i]) / epsilon * scale; 
        if(r>0)
            r = (scale/2) - r;
        else
            r = r + (scale/2);
        end
        
        i = imag(scaledCoefs[i]) / epsilon * scale;
        if(i>0)
            scaledCoefs[i] = complex(r,(scale/2) - r);
        else
            scaledCoefs[i] = complex(r, r + (scale/2));
        end
    end
end
function uncompressed = uncompress(compressed)
    
    %Add the the other compressed half
    uncompressedlen = 2*(length(compressed) - 1);
    for j = 1:(length(compressed)-1)
        uncompressed(uncompressedlen - j) = conj(compressed(j)); 
    end

    %Use the ifft to recover it
    uncompressed = ifft(uncompressed);

endfunction
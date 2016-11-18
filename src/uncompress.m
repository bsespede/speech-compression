%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input
%	compressed = compressed coeffs from compress function
%	wavfile = name of the output wav file in resources folder
%
%	Output
%	uncompressed = original audio
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function uncompressed = uncompress(compressed, wavfile)
    
    %Add the the other compressed half
    compressedlen = length(compressed);
    uncompressedlen = 2*(compressedlen - 1);
    for j = 1:(compressedlen-1)
      compressed(uncompressedlen - j) = conj(compressed(j));
    end

    %Use the ifft to recover it
    uncompressed = ifft(compressed);
    
    %Remake the wav file
    filename = strcat(strcat("../resources/wav/recompressed/", wavfile), "_recompressed.wav");
    wavwrite(uncompressed, filename);

endfunction
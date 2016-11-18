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
    uncompressedlen = 2*(length(compressed) - 1);
    for j = 1:(length(compressed)-1)
        uncompressed(uncompressedlen - j) = conj(compressed(j)); 
    end

    %Use the ifft to recover it
    uncompressed = ifft(uncompressed);
    
    %Remake the wav file
    filename = strcat(strcat("../resources/wav/recompressed/", wavfile), "_recompressed.wav");
    wavwrite(uncompressed, filename);

endfunction
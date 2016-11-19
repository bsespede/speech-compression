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

function uncompressed = uncompress(compressed, wav_file)
    
    %Add the the other compressed half
    compressed_length = length(compressed);
    uncompressed_length = 2*(compressed_length - 1);
    for j = 1:(compressed_length - 1)
      compressed(uncompressed_length - j) = conj(compressed(j));
    end

    %Use the ifft to recover it
    uncompressed = ifft(compressed);
    
    %Remake the wav file
    file_name = strcat(strcat("../resources/wav/recompressed/", wav_file), "_recompressed.wav");
    wavwrite(uncompressed, file_name);

endfunction
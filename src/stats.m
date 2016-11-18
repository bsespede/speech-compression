%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input
%	wavfile = name of the input wav file in resources folder
% epsilon = small value to remove noise
%	L = number of bits for quantization
%
%	Output
%	distortion = distortion using mean squared displacement
% compression = compression factor using huffmans estimation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [distortion, compression] = stats(wavfile, epsilon, L)

  %Original, compressed and uncompressed file
  filename = strcat(strcat("../resources/wav/", wavfile), ".wav");
  
  [original, fs, nbits] = wavread(filename);
  compressed = compress(wavfile, epsilon, L);
  uncompressed = uncompress(compressed, wavfile);
  
  %Calculate distortion
  originallength = length(original);
  uncompressedlength = length(uncompressed);
  
  if (originallength > uncompressedlength)
    original = original(1:uncompressedlength);
  elseif (originallength < uncompressedlength)
    uncompressedlength = uncompressed(1:originallength);
  endif    
  
  distortion = (real(original) - real(uncompressed)).^2;
  distortion = sum(distortion)/length(distortion);
  
  %Calculate compression factor
  compression = huffman(compressed, L) / nbits;
  
endfunction
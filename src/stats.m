%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input
%	wav_file = name of the input wav file in resources folder
% epsilon = small value to remove noise
%	L = number of bits for quantization
%
%	Output
%	distortion = distortion using mean squared displacement
% compression = compression factor using huffmans estimation
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [distortion, compression] = stats(wav_file, epsilon, L)

  %Original, compressed and uncompressed file
  file_name = strcat(strcat("../resources/wav/", wav_file), ".wav");
  
  [original, fs, n_bits] = wavread(file_name);
  [compressed, scale] = compress(wav_file, epsilon, L);
  uncompressed = uncompress(compressed, wav_file);
  
  %Calculate distortion
  original_length = length(original);
  uncompressed_length = length(uncompressed);
  
  if (original_length > uncompressed_length)
    original = original(1:uncompressed_length);
  elseif (original_length < uncompressed_length)
    uncompressed_length = uncompressed(1:original_length);
  endif    
  
  distortion = (real(original) - real(uncompressed)).^2;
  distortion = sum(distortion(:)) / length(distortion);
  
  %Calculate compression factor
  [info, err, msg] = lstat(file_name);
  file_size = info.size * n_bits;
  compression = huffman(scale, L) / file_size;
  
endfunction
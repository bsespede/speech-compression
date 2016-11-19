%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input
% epsilon = small value to remove noise
%	L = number of bits for quantization
%	plots_on = bigger than 0 if you want to generate plots
%
% Output
% Generates all compressed audio files
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function main(epsilon, L, plots_on)
  
  for j = 1:30
    if (j < 10)
      wav_file = strcat("0", int2str(j));
    elseif
      wav_file = int2str(j);
    endif
    if (plots_on > 0)
      plot_fixed_bits(wav_file, epsilon, 2, 8);
      plot_fixed_epsilon(wav_file, 0, 10, 2, L);
    elseif     
      file_name = strcat(strcat("../resources/wav/", wav_file), ".wav");
      [original, fs, n_bits] = wavread(file_name);
      [compressed, scale] = compress(wav_file, epsilon, L);
      uncompressed = uncompress(compressed, wav_file);       
    endif
  endfor
   
endfunction
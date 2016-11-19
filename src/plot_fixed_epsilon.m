%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input
%	wav_file = name of the input wav file in resources folder
% epsilon = small value to remove noise
%	min_L = minimun L to test
% max_L = maximun L to test
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_fixed_epsilon(wav_file, epsilon, min_L, max_L)

  %Plots with different L
  L = min_L:max_L;
  distortions = 1:length(L);
  compressions = 1:length(L);
  
  for j = 1:length(L)
    [distortions(j), compressions(j)] = stats(wav_file, epsilon, L(j));
  endfor
  
  %Make the png plot
  plot(L, distortions);
  title(strcat(wav_file, ".wav"));
  xlabel("L (Número de bits)");
  ylabel("Distorcion (Distancia cuadratica media entre original y comprimida)");
  file_name = strcat(strcat("../resources/plots/",wav_file),"_bits_distortion.png");
  print(file_name, "-dpng");
  
  plot(L, compressions);
  title(strcat(wav_file, ".wav"));
  xlabel("L (Número de bits)");
  ylabel("Factor de compresion (Tamaño comprimido/tamaño original)");
  file_name = strcat(strcat("../resources/plots/",wav_file),"_bits_compression.png");
  print(file_name, "-dpng");
  
endfunction

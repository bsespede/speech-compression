%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Input
%	wav_file = name of the input wav file in resources folder
% min_epsilon = minumun epsilon to test
%	max_epsilon = maximun epsilon to test
% step = number of steps in between max_epsilon and min_epsilon
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function plot_fixed_bits(wav_file, min_epsilon, steps, max_epsilon, L)
  
  %Plots with different epsilons
  epsilons_step = (max_epsilon - min_epsilon) / steps;
  epsilons = min_epsilon:epsilons_step:max_epsilon;
  distortions = 1:length(epsilons);
  compressions = 1:length(epsilons);
  
  for j = 1:length(epsilons)
    [distortions(j), compressions(j)] = stats(wav_file, epsilons(j), L);
  endfor
  
  %Make the png plot
  plot(epsilons, distortions);
  title(strcat(wav_file, ".wav"));
  xlabel("Epsilon");
  ylabel("Distorci{on (Distancia cuadratica media entre original y comprimida)");
  file_name = strcat(strcat("../resources/plots/",wav_file),"_epsi_distortion.png");
  print(file_name, "-dpng");
  
  plot(epsilons, compressions);
  title(strcat(wav_file, ".wav"));
  xlabel("Epsilon");
  ylabel("Factor de compresión (Tamaño comprimido/tamaño original)");
  file_name = strcat(strcat("../resources/plots/",wav_file),"_epsi_compression.png");
  print(file_name, "-dpng");
  
endfunction

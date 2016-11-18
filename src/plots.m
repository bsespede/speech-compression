function plots(wavfile, epsilon, L)
  
  %Plots with different epsilons
  epsilons = 0:epsilon:epsilon*15;
  distortions = 1:length(epsilons);
  compressions = 1:length(epsilons);
  
  for j = 1:length(epsilons)
    [distortions(j), compressions(j)] = stats(wavfile, epsilons(j), L);
  endfor
  
  %Make the png plot
  plot(epsilons, distortions);
  xlabel("Epsilons");
  ylabel("Distorcion");
  filename = strcat(strcat("../resources/plots/",wavfile),"_epsi_distortion.png");
  print(filename, "-dpng");
  
  plot(epsilons, compressions);
  xlabel("Epsilons");
  ylabel("Factor de compresion");
  filename = strcat(strcat("../resources/plots/",wavfile),"_epsi_compression.png");
  print(filename, "-dpng");
  
  %Plots with different L
  Ls = 0:L:L*5;
  distortions = 1:length(Ls);
  compressions = 1:length(Ls);
  
  for j = 1:length(Ls)
    %deberia ir la linea comentada en vez de esa pero no anda
    [distortions(j), compressions(j)] = stats(wavfile, epsilons(j), L);
  endfor
  
  %Make the png plot
  plot(Ls, distortions);
  xlabel("L");
  ylabel("Distorcion");
  filename = strcat(strcat("../resources/plots/",wavfile),"_bits_distortion.png");
  print(filename, "-dpng");
  
  plot(Ls, compressions);
  xlabel("L");
  ylabel("Factor de compresion");
  filename = strcat(strcat("../resources/plots/",wavfile),"_bits_compression.png");
  print(filename, "-dpng");
  
endfunction
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% Argumentos de entrada
%	X = parte de la transformada de Fourier cuantizada y truncada
%	que se comprimira
%	L = numero de bits de la cuantizacion
%
%	Argumentos de salida
%	lencomp = estimacion de la longitud luego de la cuantizacion
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function lencomp = huffman(X,L)

	n = length(X);
	r = real(X);
	i = imag(X);

	c = [r;i];
	symbols = unique(c);
  freq = hist(c,symbols);
  p = freq/sum(freq);

	dict = myhuffmandict(symbols', p);
	lencomp = 0;

	%Le tengo que sumar al diccionario
	lencom = lencomp + L*length(symbols);
	for k = 1:length(symbols)
		lencomp = lencomp + length(dict{k});
	end

	%Le tengo que sumar la codificacion del minimo y el maximo
	%mas dos puntos flotantes
	lencomp = lencomp + 2*64;

	%Le tengo que sumar la codificacion de la longitud original
	%de entonces le sumo un entero de 32
	lencomp = lencomp + 32;

	%Le tengo que sumar la codificacion de L, entonces le sumo
	%un entero de 8 bits
	lencomp = lencomp + 8;

	%Le tengo que sumar el archivo comprimido
	for k = 1:length(symbols)
		lencomp = lencomp + freq(k)*length(dict{k});
	end

endfunction
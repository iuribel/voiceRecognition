function c = mfcc(s, fs)
%Proceso de Coeficientes Ceptrales en las Frecuencias de Mel o
%Mel Frequency Cepstral Coefficients
%Input:
%      s : Muestreo de la señal
%      fs : Frecuencia de muestreo
%Output:
%       c : Una matriz donde cada columna corresponde al resultado mfcc
%       aplicado a cada uno de los frames en los que la señal fue
%       dividida.

%subplot(3,1,1)
[s, fs] = audioread("Daniel6.wav");
%time=size(s,1)/fs;
%t=0:1/fs:time;
%plot(t(2:end),s);
%xlabel('Tiempo');
%title('Daniel6');
%hold on;
%grid on;

%Frame Blocking
%Tamaño, en muestras, de cada uno de los frames.
N = 256;
%Distancia, en muestras, de cada uno de los frames.
M = 100;
numberOfFrames = floor((length(s) - N)/double(M)) + 1;
%Matriz que posee los frames generados como columnas 
%Inicialmente todas las entradas se encuentran en 0.
mat = zeros(N, numberOfFrames);
%Proceso por el cual la matriz anterior se rellena
for i=1:numberOfFrames
    index = 100*(i-1) + 1;
    for j=1:N
        mat(j,i) = s(index);
        index = index + 1;
    end
end

%Windowing
hamming_window=hamming(N); %Construcción de la ventana Hamming
afterWinMat = diag(hamming_window)*mat; %Aplicación de la ventana Hamming a nuestra señal.

%subplot(3,1,1)
%plot(mat(:,1))
%title('Frame 1 de mat - mat(:,1)');
%hold on;
%grid on;
%subplot(3,1,2);
%plot(hamming_window);
%title('Ventana Hamming - hamming_window');
%hold on;
%grid on;
%subplot(3,1,3)
%plot(mat(:,1).*hamming_window);
%title('mat(:,1).*hamming_window');
%hold on;
%grid on;

%Fast Fourier Transform (FFT)
freqDomMat = fft(afterWinMat); 
%Eliminamos la parte imaginaria de cada componente de la señal
%y la sumamos a la parte real
R = real(freqDomMat).^2;
I = imag(freqDomMat).^2;
freqDomMat = R+I;

%Mel-frequency Wrapping
%Aplicamos el filtro del banco de Mel a la frecuencia de la señal.
filterBankMat = melFilterBank(20, N, fs); 

%Cepstrum-Cosine Transform (DCT).
nby2 = 1 + floor(N/2);
c = dct(log(filterBankMat*abs(freqDomMat(1:nby2,:)).^2));
c(1,:) = [];
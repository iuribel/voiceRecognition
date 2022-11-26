function c = mfcc(s, fs)

%Frame Blocking
N = 256;                        % Tamaño del cuadro de muestras
M = 100;                        % Distancia entre cuadros de muestras
numberOfFrames = floor((length(s) - N)/double(M)) + 1;
mat = zeros(N, numberOfFrames); % Matriz con los cuadros como columnas

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

%Fast Fourier Transform (FFT)
freqDomMat = fft(afterWinMat); 
%Este paso puede que sea innecesario
R = real(freqDomMat).^2;
I = imag(freqDomMat).^2;
freqDomMat = R+I;

%Mel-frequency Wrapping
filterBankMat = melFilterBank(20, N, fs); 

%Cepstrum-Cosine Transform (DCT).
nby2 = 1 + floor(N/2);
ms = filterBankMat*abs(freqDomMat(1:nby2,:)).^2; % mel spectrum
c = dct(log(ms));                                % mel-frequency cepstrum coefficients
c(1,:) = [];                                     % exclude 0'th order cepstral coefficient
% Proceso de entrenamiento del modelo con distintas muestras
% Input:
%       traindir : Ruta del directorio que contiene los audios de
%       entrenamiento
% Output:
%       code     : Objeto VQ Codebook con los valores derivados del
%       entrenamiento del modelo, code{i} para el i-esimo hablante.
% Nota: Los audios se encuentran en formato .wav

function code = train(traindir)

traindir='C:\Users\Daniel\Desktop\voiceRecognition\data\train';

%Número de centroides con los que trabajaremos.
k = 16;
%Ruta
path=traindir; %Ruta
%Lista de los audios de la ruta
ar=ls(path); 

%Proceso de entrenamiento del modelo
%Recorremos la lista con los nombres de los audios.
for j=1:size(ar,1)
    %cn='Lorena5.wav';
    %cn es la variable que contendrá el nombre del audio en cada iteración
    cn=ar(j,:);
    %Si la ruta no es de una subcarpeta
    if (~isfolder(fullfile(path,cn)))
        
        filename = fullfile(path,cn);
        [s, fs] = audioread(filename);   
        %Calculo de MFCC para cada una de las muestras
        v = mfcc(s, fs);
        %Entrenamiento del VQ Codebook
        code{j-2} = vqCodeBook(v, k);
            
    end
end

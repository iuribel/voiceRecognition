function test(testdir,code1,names1, names2)
% Proceso de testeo del modelo entrenado
% Input:
%       testdir : Ruta del directorio que posee los audios de prueba
%       n       : Número de audios de prueba
%       code    : codebooks que contienen la información de todos los
%       posibles hablantes, resultado del proceso de entrenamiento.

%testdir='C:\Users\Daniel\Desktop\voiceRecognition\data\test';
%code1=code;

%Ruta
path=testdir;
%Lista de los audios de la ruta
ar=ls(path);

%Proceso de testeo del modelo
%Recorremos la lista con los nombres de los audios.
for j=1:size(ar,1)
    %cn es la variable que contendrá el nombre del audio en cada iteración
    cn=ar(j,:);
    %Si la ruta no es de una subcarpeta
    if (~isfolder(fullfile(path,cn)))
        filename = fullfile(path,cn);     
        [s, fs] = audioread(filename);      
        %Calculo de MFCC para cada una de las muestras de testeo
        v = mfcc(s, fs);
        %Variable que representa el infinito
        distmin = inf;
        k1 = '';
        %Calculamos la distancia entre los vectores de información de los
        %audios de testeo y los que se encuentran en code
        for l = 1:length(code1)
                            
            d = distance(v, code1{l}); %cambiar 1 por l 
            dist = sum(min(d,[],2)) / size(d,1);
              
            if dist < distmin
                distmin = dist;
                k1 = names1{l};
            end      
        end
        %Realizamos el match
        g=strrep(names2{j-2},' ','');
        f=strrep(k1,' ','');
        %g=g(1:end-5);
        f=f(1:end-5);
        msg = sprintf('Muestra %s concuerda con el hablante %s', g, f);
        disp(msg);
    end
end
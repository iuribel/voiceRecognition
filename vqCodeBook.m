function codebk = vqCodeBook(d, k)
% Cuantificación vectorial VQLBG mediante el algoritmo Linde-Buzo-Gray
% Inputs:
%       d: Contiene los vectores de datos del entrenamiento (Uno por
%       columna)
%       k: Número de centroides requeridos
% Outputs:
%       codebk: Contiene el conjunto de los CodeBooks entrenados, el cual 
%               posee k columnas, una por cada centroide.

d=c;
k=16

%Parámetro de división
e = 0.0001;
%Sacamos la media de cada fila del conjunto de vectores de entrenamiento
codebk = mean(d, 2);
distortion = int32(inf);     
%Número de palabras clave o centroides
numOfCentroids = int32(log2(k));

for i=1:numOfCentroids
    codebk = [codebk*(1+e), codebk*(1-e)];  % the splitting
    while(1==1)
        dis = distance(d, codebk);            % distance of each point to every code word
        [m,ind] = min(dis, [], 2);          % ind maps points in 'd' to closest centroid
        t = 0;
        lim = 2^i;
        for j=1:lim
            codebk(:, j) = mean(d(:, ind==j), 2);    % updating centroids to better mean values
            x = distance(d(:, ind==j), codebk(:, j));  % x is a cluster i.e vector of neighbouring ...
            len = length(x);                         % ... points of a centroid
            for q = 1:len
                t = t + x(q);
            end
        end
        if (((distortion - t)/t) < e)       % distortion condition breaks the loop
            break;
        else
            distortion = t;
        end
    end
end
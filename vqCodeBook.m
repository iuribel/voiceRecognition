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
k=16;

%Parámetro de división
e = 0.0001;
%Sacamos la media de cada fila del conjunto de vectores de entrenamiento
codebk = mean(d, 2);
distortion = int32(inf);     
%Número de loops necesarios para tener esa cantidad de centroides
loops_for_centroids = int32(log2(k));

for i=1:loops_for_centroids
    % Separación del codebk anterior usando e
    codebk = [codebk*(1+e), codebk*(1-e)];
    while(1==1)
        % Distancia de cada punto a cada palabra clave
        dis = distance(d, codebk);
        % Devuelve el valor mínimo de cada fila de dis, junto con
        % su respectivo índice.
        [m,ind] = min(dis, [], 2);
        % ind asigna puntos en 'd' al centroide más cercano
        t = 0;
        lim = 2^i;
        for j=1:lim
            % actualizar los centroides a mejores valores medios
            codebk(:, j) = mean(d(:, ind==j), 2);
            % x es un grupo, es decir, vector de puntos vecinos de un centroide
            x = distance(d(:, ind==j), codebk(:, j));
            len = length(x);
            for q = 1:len
                t = t + x(q);
            end
        end
        % distortion condition breaks the loop
        if (((distortion - t)/t) < e)
            break;
        else
            distortion = t;
        end
    end
end
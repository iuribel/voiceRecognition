function d = distance(x, y)
% Distancias euclidianas por pares entre columnas de dos matrices
% Input:
%       x, y:   Dos matrices cuyas columnas corresponden a un vector de
%       datos
% Output:
%       d:     Conjunto de distancia entre las columnas de las dos
%       matrices.
%
% Note:
%       The Euclidean distance D between two vectors X and Y is:
%       D = sum((x-y).^2).^0.5

[M, N] = size(x);
[M2, P] = size(y); 

if (M ~= M2)
    error('Matrix dimensions do not match.')
end

d = zeros(N, P);

if (N < P)
    copies = zeros(1,P);
    for n = 1:N
        d(n,:) = sum((x(:, n+copies) - y) .^2, 1);
    end
else
    copies = zeros(1,N);
    for p = 1:P
        d(:,p) = sum((x - y(:, p+copies)) .^2, 1)';
    end
end

d = d.^0.5;
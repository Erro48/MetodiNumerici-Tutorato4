clc
clear all

counter = 1;
min = 4;
max = 40;


errLU = zeros((max+2)/6, 1);
errQR = zeros((max+2)/6, 1);

for n = min:6:max
    
    A = zeros(n, n);
    x = ones(n, 1);
    for i = 1:n
        for k = i+1-n:i
            if k > 0
                A(i, n+k-i) = 2^k;
            else
                A(i, n+k-i) = 2^(1/(2-k));
            end
        end
    end
    
    b = A * x;
    
    % Fattorizzazione LU
    [L, U, P, flag] = LUparziale(A);
    [xLU, flag] = LUsolve(L, U, P, b);
    
    errLU(counter) = norm(xLU - x) / norm(x);
    
    % Fattorizzazione QR
    xQR = metodoQR(A, b);
    
    errQR(counter) = norm(xQR - x) / norm(x);
    
    counter = counter + 1;
end

figure
semilogy(min:6:max, errLU, 'r-', min:6:max, errQR, 'g-')
legend('Errore LU', 'Errore QR', 'Location', 'northwest')
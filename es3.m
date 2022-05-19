clc
clear all

n = 100;
min = 1;
max = 20;

v = rand(n, 1);
v = v/norm(v);
Z = eye(n) - 2 * v * v';

errPivot = zeros(1, 20);
errNoPivot = zeros(1, 20);
indCond = zeros(1, max);

for k = min:max
    D = eye(n);
    D(n, n) = 10^k;
    A = Z * D;
    
    indCond(k) = cond(A);
    
    x = ones(n, 1);
    b = A * x;
    
    % Con pivoting
    [L, U, P, flag] = LUparziale(A);
    [xPivot, flag] = LUsolve(L, U, P, b);
    errPivot(k) = norm(x - xPivot) /  norm(x);
    
    % Senza pivoting
    [L, U, flag] = LUnopivot(A);
    [xNoPivot, flag] = LUsolve(L, U, eye(n), b);
    errNoPivot(k) = norm(x - xNoPivot) /  norm(x);
    
    
end

figure
semilogy(min:max, errPivot, 'r-', min:max, errNoPivot, 'g-')
legend('Con Pivot', 'Senza Pivot', 'Location', 'northwest')


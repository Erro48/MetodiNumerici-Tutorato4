clc
clear all

A = [3 5 7; 2 3 4; 5 9 11];
% A = [1 2 3 4; 2 -4 6 8; -1 -2 -3 -1; 5 7 0 1];
n = length(A);

B = eye(n);
XPivot = zeros(n);
XNoPivot = zeros(n);

[LPivot, UPivot, PPivot, flag] = LUparziale(A);

for k = 1:n
    [x, flag] = LUsolve(LPivot, UPivot, PPivot, B(:,k));
    XPivot(:, k) = x;
end


[LNoPivot, UNoPivot, flag] = LUnopivot(A);

for k = 1:n
    [x, flag] = LUsolve(LNoPivot, UNoPivot, eye(n), B(:,k));
    XNoPivot(:, k) = x;
end

XPivot
XNoPivot

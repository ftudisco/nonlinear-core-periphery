function B = ranks(A)
% RANKS : Replace numbers by their ranks.
%
% B = ranks(A) 
% returns a matrix the same shape as A, whose elements are
% in the same relative order, but are integers from 1:k,
% where k is the number of different values in A.
%
B = A;
[S,p] = sort(B(:));
D = spones(diff([-inf; S]));
C = cumsum(D);
B(p) = C;

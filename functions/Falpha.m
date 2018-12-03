function nabla2 = Falpha(A,x,a)
x = x(:);

    
[i,j,~] = find(A); [m,n] = size(A); aa = 1/a - 1;
z = abs(x).^a; 
Z = sparse(i,j, (z(i)+z(j)).^aa, m,n); 
nabla2 = 2 * (abs(x).^(a-1)) .* sign(x) .* sum(A.*Z,2);


end
    
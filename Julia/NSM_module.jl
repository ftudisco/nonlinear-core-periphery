module NSM_module

export NSM, ranks




function F(A,x,a)
    i,j = findnz(A);
    m,n = size(A);
    aa = 1/a - 1;
    z = abs.(x).^a;
    Z = sparse(i,j, (z[i]+z[j]).^aa, m,n);
    nabla = 2 .* (abs.(x).^(a-1)) .* sign.(x) .* sum(A.*Z,2);
    return nabla
end


function  NSM(A,a,p; tol = 1e-8, x0 = "ones", verbose = true, maxiter = 200)
## Compute the x with nonnegative entries that maximizes
## f(x) = sum_{ij} A(i,j) mu_a(x(i),x(j))

    n  = size(A,1);

    if x0 == "ones"
        x0 = ones(n,1);
    end

    if verbose
        println("Nonlinear Power Method:");
        println("-------------------------------");
        println("alpha:\t\t$a\np:\t\t\t$p\ntol:\t\t$tol");
    end

    pp = p/(p-1);
    x_array = x0./vecnorm(x0,pp); er_array = [];
    tic();
    for k = 1 : maxiter
        y = F(A,x0,a);
        y = y./vecnorm(y,pp);
        x = y.^(pp/p);
        x_array = [x_array x];
        er_array = [er_array; vecnorm(x-x0)];
        if er_array[end] < tol || isnan(er_array[end])
            time = toq();
            if verbose println("Num iter:\t$k"); end
            if verbose println("Exec time:\t$time sec"); end
            break;
        else
            x0 = copy(x);
        end
    end

    return x_array[:,end], x_array, er_array
end

function ranks(A)
# % RANKS : Replace numbers by their ranks.
# %
# % B = ranks(A)
# % returns a matrix the same shape as A, whose elements are
# % in the same relative order, but are integers from 1:k,
# % where k is the number of different values in A.
# %
# % John Gilbert, Xerox PARC, August 1994.
# % Copyright (c) 1990-1996 by Xerox Corporation.  All rights reserved.
# % HELP COPYRIGHT for complete copyright and licensing notice.
    B = copy(A);
    p = sortperm(B[:]);
    D = ones(diff([-Inf; B[p]]));
    C = cumsum(D);
    B[p] = C;
    return B
end




end

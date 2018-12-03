function [x, x_array, er_array] = NSM(A,a,p,varargin)
% % % Compute the x with nonnegative entries that maximizes
% % % f(x) = sum_{ij} a(i,j) mu_a(x(i),x(j))
    
    n  = length(A);
       
    par = inputParser;
    par.addParameter('tol', 1e-8);
    par.addParameter('x0',ones(n,1));
    par.addParameter('verbose', true);
    par.addParameter('maxiter',200);
    par.parse(varargin{:});
    x0 = par.Results.x0;
    tol = par.Results.tol;
    verbose = par.Results.verbose;
    maxiter = par.Results.maxiter;
    
    if verbose
        fprintf('\n# Nonlinear Power Method:');
        fprintf('\n-------------------------------');
        fprintf('\nalpha:\t\t%d\np:\t\t%d\ntol:\t\t%d',a,p,tol);
    end
    
    pp = p/(p-1);
    x_array = x0./norm(x0,pp); er_array = [];
    tic;
    for k = 1 : maxiter
        y = Falpha(A,x0,a); y = y(:);
        y = y./norm(y,pp);
        x = y.^(pp/p);
        x_array = [x_array x];
        er_array = [er_array; norm(x-x0)];
        if er_array(end) < tol || isnan(er_array(end))
            time = toc;
            if verbose, fprintf('\nnum iter:\t%d', k); end
            if verbose, fprintf('\nexec time:\t%3.5fs', time); end
            break;     
        else
            x0 = x;
        end
    end        
    
    if verbose
        fprintf('\n\n');
    end

% 
% function z = phi(x,y,a)
%     z = (x.^a + y.^a).^(1/a);
% 
% 
% 
% function nabla = F(A,x,a)
%     nabla = zeros(1,length(x));
%     idx = find(x);
%     [row,col,~] = find(A);
%     for s = 1:length(idx)
%         i = idx(s);
%         idx2 = col(row==i);
%         for t = 1:length(idx2)
%             j = idx2(t);
%             nabla(i) = nabla(i) + 2.*A(i,j).*(x(i)./phi(x(i),x(j),a)).^(a-1);
%         end
%     end


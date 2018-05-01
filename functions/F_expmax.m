function A = F_expmax(n,varargin)
    % Create a matrix with logistic core-periphery structure.
    
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % INPUT:
    % n             :   size of the matrix
    % (optional)
    % alpha         :   exponent in the kernel function (x^a + y^a)^{1/a} 
    %                   default = 10
    % slope & shift :   parameters in the sigmoid e^{-slope(x-shift)}
    %                   default = 10 & 1/2
    % adj           :   boolean. if true sparsifies the matrix and sets
    %                   nonzero entries to 1
    %                   default = false
    % sparsity      :   sparsity of the adj matrix (works if adj = true)
    %                   default = .5
    % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % OUTPUT: 
    % A             :   Adjacency matrix of the model
    
    
    % Check inputs
    par = inputParser;
    par.addParameter('alpha', 10);
    par.addParameter('slope', 10);
    par.addParameter('shift', 1/2);
    par.addParameter('adj', false);
    par.addParameter('sparsity', .5);
    par.parse(varargin{:});
    % Set up input variables
    a = par.Results.alpha;
    slope = par.Results.slope;
    shift = par.Results.shift;
    transform_into_adjacency = par.Results.adj;
    edge_sparsity = par.Results.sparsity;
    
    
    
    
    
    A = zeros(n,n);
    
    sigmoid = @(x,s,t) 1./(1+exp(-s*(x-t)));
    
    f = @(i,j,p)  ((1-i/n)^p+(1-j/n)^p)^(1/p);
    
    for i = 1 : n
        for j = 1: n
            A(i,j)=sigmoid(f(i,j,a),slope,shift); % + 0*s(10*f(i,j,-pp/4));
        end
    end
    
    if transform_into_adjacency
       temp = sprand(n,n,edge_sparsity); temp = triu(abs(temp)); temp = (temp+temp');
       A(temp==0)=0; A = sparse(A-temp>0); A = A/5; A = A*5; 
    end
        
end
    
    %A = linearInterpol(A,0,2);
    %A = A.^3;
    %A = linearInterpol(A,0,1);
    
    
    
    
    
    
% interpolates (linearly) the values of x so to span the range [a,b] 
%function xx = linearInterpol(x,a,b)
%   alpha = (b-a)./(max(max(x))-min(min(x))); beta = alpha*min(min(x))-a; xx = alpha.*x-beta;

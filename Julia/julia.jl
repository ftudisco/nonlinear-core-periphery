push!(LOAD_PATH, pwd());
using PyPlot, MAT, NSM_module


### Load Internet2006 dataset
vars = matread("../Datasets/internet2006-autonomous_systems(as-22july06).mat");
A = vars["Problem"]["A"];

### Print dataset info
NAME = "Internet";
println("#### $NAME ####");
println("Nodes:\t", size(A,1));
println("Edges:\t",nnz(A)/2);


### NONLINEAR CP #################

### Choose method parameters
alpha = 10;
pnorm = 2*alpha;
tolerance = 1e-8;
starting_point =  ones(size(A,1),1);
max_iterations = 200;
verbose = true;

### Run the Nonlinear Spectral Method (NSM)
x, x_array, er_array = NSM(A,alpha,pnorm,
                             x0         = starting_point,
                             tol        = tolerance,
                             maxiter    = max_iterations,
                             verbose    = verbose);

### Plot the reordered adjacency matrix
ind = sortperm(x,rev=true);
figure(); spy(A[ind,ind], markersize=2); title("NSM");

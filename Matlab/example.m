clear all
close all
clc
addpath('functions');

%%% Load Internet2006 dataset
dataset_name =  'internet2006-autonomous_systems(as-22july06)';
datafilename = sprintf('../Datasets/%s',dataset_name);
load(datafilename);

%%% Reduce to largest connected component of the network
%%% This is not really required by the NSM but it helps comparing the
%%% results with other approaches
A = Problem.A; 
G = graph(A);
ind = max_connected_component(G);
A = A(ind, ind);

%%% Print dataset info
NAME = 'Internet';
fprintf('#### %s ####', NAME);
fprintf('\nNodes:\t%d',length(A));
fprintf('\nEdges:\t%d',nnz(A)/2);
fprintf('\n\n');


%%% NONLINEAR CP %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Choose method parameters 
alpha = 10; 
pnorm = 2*alpha; 
tolerance = 1e-8;
starting_point =  ones(length(A),1);
max_iterations = 200;
verbose = true;

%%% Run the Nonlinear Spectral Method (NSM)
[x, x_array, er_array] = NSM(A,alpha,pnorm,             ...
                             'x0',starting_point,       ...
                             'tol',tolerance,           ...
                             'maxiter',max_iterations,  ...
                             'verbose',verbose);

%%% Plot the reordered adjacency matrix
[x,ind] = sort(x,'descend');
figure,spy(A(ind,ind));title('NSM');








function [ind] = max_connected_component(G)
    bins = conncomp(G);
    labels = unique(bins);
    maxval = 0; maxindex = 1;
    for i = 1 : length(labels)
        val = sum(bins==labels(i));
        if val > maxval, maxval = val; maxindex = i; end
    end
    ind = (bins==maxindex);
end
      

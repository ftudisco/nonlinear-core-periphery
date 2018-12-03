# Nonlinear Spectral Method for core-periphery detection

**This repository hosts the code and some example data for the following paper:**

A nonlinear spectral method for core-periphery detection in networks

[Detecting Core-Periphery Structure in Spatial Networks](http://personal.strath.ac.uk/f.tudisco/publication/nonlinear_core-periphery/)

by [Francesco Tudisco](http://personal.strath.ac.uk/f.tudisco/) and [Desmond J. Higham](http://personal.strath.ac.uk/d.j.higham/)

[arXiv:1808.06544](https://arxiv.org/abs/1804.09820), 2018.


In our paper we derive and analyse a new iterative algorithm for detecting network core-periphery structure. Using techniques from nonlinear Perron-Frobenius theory, we prove global convergence to the unique solution of a relaxed version of a natural discrete optimization problem. On sparse networks, the cost of each iteration scales linearly with the number of nodes, making the algorithm feasible for large-scale problems. We give an alternative interpretation of the algorithm from the perspective of maximum likelihood reordering of a new logistic core-periphery
random graph model. This viewpoint also gives a new basis for quantitatively judging a core-periphery detection algorithm. We illustrate the algorithm on a range of synthetic and real networks, and show that it offers advantages over the current state-of-the-art.

In this repository you can find Julia and Matlab code that implement our Nonlinear Spectral Method (NSM) and some of the datasets that we used in the paper. You can find details and references for each of the dataset in our manuscript.

If you use our method for your research, please cite our work as follows
```
@article{tudisco2018core,
  title = {A nonlinear spectral method for core-periphery detection in networks},
  author = {Tudisco, Francesco and Higham, Desmond J.},
  journal = {arXiv:1804.09820}
  year = {2018}
}
```

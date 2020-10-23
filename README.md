# GAP - Generalized Adaptive Polynomial Window Function

João F. Justo and Wesley Beccaro 
IEEE Access 8, 187584 (2020).  DOI: 10.1109/ACCESS.2020.3030903
IEEExplore: https://ieeexplore.ieee.org/document/9223641


Discrete Fourier Transform (DFT) is a powerful tool to perform Fourier analysis in discrete data, with several applications, such as astronomy, chemistry, acoustics, geophysics, and digital processing.

The use of window functions affects the analysis in the frequency domain, sometimes introducing unwanted artifacts, such as signal leakage, scalloping loss, and intensity of sidelobes.

We propose a generalized functional form to describe windows combined with an optimization method to improve their spectral properties.

We present a generalized window function as a non-linear polynomial expansion in which all the current windows could be mimic with the appropriate expansion coefficients. 

This functional form is very flexible, which allows searching for sets of expansion coefficients that provide superior properties, considering a reference figure of merit associated to the property to be improved. 

This procedure paves the way for optimization and adaptive methods, such as machine learning and genetic algorithms, to adapt window functions to certain data sets and specific applications. 

This method to obtain windows is quite general, allowing the use of several optimization methods, such as global optimization (genetic algorithms and simulated annealing) or local optimization (Newton and gradient-based methods) techniques, or even machine learning.

Any new window obtained by optimization procedures represents an improvement of the properties in the frequency domain, when compared to that initial window function guess.

This method allows to improve several spectral properties simultaneously.

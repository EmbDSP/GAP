%   GAP  Generalized Adaptive Polynomial Window Function
%
%   M        (input)   order 
%   w        (output)  returns an M-point GAP window.
%   
%   Authors: J.F. Justo, W. Beccaro
%   Data:   2020
%   IEEE Access 8, 187584 (2020).  DOI: 10.1109/ACCESS.2020.3030903
%   J. F. Justo and W. Beccaro, "Generalized Adaptive Polynomial Window Function," 
%   in IEEE Access, vol. 8, pp. 187584-187589, 2020, doi: 10.1109/ACCESS.2020.3030903.
%   
%   For more information: wesley@lme.usp.br
%
%   Additional information can be found in GitHub: https://github.com/EmbDSP/GAP/
%   https://www.mathworks.com/matlabcentral/fileexchange/81658-gap-generalized-adaptive-polynomial-window-function 


clear all; clc; warning ('off','all');

%% Initial conditions

% Create a 64-point window. 
M = 64;
N = (0:1/(M-1):1)';

%% GAP Algorithm mimic window functions

% Computes a window function using traditional algorithm, e.g. nuttallwin()
win_function_matlab = nuttallwin(M);
% win_function_matlab = hann(M); % To mimic Hann window
% win_function_matlab = tukeywin(M); % To mimic Tukey window
% win_function_matlab = hamming(M); % % To mimic Hamming window

% Display the result using wvtool
wvtool(win_function_matlab);  

% Fit Polynomial curve
[xData, yData] = prepareCurveData(N, win_function_matlab);

ft = fittype( '1 + a2*(x)^2 + a4*(x)^4 + a6*(x)^6 + a8*(x)^8 + a10*(x)^10 + a12*(x)^12 + a14*(x)^14 + a16*(x)^16 + a18*(x)^18  + a20*(x)^20', ...
'independent', 'x', 'dependent', 'y' );
opts = fitoptions( 'Normalize', 'on' );

% Fit GAP model to data.
[fitresult, gof] = fit(xData, yData, ft, opts);

GAP_win_function = fitresult(N);
% Display the result using wvtool to demonstrate how GAP can mimic window functions.
wvtool(GAP_win_function);  

%% Optimization traditional window functions using GAP algorithm  

% Initial values of polynomial window previously calculated 
GAP_coef = [fitresult.a2,fitresult.a4,fitresult.a6,fitresult.a8,fitresult.a10,...
    fitresult.a12,fitresult.a14,fitresult.a16,fitresult.a18, fitresult.a20];

% Optimization using derivative-free method
options = optimset('PlotFcns',{@optimplotfval});
GAP_optimized_coef = fminsearch(@sidelobe_attenuation, [GAP_coef, M], options);

% Display the result using wvtool to demonstrate GAP optimized window functions.
GAP_optimized_win_function = gapwin('user', M, GAP_optimized_coef);
wvtool(GAP_optimized_win_function);  


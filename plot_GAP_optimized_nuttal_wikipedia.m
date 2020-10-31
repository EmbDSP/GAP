% Main code (plotWindow function)extracted from: 
% Bob K (original version), Olli Niemitalo, BobQQ
% https://commons.wikimedia.org/wiki/File:Fourier_transform_%E2%80%93_Rectangular.svg
% https://commons.wikimedia.org/wiki/File:Window_function_and_frequency_response_-_Rectangular.svg

% Octave

pkg load signal

graphics_toolkit gnuplot

% Characteristics common to both plots

 set(0, "DefaultAxesFontName", "Microsoft Sans Serif")
 set(0, "DefaultTextFontName", "Microsoft Sans Serif") 
 set(0, "DefaultAxesTitleFontWeight", "bold")
 set(0, "DefaultAxesFontWeight",      "bold")
 set(0, "DefaultAxesFontSize", 20)
 set(0, "DefaultAxesLineWidth", 3)
 set(0, "DefaultAxesBox", "on")
 set(0, "DefaultAxesGridLineStyle", "-")
 set(0, "DefaultAxesGridColor", [0 0 0])  % black
 set(0, "DefaultAxesGridAlpha", 0.25)     % opaqueness of grid
 set(0, "DefaultAxesLayer", "bottom")     % grid not visible where overlapped by graph

%======================================================================== 
function plotWindow (w, wname, wfilename = "", wspecifier = "", wfilespecifier = "")

 close     % If there is a previous screen image, remove it.
 M = 32;   % Fourier transform size as multiple of window length
 Q = 512;  % Number of samples in time domain plot
 P = 40;   % Maximum bin index drawn
 dr = 130; % (dynamic range) Maximum attenuation (dB) drawn in frequency domain plot

 L = length(w);
 B = L*sum(w.^2)/sum(w)^2;              % noise bandwidth (bins)
 
 n = [0 : 1/Q : 1];
 w2 = interp1 ([0 : 1/(L-1) : 1], w, n);

 if (M/L < Q)
   Q = M/L;
 endif

 figure("position", [1 1 1200 600])  % width = 2×height, because there are 2 plots

% Plot the window function

 subplot(1,2,1)
 area(n,w2,"FaceColor", [0 0.4 0.6], "edgecolor", [0 0 0], "linewidth", 1)
 
 g_x = [0 : 1/8 : 1];    % user defined grid X [start:spaces:end]
 g_y = [0 : 0.1 : 1];
 set(gca,"XTick", g_x)
 set(gca,"YTick", g_y)

% Special y-scale if filename includes "flat top"

 if(index(wname, "flat top"))
   ylimits = [-0.1 1.05];
 else
   ylimits = [0 1.05];
 endif
 ylim(ylimits)
 ylabel("amplitude","FontSize",28)  
 set(gca,"XTickLabel",[" 0"; " "; " "; " "; " "; " "; " "; " "; "  N"])
 grid("on")
 xlabel("samples","FontSize",28)

%    {

% This is a disabled work-around for an Octave bug, if you don't want to run the perl post-processor.

 %text(-.18, .4,"amplitude","rotation",90, "Fontsize", 28);
% text(1.15, .4,"decibels", "rotation",90, "Fontsize", 28);

 %   }

%Construct a title from input arguments. %The default interpreter is "tex", which can render subscripts and the following Greek character codes: % \alpha \beta \gamma \delta \epsilon \zeta \eta \theta \vartheta \iota \kappa \lambda \mu \nu \xi \o % \pi \varpi \rho \sigma \varsigma \tau \upsilon \phi \chi \psi \omega. %

 if (strcmp (wspecifier, ""))
   title(cstrcat(wname," window"), "FontSize", 28)    
 elseif (length(strfind (wspecifier, "&#")) == 0 )
   title(cstrcat(wname,' window (', wspecifier, ')'), "FontSize", 28)
 else

% The specifiers '\sigma_t' and '\mu' work correctly in the output file, but not in subsequent thumbnails. % So UNICODE substitutes are used. The tex interpreter would remove the & character, needed by the Perl script.

   title(cstrcat(wname,' window (', wspecifier, ')'), "interpreter", "none", "FontSize", 28)
 endif
 ax1 = gca;

% Compute spectal leakage distribution

 H = abs(fft([w zeros(1,(M-1)*L)]));
 H = fftshift(H);
 H = H/max(H);
 H = 20*log10(H);
 H = max(-dr,H);
 n = ([1:M*L]-1-M*L/2)/M;
 k2 = [-P : 1/M : P];
 H2 = interp1 (n, H, k2);

% Plot the leakage distribution

 subplot(1,2,2)
 h = stem(k2,H2,"-");
 set(h,"BaseValue",-dr)
 xlim([-P P])
 ylim([-dr 6])
 set(gca,"YTick", [0 : -10 : -dr])
 set(findobj("Type","line"), "Marker", "none", "Color", [0.8710 0.49 0])
 grid("on")
 set(findobj("Type","gridline"), "Color", [.871 .49 0])
 ylabel("decibels","FontSize",28)
 xlabel("bins","FontSize",28)
 title("Fourier transform","FontSize",28)
 text(-5, -126, ['B = ' num2str(B,'%5.3f')],"FontWeight","bold","FontSize",14)
 ax2 = gca;

% Configure the plots so that they look right after the Perl post-processor. % These are empirical values (trial & error). % Note: Would move labels and title closer to axes, if I could figure out how to do it.

 x1 = .08;         %   left margin for y-axis labels
 x2 = .02;         %  right margin
 y1 = .14;         % bottom margin for x-axis labels
 y2 = .14;         %    top margin for title
 ws = .13;         % whitespace between plots
 width  = (1-x1-x2-ws)/2;
 height = 1-y1-y2;
 set(ax1,"Position", [x1         y1 width height])      % [left bottom width height]
 set(ax2,"Position", [1-width-x2 y1 width height])
 

%Construct a filename from input arguments.

 if (strcmp (wfilename, ""))
   wfilename = wname;
 endif
 if (strcmp (wfilespecifier, ""))
   wfilespecifier = wspecifier;
 endif
 if (strcmp (wfilespecifier, ""))
   savetoname = cstrcat("Window function and frequency response - ", wfilename, ".svg");
 else
   savetoname = cstrcat("Window function and frequency response - ", wfilename, " (", wfilespecifier, ").svg");
 endif
 print(savetoname, "-dsvg", "-S1200,600")

endfunction

M=2^17; % Window length, B is equal for Triangular and Bartlett from 2^17

a2 = -1.9501232504232442; a4 = 1.7516390954528638; a6 = -0.9651321809782892; 
a8 = 0.3629219021312954; a10 = -0.0943163918335154; a12 = 0.0140434805881681; 
a14 = 0.0006383045745587; a16 = -0.0009075461792061; a18 = 0.0002000671118688; 
a20 = -0.0000161042445001;
 
N = (0:1/(M-1):1)';
x = (N-mean(N))./std(N);
w_gap_nuttall = 1 + a2*(x).^2 + a4*(x).^4 + a6*(x).^6 + a8*(x).^8 + a10*(x).^10 ...
+ a12*(x).^12 + a14*(x).^14 + a16*(x).^16 + a18*(x).^18  + a20*(x).^20;

w_gap_nuttall = w_gap_nuttall';
plotWindow(w_gap_nuttall, "Optimized GAP Nuttall")
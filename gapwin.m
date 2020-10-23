function w = gapwin(windowtype, M, varargin)
%   GAP  Generalized Adaptive Polynomial window Function
%
%   Calculates the window function with GAP algorithm
%   windowtype  - chosen window polynomial function:
%                 'tukey': Tukey window
%                 'bohman':Bohman window
%                 'gauss': Gaussian window
%                 'nuttall': Nuttall window
%                 'blackmanharris': Blackman-Harris window
%                 'hamming': Hamming window
%                 'hann': Hann window
%                 'blackman': Blackman window
%                 'flattop'  : Flattop window
%                 'kaiser'  : Kaiser window with beta = 0.5
%                 'triangular': Triangular window
%                 'chebyshev'  : Chebyshev window with 100 dB sidelobe attenuation
%                 'dolphchebyshev': Dolph-Chebyshev window with 60 dB sidelobe attenuation
%                 'user': User-defined window, coefficients a1 to a10 
%
%   M        (input)   order of symmetric (aperiodic) window
%   w        (output)  returns an M-point symmetric GAP window.
%   
%   Authors: J.F. Justo, W. Beccaro
%   Data:   2020
%   IEEE Access 8, 187584 (2020).  DOI: 10.1109/ACCESS.2020.3030903
%   J. F. Justo and W. Beccaro, "Generalized Adaptive Polynomial Window Function," in IEEE Access, vol. 8, pp. 187584-187589, 2020, doi: 10.1109/ACCESS.2020.3030903.


if nargin < 2
    error('Too few input arguments.')
end

warning('off','all');  % Turn off warning in polyfit

switch windowtype
   case 'tukey'   % Cosine fraction equal to 0.5
    a1 = -0.0103497038211383; a2 = 0.3959586687207592; a3 = -3.2945315992929736; 
    a4 = 10.9266194171836390; a5 = -17.7404182084630830; 
    a6 = 15.6301946042598950; a7 = -7.9870271991602984; a8 = 2.3794414907511503; 
    a9 = -0.3845839556124955; a10 = 0.0261098161259766;
   case 'bohman'   % Bohman Window
    a1 = -1.5605823828760355; a2 = 1.7148495655943015; a3 = -2.5618825249800583; 
    a4 = 3.6271291873571676; a5 = -3.5950261254540017; 
    a6 = 2.3505926003045694; a7 = -0.9933942437949487; a8 = 0.2606623922569933; 
    a9 = -0.0385661195398123; a10 = 0.0024568662420631;
   case 'gauss'   % Width factor equal to 2.5
    a1 = -1.0467106610988055; a2 = 0.5361462724137202; a3 = -0.1387143360480971; 
    a4 = -0.0584915293187281; a5 = 0.1162559013242074; 
    a6 = -0.0877208431082394; a7 = 0.0387600530521579; a8 = -0.0102232327498813; 
    a9 = 0.0014864383817216; a10 = -0.0000916508663761;
   case 'nuttall'
    a1 = -1.8613291764674220; a2 = 1.5955186857618950; a3 = -0.8406138435144469; 
    a4 = 0.3060221557499289; a5 = -0.0816143503577229; 
    a6 = 0.0163658050094003; a7 = -0.0024762422139338; a8 = 0.0002763640540836; 
    a9 = -0.0000208137088649; a10 = 0.0000007971348851;
   case 'blackmanharris'
    a1 = -1.9071140664126667; a2 = 1.6688485572798146; a3 = -0.8949809748378396; 
    a4 = 0.3314095987979339; a5 = -0.0905472023090353; 
    a6 = 0.0191638805426608; a7 = -0.0032874219959794; a8 = 0.0004607672130969; 
    a9 = -0.0000468683311108; a10 = 0.0000024315535428;
   case 'hamming'   
    a1 = -0.7568070383868444; a2 = 0.2075050626134147; a3 = -0.0226856435429735; 
    a4 = 0.0011638432390271; a5 = 0.0001756748203687; 
    a6 = -0.0001739434252335; a7 = 0.0000839988209135; a8 = -0.0000242454753949; 
    a9 = 0.0000038606906746; a10 = -0.0000002606048812;
   case 'hann' 
    a1 = -0.8236640350672578; a2 = 0.2396934226088473; a3 = -0.0910329438155984; 
    a4 = 0.1546641760773942; a5 = -0.2008340012917025; 
    a6 = 0.1591065890832292; a7 = -0.0777111572266440; a8 = 0.0228723527427099; 
    a9 = -0.0037192072905112; a10 = 0.0002565996927828;
   case 'blackman' 
    a1 = -1.3499977224496962; a2 = 0.8164359980905906; a3 = -0.3451854568136762; 
    a4 = 0.2234156466000141; a5 = -0.2292817284031708; 
    a6 = 0.1806093772823897; a7 = -0.0898992834622714; a8 = 0.0269592184647446; 
    a9 = -0.0044557612857286; a10 = 0.0003117737791971;
   case 'flattop'
    a1 = -3.9305156873118765; a2 = 6.0451104178491635; a3 = -5.3177562066489958; 
    a4 = 3.1144383119449035; a5 = -1.3100052464220604; 
    a6 = 0.4090358342129138; a7 = -0.0944033497312810; a8 = 0.0153559618717567; 
    a9 = -0.0015700027700864; a10 = 0.0000753819065601;
   case 'kaiser' % beta = 2.5
    a1 = -0.3189794414953419; a2 = 0.0336993294780022; a3 = -0.0016224639429582; 
    a4 = -0.0001697167227210; a5 = 0.0002229717468906; 
    a6 = -0.0001265960227273; a7 = 0.0000382544342193; a8 = -0.0000046936529421; 
    a9 = -0.0000002431170153; a10 = 0.0000000819885591;
   case 'user' 
    if ( length(varargin) == 1 )
        coef = varargin{:};
    end
    a1 = coef(1); a2 = coef(2); a3 = coef(3); a4 = coef(4); a5 = coef(5);
    a6 = coef(6); a7 = coef(7); a8 = coef(8); a9 = coef(9); a10 = coef(10);
end

N = (0:1/(M-1):1)';
x = (N-mean(N))./std(N);
a0 = 1;
w = a0 + a1*(x).^2 + a2*(x).^4 + a3*(x).^6 + a4*(x).^8 + a5*(x).^10 + a6*(x).^12 + a7*(x).^14 + a8*(x).^16 + a9*(x).^18  + a10*(x).^20;
end
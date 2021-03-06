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
%                 'opt_gap_hann': Optimized Hann window using GAP Algorithm
%                 'opt_gap_flattop': Optimized Flat Top window using GAP Algorithm
%                 'opt_gap_tukey': Optimized Tukey window using GAP Algorithm 
%                 'opt_gap_nuttall': Optimized Nuttall using GAP Algorithm 
%                 'user': User-defined window, coefficients a2 to a20 
%
%   M        (input)   M-point window.
%   w        (output)  returns an M-point  GAP window.
%   
%   Authors: J.F. Justo, W. Beccaro
%   Data:   2020
%   IEEE Access 8, 187584 (2020).  DOI: 10.1109/ACCESS.2020.3030903
%   J. F. Justo and W. Beccaro, "Generalized Adaptive Polynomial Window Function," 
%   in IEEE Access, vol. 8, pp. 187584-187589, 2020, doi: 10.1109/ACCESS.2020.3030903.


if nargin < 2
    error('Too few input arguments.')
end

warning('off','all');  % Turn off warning in polyfit

switch windowtype
   case 'tukey'   % Cosine fraction equal to 0.5
    a2 = -0.0103497038211383; a4 = 0.3959586687207592; a6 = -3.2945315992929736; 
    a8 = 10.9266194171836390; a10 = -17.7404182084630830; 
    a12 = 15.6301946042598950; a14 = -7.9870271991602984; a16 = 2.3794414907511503; 
    a18 = -0.3845839556124955; a20 = 0.0261098161259766;
   case 'bohman'   % Bohman Window
    a2 = -1.5605823828760355; a4 = 1.7148495655943015; a6 = -2.5618825249800583; 
    a8 = 3.6271291873571676; a10 = -3.5950261254540017; 
    a12 = 2.3505926003045694; a14 = -0.9933942437949487; a16 = 0.2606623922569933; 
    a18 = -0.0385661195398123; a20 = 0.0024568662420631;
   case 'gauss'   % Width factor equal to 2.5
    a2 = -1.0467106610988055; a4 = 0.5361462724137202; a6 = -0.1387143360480971; 
    a8 = -0.0584915293187281; a10 = 0.1162559013242074; 
    a12 = -0.0877208431082394; a14 = 0.0387600530521579; a16 = -0.0102232327498813; 
    a18 = 0.0014864383817216; a20 = -0.0000916508663761;
   case 'nuttall'
    a2 = -1.8613291764674220; a4 = 1.5955186857618950; a6 = -0.8406138435144469; 
    a8 = 0.3060221557499289; a10 = -0.0816143503577229; 
    a12 = 0.0163658050094003; a14 = -0.0024762422139338; a16 = 0.0002763640540836; 
    a18 = -0.0000208137088649; a20 = 0.0000007971348851;
   case 'blackmanharris'
    a2 = -1.9071140664126667; a4 = 1.6688485572798146; a6 = -0.8949809748378396; 
    a8 = 0.3314095987979339; a10 = -0.0905472023090353; 
    a12 = 0.0191638805426608; a14 = -0.0032874219959794; a16 = 0.0004607672130969; 
    a18 = -0.0000468683311108; a20 = 0.0000024315535428;
   case 'hamming'   
    a2 = -0.7568070383868444; a4 = 0.2075050626134147; a6 = -0.0226856435429735; 
    a8 = 0.0011638432390271; a10 = 0.0001756748203687; 
    a12 = -0.0001739434252335; a14 = 0.0000839988209135; a16 = -0.0000242454753949; 
    a18 = 0.0000038606906746; a20 = -0.0000002606048812;
   case 'hann' 
    a2 = -0.8236640350672578; a4 = 0.2396934226088473; a6 = -0.0910329438155984; 
    a8 = 0.1546641760773942; a10 = -0.2008340012917025; 
    a12 = 0.1591065890832292; a14 = -0.0777111572266440; a16 = 0.0228723527427099; 
    a18 = -0.0037192072905112; a20 = 0.0002565996927828;
   case 'blackman' 
    a2 = -1.3499977224496962; a4 = 0.8164359980905906; a6 = -0.3451854568136762; 
    a8 = 0.2234156466000141; a10 = -0.2292817284031708; 
    a12 = 0.1806093772823897; a14 = -0.0898992834622714; a16 = 0.0269592184647446; 
    a18 = -0.0044557612857286; a20 = 0.0003117737791971;
   case 'flattop'
    a2 = -3.9305156873118765; a4 = 6.0451104178491635; a6 = -5.3177562066489958; 
    a8 = 3.1144383119449035; a10 = -1.3100052464220604; 
    a12 = 0.4090358342129138; a14 = -0.0944033497312810; a16 = 0.0153559618717567; 
    a18 = -0.0015700027700864; a20 = 0.0000753819065601;
   case 'kaiser' % beta = 2.5
    a2 = -0.3189794414953419; a4 = 0.0336993294780022; a6 = -0.0016224639429582; 
    a8 = -0.0001697167227210; a10 = 0.0002229717468906; 
    a12 = -0.0001265960227273; a14 = 0.0000382544342193; a16 = -0.0000046936529421; 
    a18 = -0.0000002431170153; a20 = 0.0000000819885591;
    case 'opt_gap_flattop' 
    a2 = -4.1209325608590230; a4 = 6.6399343002408848; a6 = -6.1201388282223714; 
    a8 = 3.7564788283482500; a10 = -1.6562551742477343; 
    a12 = 0.5422907505270711; a14 = -0.1313358672391922; a16 = 0.0224356650617897; 
    a18 = -0.0024099466150896; a20 = 0.0001215684885852;
    case 'opt_gap_hann' 
    a2 = -0.8633709192318678; a4 = 0.2653709029689753; a6 = -0.1153016793571805; 
    a8 = 0.2116532335332943; a10 = -0.2872184753966414; 
    a12 = 0.2374771961834025; a14 = -0.1207452486142054; a16 = 0.0369718127902219; 
    a18 = -0.0062356588610486; a20 = 0.0004470315321743;
    case 'opt_gap_nuttall' 
    a2 = -1.9501232504232442; a4 = 1.7516390954528638; a6 = -0.9651321809782892; 
    a8 = 0.3629219021312954; a10 = -0.0943163918335154; 
    a12 = 0.0140434805881681; a14 = 0.0006383045745587; a16 = -0.0009075461792061; 
    a18 = 0.0002000671118688; a20 = -0.0000161042445001;
    case 'opt_gap_tukey' 
    a2 = -0.0342729483485263; a4 = 0.6073488292493461; a6 = -5.4139206165072489; 
    a8 = 15.2509414561383778; a10 = -24.0795939653486499; 
    a12 = 21.9939520044024128; a14 = -11.7824123554208455; a16 = 3.6751885048648951; 
    a18 = -0.6242323583760374; a20 = 0.0451786553861468;
    case 'user' 
    if ( length(varargin) == 1 )
        coef = varargin{:};
    end
    a2 = coef(1); a4 = coef(2); a6 = coef(3); a8 = coef(4); a10 = coef(5);
    a12 = coef(6); a14 = coef(7); a16 = coef(8); a18 = coef(9); a20 = coef(10);
end

N = (0:1/(M-1):1)';
x = (N-mean(N))./std(N);

a0 = 1;
w = a0 + a2*(x).^2 + a4*(x).^4 + a6*(x).^6 + a8*(x).^8 + a10*(x).^10 + ...
    a12*(x).^12 + a14*(x).^14 + a16*(x).^16 + a18*(x).^18  + a20*(x).^20;
end
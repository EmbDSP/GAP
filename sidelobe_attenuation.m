function optimized_sidelobe = sidelobe_attenuation(v)
    a2 = v(1); a4 = v(2); a6 = v(3); a8 = v(4); a10 = v(5); a12 = v(6);
	a14 = v(7); a16 = v(8); a18 = v(9); a20 = v(10);
    
    M = v(11);
    N = (0:1/(M-1):1)';
    x = (N-mean(N))./std(N);
    
    a0 = 1;
    pol_win = a0 + a2*(x).^2 + a4*(x).^4 + a6*(x).^6 + a8*(x).^8 + a10*(x).^10 ...
        + a12*(x).^12 + a14*(x).^14 + a16*(x).^16 + a18*(x).^18  + a20*(x).^20;

    [H,W] = freqz(pol_win,1,2^12, 2^20);

    % Compute frequency response
    Hdb = 20*log10(abs(H));

    [peak,loc] = find_peaks(Hdb');
    Hside = Hdb(loc(2):end);

    % Sidelobe attenuation: difference between the power (in dB) of the 
    % mainlobe peak and the peak power in the sidelobes.
    optimized_sidelobe = -(Hdb(loc(1))-max(Hside));
end

function [peaks,peak_indices] = find_peaks(row_vector)
    A = [min(row_vector)-1 row_vector min(row_vector)-1];
    j = 1;
    for i=1:length(A)-2
        temp=A(i:i+2);
        if(max(temp) == temp(2))
            peaks(j) = row_vector(i);
            peak_indices(j) = i;
            j = j+1;
        end
    end
end
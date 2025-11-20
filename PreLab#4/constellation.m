function [cons, symbolAverageEnergy] = constellation(M, modulation)

in = (0:M-1)';

switch lower(modulation)
    case 'pam'
        unnormalized_cons = pammod(in, M);
    case 'psk'
        unnormalized_cons = pskmod(in, M, 0); % 0 phase offset
    case 'qam'
        if mod(sqrt(M), 1) ~= 0
            error('M is perfect square for QAM');
        end
        unnormalized_cons = qammod(in, M);
        
    otherwise
        error("Unknown modulation type");
end

E_avg_unnormalized = mean(abs(unnormalized_cons).^2);
norm_factor = sqrt(E_avg_unnormalized);
cons = unnormalized_cons / norm_factor;
symbolAverageEnergy = mean(abs(cons).^2);

end
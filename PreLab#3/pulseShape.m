function [p, t] = pulseShape(pulseName, fs, nSymbolSamples, varargin)
Ts = nSymbolSamples / fs;     
T_samp = 1 / fs;          
switch lower(pulseName)
    case {'rectangular', 'triangular', 'sine'}
        
        
        t = (0:nSymbolSamples) * T_samp;
    
    case {'raised-cosine', 'rootraisedcosine', 'gaussian'}
        
        if isempty(varargin) || numel(varargin) < 2
            error('Beta and spanInSymbol are required for this pulse type.');
        end
        
        spanInSymbol = varargin{2};
        
        
        N_half = (spanInSymbol / 2) * nSymbolSamples;
        t = (-N_half : N_half) * T_samp;
        
    otherwise
        error('Unknown pulseName: %s', pulseName);
end

p0 = zeros(size(t));
switch lower(pulseName)
    case 'rectangular'
        
        
        p0 = (t >= 0 & t < Ts);
        
    case 'triangular'
        
        
        p0 = 1 - 2 * abs(t - Ts/2) / Ts;
        p0 = p0 .* (t >= 0 & t <= Ts); 
    case 'sine'
        
        p0 = sin(pi * t / Ts);
        p0 = p0 .* (t >= 0 & t <= Ts); 
    
    case 'raised-cosine'
        beta = varargin{1};
        
        
        t_eps = t + 1e-12; 
        
        p_sinc = sinc(t_eps / Ts); 
        p_cos = cos(pi * beta * t_eps / Ts);
        p_den = 1 - (2 * beta * t_eps / Ts).^2;
        
        p0 = p_sinc .* p_cos ./ p_den;
        
        
        if beta ~= 0
            t_singularity = Ts / (2 * beta);
            
            indices = (abs(abs(t_eps) - t_singularity) < T_samp/10); 
            
            val_at_singularity = (pi/4) * sinc(1/(2*beta));
            p0(indices) = val_at_singularity;
        end
    case 'rootraisedcosine'
        beta = varargin{1};
        t_rrc = t; 
        
        idx_zero = (abs(t_rrc) < T_samp/10);
        if beta ~= 0
            t_singularity = Ts / (4 * beta);
            idx_sing = (abs(abs(t_rrc) - t_singularity) < T_samp/10);
        else
            idx_sing = false(size(t_rrc));
        end
        
        t_rrc(idx_zero | idx_sing) = 1; 
        
        num_part1 = sin(pi * t_rrc/Ts * (1 - beta));
        num_part2 = (4 * beta * t_rrc / Ts) .* cos(pi * t_rrc/Ts * (1 + beta));
        den = (pi * t_rrc / Ts) .* (1 - (4 * beta * t_rrc / Ts).^2);
        
        p0 = (num_part1 + num_part2) ./ den;
        
        
        
        p0(idx_zero) = (1 - beta + (4*beta/pi));
        
        
        if beta ~= 0
            val_at_singularity = (beta / sqrt(2)) * ...
                ( (1+2/pi)*sin(pi/(4*beta)) + (1-2/pi)*cos(pi/(4*beta)) );
            p0(idx_sing) = val_at_singularity;
        end
        
    case 'gaussian'
        beta = varargin{1}; 
        
        
        
        a = (pi * beta) / (Ts * sqrt(log(2)));
        p0 = exp(-a^2 * t.^2);
end


energy = sum(abs(p0).^2) * T_samp;
if energy == 0
    p = p0; 
else
    
    p = p0 / sqrt(energy);
end
end
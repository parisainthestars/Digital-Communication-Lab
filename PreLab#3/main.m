clear;
clc; 
close all;
fs = 8000;              
nSymbolSamples = 8;     
Ts = nSymbolSamples / fs; 
nfft = 256;             
spanInSymbol = 6;       
beta_rc_rrc = [0.2, 0.5, 0.9]; 
beta_gauss = [0.1, 0.3, 0.5]; 

[p_rect, t_rect] = pulseShape('rectangular', fs, nSymbolSamples);
plot_pulse(t_rect, p_rect, 'Rectangular Pulse', Ts); 
plot_freq(p_rect, fs, nfft, 'Rectangular', [], Ts); 

[p_tri, t_tri] = pulseShape('triangular', fs, nSymbolSamples);
plot_pulse(t_tri, p_tri, 'Triangular Pulse', Ts); 
plot_freq(p_tri, fs, nfft, 'Triangular', [], Ts); 

[p_sine, t_sine] = pulseShape('sine', fs, nSymbolSamples);
plot_pulse(t_sine, p_sine, 'Half-Sine Pulse', Ts); 
plot_freq(p_sine, fs, nfft, 'Half-Sine', [], Ts); 

p_rc_list = cell(1, length(beta_rc_rrc));
for i = 1:length(beta_rc_rrc)
    [p_rc, t_rc] = pulseShape('raised-cosine', fs, nSymbolSamples, beta_rc_rrc(i), spanInSymbol);
    p_rc_list{i} = p_rc;
    
    if beta_rc_rrc(i) == 0.5
        plot_pulse(t_rc, p_rc, 'Raised-Cosine (\beta=0.5)', Ts); 
    end
end

plot_freq(p_rc_list, fs, nfft, 'Raised-Cosine', beta_rc_rrc, Ts); 

p_rrc_list = cell(1, length(beta_rc_rrc));
for i = 1:length(beta_rc_rrc)
    [p_rrc, t_rrc] = pulseShape('rootraisedcosine', fs, nSymbolSamples, beta_rc_rrc(i), spanInSymbol);
    p_rrc_list{i} = p_rrc;
    
    if beta_rc_rrc(i) == 0.5
        plot_pulse(t_rrc, p_rrc, 'Root-Raised-Cosine (\beta=0.5)', Ts); 
    end
end

plot_freq(p_rrc_list, fs, nfft, 'Root-Raised-Cosine', beta_rc_rrc, Ts); 

p_gauss_list = cell(1, length(beta_gauss));
for i = 1:length(beta_gauss)
    [p_gauss, t_gauss] = pulseShape('gaussian', fs, nSymbolSamples, beta_gauss(i), spanInSymbol);
    p_gauss_list{i} = p_gauss;
    
    if beta_gauss(i) == 0.3
        plot_pulse(t_gauss, p_gauss, ['Gaussian (BT_s=' num2str(beta_gauss(i)) ')'], Ts); 
    end
end

plot_freq(p_gauss_list, fs, nfft, 'Gaussian', beta_gauss, Ts); 
disp('All pulses generated and plotted.');


function plot_pulse(t, p, pulseTitle, Ts)
    figure;
    t_normalized = t ./ Ts; 
    
    
    plot(t_normalized, p, 'b-', 'LineWidth', 1.5, 'DisplayName', 'Analog Pulse');
    hold on;
    
    stem(t_normalized, p, 'r', 'filled', 'MarkerSize', 4, 'DisplayName', 'Digital Pulse');
    grid on;
    xlabel('Time (normalized by T_s)');
    ylabel('Amplitude');
    title(['Time Response: ' pulseTitle]);
    legend;
    
    
    xlim([t_normalized(1) - 0.1, t_normalized(end) + 0.1]);
end

function plot_freq(p, fs, nfft, pulseTitle, betas, Ts)
    figure;
    hold on;
    
    
    f = linspace(-fs/2, fs/2, nfft);
    f_normalized = f .* Ts; 
    
    if ~iscell(p) 
        P_fft = fftshift(fft(p, nfft));
        plot(f_normalized, abs(P_fft), 'LineWidth', 1.5);
        legend(pulseTitle);
    else 
        colors = lines(length(p));
        legends = cell(1, length(p));
        for i = 1:length(p)
            P_fft = fftshift(fft(p{i}, nfft));
            plot(f_normalized, abs(P_fft), 'LineWidth', 1.5, 'Color', colors(i,:));
            legends{i} = [pulseTitle ', \beta = ' num2str(betas(i))];
        end
        legend(legends);
    end
    grid on;
    xlabel('Frequency (normalized by 1/T_s)');
    ylabel('Magnitude');
    title(['Frequency Response: ' pulseTitle]);
    
    
    xlim([-2, 2]); 
end
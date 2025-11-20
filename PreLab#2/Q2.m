clear;
clc;
close all;

A = 2;               
fs = 250e6;           
nPsd = 512;            
R = 50;             
f0_1 = (250e6 * 51.5) / 256;
f0_2 = (250e6 * 51) / 256;
frequencies = [f0_1, f0_2];

for i = 1:length(frequencies)
    f0 = frequencies(i);
    
    
    n = 0:nPsd-1; 
    x = A * exp(1j * 2 * pi * f0/fs * n);
    
    k0 = round(f0 * nPsd / fs); 
    X_ideal = corrSpctrm(A, k0, nPsd);
    
    X_fft = fft(x, nPsd);
    
    epsilon = 1e-20; 
    
    power_dbm_ideal = 10 * log10( (abs(X_ideal).^2 / (nPsd^2 * R)) * 1000 + epsilon);
    power_dbm_fft = 10 * log10( (abs(X_fft).^2 / (nPsd^2 * R)) * 1000 + epsilon);
    
    freq_axis = linspace(-fs/2, fs/2, nPsd);
    
    figure; 
    plot(freq_axis/1e6, fftshift(power_dbm_ideal), 'r', 'LineWidth', 4);
    hold on;
    plot(freq_axis/1e6, fftshift(power_dbm_fft), 'b--' , 'LineWidth', 2);
    hold off;
    
    grid on;
    title(['Spectrum Comparison for f_0 = ' num2str(f0/1e6) ' MHz']);
    xlabel('Frequency (MHz)');
    ylabel('Power (dBm)');
    legend('Theoretical Spectrum', 'FFT Spectrum');
    ylim([-100, 30]); 
end


function [X] = corrSpctrm(A, k0, nPsd)
    X = zeros(1, nPsd);
    X(k0 + 1) = A * nPsd;
end
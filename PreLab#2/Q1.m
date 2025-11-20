
clear;
clc;
close all;

%% Exercise 2:

N = 8;                 
nfft = 128^2;           


W = dftmtx(N);

h1 = W(1, :);

h2 = W(2, :);
h3 = W(6, :);

[H1, w] = freqz(h1, 1, nfft);
[H2, ~] = freqz(h2, 1, nfft); 
[H3, ~] = freqz(h3, 1, nfft);

figure(1);
plot(w/pi, 20*log10(abs(H1)), 'b', 'LineWidth', 1.5);
hold on;
plot(w/pi, 20*log10(abs(H2)), 'r', 'LineWidth', 1.5);
plot(w/pi, 20*log10(abs(H3)), 'g', 'LineWidth', 1.5);
hold off;

title('Magnitude Response of FIR Filters from DFT Matrix Rows');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Magnitude (dB)');
legend('Filter 1 (Row 1, k=0)', 'Filter 2 (Row 2, k=1)', 'Filter 3 (Row 6, k=5)');
grid on;
axis([0 1 -60 40]); 

figure(2);
plot(w/pi, rad2deg(angle(H1)), 'b', 'LineWidth', 1.5);
hold on;
plot(w/pi, rad2deg(angle(H2)), 'r', 'LineWidth', 1.5);
plot(w/pi, rad2deg(angle(H3)), 'g', 'LineWidth', 1.5);
hold off;

title('Phase Response of FIR Filters from DFT Matrix Rows');
xlabel('Normalized Frequency (\times\pi rad/sample)');
ylabel('Phase (degrees)');
legend('Filter 1 (Row 1, k=0)', 'Filter 2 (Row 2, k=1)', 'Filter 3 (Row 6, k=5)');
grid on;
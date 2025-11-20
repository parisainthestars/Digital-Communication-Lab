clear; clc; close all;

EbNo_dB = 0:1:10;         
EbNo_linear = 10.^(EbNo_dB / 10);

q_func = @(x) 0.5 * erfc(x / sqrt(2));

M_4 = 4;
k_4 = log2(M_4);
ber_theory_4psk = q_func(sqrt(2 * EbNo_linear));

M_8 = 8;
k_8 = log2(M_8);
ber_theory_8psk = (2/k_8) * q_func(sin(pi/M_8) * sqrt(2 * k_8 * EbNo_linear));

M_16 = 16;
k_16 = log2(M_16);
ber_theory_16psk = (2/k_16) * q_func(sin(pi/M_16) * sqrt(2 * k_16 * EbNo_linear));


ber_matlab_4psk = berawgn(EbNo_dB, 'psk', 4, 'nondiff');
ber_matlab_8psk = berawgn(EbNo_dB, 'psk', 8, 'nondiff');
ber_matlab_16psk = berawgn(EbNo_dB, 'psk', 16, 'nondiff');

figure;
semilogy(EbNo_dB, ber_theory_4psk, 'b-', 'LineWidth', 1.5, 'DisplayName', '4-PSK (Theory)');
hold on;
semilogy(EbNo_dB, ber_theory_8psk, 'r-', 'LineWidth', 1.5, 'DisplayName', '8-PSK (Theory)');
semilogy(EbNo_dB, ber_theory_16psk, 'g-', 'LineWidth', 1.5, 'DisplayName', '16-PSK (Theory)');

semilogy(EbNo_dB, ber_matlab_4psk, 'b--', 'LineWidth', 1.5, 'DisplayName', '4-PSK (berawgn)');
semilogy(EbNo_dB, ber_matlab_8psk, 'r--', 'LineWidth', 1.5, 'DisplayName', '8-PSK (berawgn)');
semilogy(EbNo_dB, ber_matlab_16psk, 'g--', 'LineWidth', 1.5, 'DisplayName', '16-PSK (berawgn)');

title('Bit Error Rate (BER) for M-PSK Modulation');
xlabel('E_b/N_0 (dB)');
ylabel('Bit Error Rate (BER)');
legend('show', 'Location', 'southwest');
grid on;
ylim([10^-5 10^0]);
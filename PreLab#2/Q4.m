clear; clc; close all;

alpha_vec = linspace(0, 0.0025, 201);
phi_vec = linspace(-0.0025, 0.0025, 201); % Phi in radians
[A, P] = meshgrid(alpha_vec, phi_vec);


numerator = 1 - 2*(1+A).*cos(P) + (1+A).^2;
denominator = 1 + 2*(1+A).*cos(P) + (1+A).^2;
ispr = numerator ./ denominator;

ispr_db = 10*log10(ispr);

figure;
contourf(A, rad2deg(P), ispr_db, -100:1:-40);
h = colorbar;
ylabel(h, 'Image Rejection Ratio (dB)');
hold on;

[c, ~] = contour(A, rad2deg(P), ispr_db, [-60, -60], 'r', 'LineWidth', 3);
hold off;

xlabel('Amplitude Imbalance (\alpha)');
ylabel('Phase Imbalance (\phi) [degrees]');
title('Acceptable Region for >= 60 dB Image Rejection');
grid on;
legend('-60 dB Boundary');


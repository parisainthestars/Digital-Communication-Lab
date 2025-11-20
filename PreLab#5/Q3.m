clear;
clc;
close all;

alpha_vec = 0.05:0.1:1; 
phi_vec = 0:pi/10:2*pi;    

A_over_sigma = 5;

% the Grid 
[alpha_grid, phi_grid] = meshgrid(alpha_vec, phi_vec);

% Prob. of Error
arg = alpha_grid .* A_over_sigma .* sqrt(2) .* cos(phi_grid);

Pe_log = log10(qfunc(arg));

% Plot the 3D Surface
figure;
surf(alpha_grid, phi_grid, Pe_log);

xlabel('\alpha (Attenuation)');
ylabel('\phi (Phase Error in radians)');
zlabel('log_{10}(P_e) (Log of Error Probability)');
title('BER vs. Channel Attenuation and Phase Error');
colorbar; 
shading interp; 

yticks(0:pi/2:2*pi);
yticklabels({'0', '\pi/2', '\pi', '3\pi/2', '2\pi'});

disp('3D plot generated.');
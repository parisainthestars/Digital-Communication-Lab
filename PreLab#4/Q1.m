clear; clc; close all;

M = 8;
modulation_type = 'pam';

[cons, E_avg] = constellation(M, modulation_type);

disp(['Average Energy of ' num2str(M) '-' modulation_type ' is: ' num2str(E_avg)]);

scatterplot(cons);
title([num2str(M) '-' upper(modulation_type) ' Constellation (Normalized)']);
grid on;
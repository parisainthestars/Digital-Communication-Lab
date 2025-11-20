
% Method 1: fplot (Adaptive step size)
figure; 
f = @(x) sin(1./x.^2); 
fplot(f);
title('Plot using fplot (Correct)');
axis([-2 2 -2 2]); 
grid on;

% Method 2: plot with small step size (0.001)
figure;
x_fine = -2:0.001:2;
y_fine = sin(1./x_fine.^2);
plot(x_fine, y_fine);
title('Plot using plot (step = 0.001) (Better)');
axis([-2 2 -2 2]);
grid on;

% Method 3: plot with large step size (0.1)
figure;
x_coarse = -2:0.1:2;
y_coarse = sin(1./x_coarse.^2);
plot(x_coarse, y_coarse);
title('Plot using plot (step = 0.1) (Incorrect/Misleading)');
axis([-2 2 -2 2]);
grid on;